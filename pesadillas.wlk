import wollok.game.*
import dinero.*
import vidas.*
import mapa.*


class Pesadilla {
    var property position = game.at(1,0)
    var indiceCamino = 0
    var property vidaActual = 1
    var property ralentizada = false
    var contadorRalentizacion = 0

    // Métodos redefinidos por los tipos de pesadilla
    method image()
    method vidaMaxima()
    method intervaloBase()
    method esPesadilla() = true
    method esCamuflada() = false
    method esGrande() = false
    method recompensa() = 0

    // Registra la pesadilla y comienza su movimiento
    method iniciar() {
        vidaActual = self.vidaMaxima()
        indiceCamino = 0
        position = mapa.posicionDelCamino(indiceCamino)
        gestorDePesadillas.agregar(self)
        game.addVisual(self)
        self.programarMovimiento()
    }


    // Programa el siguiente movimiento
    method programarMovimiento() {

        if (
            self.estaActiva() &&
            not contadorDeVidas.sinVidas()
        ) {

            game.schedule(self.intervaloMovimiento(), {
                => self.avanzar()
            })
        }
    }


    // Avanza a la siguiente coordenada del recorrido
    method avanzar() {
        if (
            self.estaActiva() &&
            not contadorDeVidas.sinVidas()
        ) {
            if (indiceCamino < mapa.ultimoIndiceDelCamino()) {
                indiceCamino += 1
                position = mapa.posicionDelCamino(indiceCamino)
            // Si llegó a la última casilla, pierde una vida
               if (
                    indiceCamino ==
                    mapa.ultimoIndiceDelCamino()
                ) {
                    self.llegarAlFinal()
                } else {
                    self.programarMovimiento()
                }
            }
        }
    }

    // Comprueba si la pesadilla sigue viva
    method estaActiva() = gestorDePesadillas.activos().contains(self)

    // Calcula el intervalo de movimiento considerando la ralentización
    method intervaloMovimiento() =
        if (ralentizada)
            self.intervaloBase() * 2
        else
            self.intervaloBase()


    // Aplica ralentización durante una cantidad determinada de milisegundos
    method aplicarRalentizacion(duracion) {
        if (self.estaActiva()) {
            contadorRalentizacion += 1
            const marcaActual = contadorRalentizacion
            ralentizada = true
            game.schedule(duracion, {
                =>
                if (marcaActual == contadorRalentizacion) {
                    ralentizada = false
                }
            })
        }
    }

    // Recibe daño de un protector
    method recibirDanio(cantidad) {
        if (self.estaActiva()) {
            vidaActual -= cantidad

            if (vidaActual <= 0) {
                dinero.ganar(self.recompensa())
                self.eliminar()
            }
        }
    }

    // La pesadilla llegó al final
    method llegarAlFinal() {
        if (self.estaActiva()) {
            contadorDeVidas.perderVida()
            self.eliminar()
        }
    }

    // Elimina la pesadilla del juego y del gestor
    method eliminar() {
        gestorDePesadillas.eliminar(self)
        game.removeVisual(self)
    }
}


class PesadillaPequena inherits Pesadilla {
    override method image() = "pesadillaPequena.png"
    override method vidaMaxima() = 5
    override method intervaloBase() = 700
    override method recompensa() = 8
}

class PesadillaCamuflada inherits Pesadilla {
    override method image() = "pesadillaCamuflada.png"
    override method vidaMaxima() = 9
    override method intervaloBase() = 700
    override method recompensa() = 14
    override method esCamuflada() = true
}


class PesadillaGrande inherits Pesadilla {
    override method image() = "pesadillaGrande.png"
    override method vidaMaxima() = 20
    override method intervaloBase() = 1100
    override method recompensa() = 28
    override method esGrande() = true
}

object gestorDePesadillas {
    const property activos = []

    method agregar(pesadilla) {
        activos.add(pesadilla)
    }
    method eliminar(pesadilla) {
        activos.remove(pesadilla)
    }
}