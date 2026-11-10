import wollok.game.*

object contadorDeVidas {
    var property vidas = 10

    method position() = game.at(14, 8)
    method text() = "❤️ = " + vidas.toString()

    method textColor() = "FFFFFFFF"
    
    method perderVida() {
        if (vidas > 0) {
            vidas -= 1
            if (vidas == 0) {
                game.addVisual(pantallaGameOver)
            }
        }
    }
    method sinVidas() = vidas <= 0
    method esPesadilla() = false
}


object pantallaGameOver {
    method position() = game.center()
    method text() = "GAME OVER"
    method esPesadilla() = false
}