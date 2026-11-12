import wollok.game.*
import pesadillas.*
import vidas.*
import pantallaInicio.*
import mapa.*

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
                
                game.schedule(self.intervaloGeneracion(), { self.generarSiguiente() })
            } else {
                self.esperarFinalizacion()
            }
        }
    }

    // Espera hasta que todas las pesadillas desaparezcan
    method esperarFinalizacion() {
        if (contadorDeVidas.sinVidas() or gestorDePesadillas.activos().isEmpty()) {
            entreTiempo.terminarRonda()
        } else {
            game.schedule(500, { self.esperarFinalizacion() })
        }
    }
}

// RONDA 1
object rondaUno inherits Ronda {
    override method cantidadDePesadillas() = 10
    override method intervaloGeneracion() = 2500
    override method crearPesadilla(indice) = new PesadillaPequena()
}

// RONDA 2
object rondaDos inherits Ronda {
    override method cantidadDePesadillas() = 14
    override method intervaloGeneracion() = 2200
    override method crearPesadilla(indice) =
        if (indice < 8)
            new PesadillaPequena()
        else
            new PesadillaCamuflada()
}

// RONDA 3
object rondaTres inherits Ronda {
    override method cantidadDePesadillas() = 18
    override method intervaloGeneracion() = 2000
    override method crearPesadilla(indice) =
        if (indice < 5)
            new PesadillaPequena()
        else if (indice < 12)
            new PesadillaCamuflada()
        else
            new PesadillaGrande()
}

// CONTROL DE RONDAS
object entreTiempo {
    var enRonda = false
    method espera() {
        keyboard.e().onPressDo({
            if (
                not enRonda &&
                estadoInicio.estaCerrado() &&
                gestorDeRondas.hayMasRondas() &&
                not contadorDeVidas.sinVidas()
            ) {
                enRonda = true
                gestorDeRondas.iniciarSiguienteRonda()
            }
        })
    }

    method terminarRonda() {
        enRonda = false
        console.println("Termino la ronda")

        if (not gestorDeRondas.hayMasRondas()) {
            console.println("Se completaron todas las rondas")

            if (not contadorDeVidas.sinVidas()) {
                game.removeVisual(instrucciones)
                game.addVisual(pantallaVictoria)
            }
        }
    }
}

// OBJETO GESTOR DE RONDAS
object gestorDeRondas {
    const rondas = [
        rondaUno,
        rondaDos,
        rondaTres
    ]
    var indiceRondaActual = 0

    method hayMasRondas() =
        indiceRondaActual < rondas.size()

    method numeroRondaActual() =
        indiceRondaActual

    method iniciarSiguienteRonda() {
        if (self.hayMasRondas()) {
            const rondaActual =
                rondas.get(indiceRondaActual)

            indiceRondaActual += 1
            console.println(
                "Inicio de la ronda: " +
                indiceRondaActual.toString()
            )
            rondaActual.iniciarRonda()
        }
    }
}

object indicadorRonda {

    method position() = game.at(15,7)

    method text() =
        "Ronda: " +
        gestorDeRondas.numeroRondaActual().toString() +
        "/3"

    method textColor() = "FFFFFFFF"

    method esPesadilla() = false
}

