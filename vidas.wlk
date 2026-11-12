import wollok.game.*
import mapa.*

object contadorDeVidas {
    var property vidas = 10

    method position() = game.at(15, 8)
    method text() = "❤️ = " + vidas.toString()
    method textColor() = "FFFFFFFF"

    method perderVida() {
        if (vidas > 0) {
            vidas -= 1

            if (vidas == 0) {
                game.removeVisual(instrucciones)
                game.addVisual(pantallaDerrota)
            }
        }
    }

    method sinVidas() = vidas <= 0
    method esPesadilla() = false
}

object pantallaDerrota {
    method position() = game.origin()
    method image() = "pantallaDerrota.png"
    method esPesadilla() = false
}

object pantallaVictoria {
    method position() = game.origin()
    method image() = "pantallaVictoria.png"
    method esPesadilla() = false
}