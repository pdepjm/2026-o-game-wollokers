import wollok.game.*

object contadorDeVidas {

    // 10 para probar
    var property vidas = 10

    method position() = game.at(5, 67)
    method text() = "Vidas: " + vidas.toString()
    method perderVida() {
        if (vidas > 0) {
            vidas -= 1
            if (vidas == 0) {
                game.addVisual(pantallaGameOver)
            }
        }
    }

    method sinVidas() = vidas <= 0
}

object pantallaGameOver {
    method position() = game.center()
    method text() = "GAME OVER"
}