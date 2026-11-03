import wollok.game.*
import pesadillas.*
import vidas.*

// CLASE BASE RONDA
class Ronda {
    var generadas = 0
    method cantidadDePesadillas()
    method intervaloGeneracion()
    method crearPesadilla(indice)
    method iniciarRonda() {
        generadas = 0
        self.generarSiguiente()
    }
    // Genera las pesadillas progresivamente
    method generarSiguiente() {
        if (not contadorDeVidas.sinVidas()) {
            if (generadas < self.cantidadDePesadillas()) {
                const nuevaPesadilla = self.crearPesadilla(generadas)
                nuevaPesadilla.iniciar()
                generadas += 1
                game.schedule(self.intervaloGeneracion(), {
                    => self.generarSiguiente()
                })
            } else {
                self.esperarFinalizacion()
            }
        }
    }
    // Espera hasta que todas las pesadillas desaparezcan
    method esperarFinalizacion() {
        if (
            contadorDeVidas.sinVidas() ||
            gestorDePesadillas.activos().isEmpty()
        ) {
            entreTiempo.terminarRonda()
        } else {
            game.schedule(500, {

                => self.esperarFinalizacion()
            })
        }
    }
}

// RONDA 1
class RondaUno inherits Ronda {
    override method cantidadDePesadillas() = 10
    override method intervaloGeneracion() = 2000
    override method crearPesadilla(indice) {
        new PesadillaPequena()
    }
}

// RONDA 2
class RondaDos inherits Ronda {
    override method cantidadDePesadillas() = 14
    override method intervaloGeneracion() = 1500
    override method crearPesadilla(indice) {
        if (indice < 8) {
            new PesadillaPequena()
        } else {
            new PesadillaCamuflada()
        }
    }
}

// RONDA 3
class RondaTres inherits Ronda {
    override method cantidadDePesadillas() = 18
    override method intervaloGeneracion() = 1200
    override method crearPesadilla(indice) {
        if (indice < 5) {
            new PesadillaPequena()
        } else if (indice < 12) {
            new PesadillaCamuflada()
        } else {
            new PesadillaGrande()
        }
    }
}

const listaDeRondas = [
    new RondaUno(),
    new RondaDos(),
    new RondaTres()
]


// CONTROL DE RONDAS
object entreTiempo {
    var rondaActual = 0
    var enRonda = false
    method espera() {
        keyboard.e().onPressDo({
            if (
                not enRonda &&
                rondaActual < listaDeRondas.size() &&
                not contadorDeVidas.sinVidas()
            ) {
                const rondaSiguiente = listaDeRondas.get(rondaActual)
                rondaActual += 1
                enRonda = true
                console.println(
                    "Inicio de la ronda: " + rondaActual.toString()
                )
                rondaSiguiente.iniciarRonda()
            }
        })
    }
    method terminarRonda() {
        enRonda = false
        console.println("Termino la ronda")
        if (rondaActual == listaDeRondas.size()) {
            console.println("Se completaron todas las rondas")
        }
    }
}