import wollok.game.*
import dinero.*
import vidas.*


class Pesadilla {
    var property position = game.at(10,0)
    var property direccion = arriba
    var property vidaActual = 1
    var property ralentizada = false
    var contadorRalentizacion = 0

    // Métodos redefinidos por los tipos de pesadilla
    method image()
    method vidaMaxima()
    method intervaloBase()
    method puedeRecibirDanioDe(protector)
    method esPesadilla() = true
    method esCamuflada() = false
    method esGrande() = false
    method recompensa() = 0

    // Registra la pesadilla y empieza a moverla
    method iniciar() {
        vidaActual = self.vidaMaxima()
        gestorDePesadillas.agregar(self)
        game.addVisual(self)
        self.avanzar()
    }

    // Comprueba si la pesadilla sigue viva
    method estaActiva() = gestorDePesadillas.activos().contains(self)

    // Movimiento automático
    method avanzar() {
        if (self.estaActiva() && not contadorDeVidas.sinVidas()) {
            position = direccion.proximaPosicion(position)
            game.schedule(self.intervaloMovimiento(), {
                => self.avanzar()
            })
        }
    }

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
    method recibirDanio(cantidad, protector) {
        if (
            self.estaActiva() &&
            self.puedeRecibirDanioDe(protector)
        ) {
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
    override method vidaMaxima() = 2
    override method intervaloBase() = 500
    override method recompensa() = 8
    override method puedeRecibirDanioDe(protector) = true
}

class PesadillaCamuflada inherits Pesadilla {
    override method image() = "pesadillaCamuflada.png"
    override method vidaMaxima() = 4
    override method intervaloBase() = 500
    override method recompensa() = 14
    override method esCamuflada() = true

    // Solamente puede recibir daño del perro,
    // de la lámpara y del pastor
    override method puedeRecibirDanioDe(protector) =
        protector.esPerroGuardian() ||
        protector.esLamparaProtectora() ||
        protector.esPastorDeSuenos()
}


class PesadillaGrande inherits Pesadilla {
    override method image() = "pesadillaGrande.png"
    override method vidaMaxima() = 12
    override method intervaloBase() = 900
    override method recompensa() = 28
    override method esGrande() = true

    // Es inmune a la lámpara protectora
    override method puedeRecibirDanioDe(protector) =
        protector.esOveja() ||
        protector.esPerroGuardian() ||
        protector.esPastorDeSuenos()
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

object derecha {
    method proximaPosicion(posicion) = posicion.right(1)
}

object izquierda {
    method proximaPosicion(posicion) = posicion.left(1)
}

object arriba {
    method proximaPosicion(posicion) = posicion.up(1)
}

object abajo {
    method proximaPosicion(posicion) = posicion.down(1)
}