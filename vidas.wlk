import wollok.game.*

object contadorDeVidas {
    var property vidas = 100 
    method position() = game.at(5, 67) 
    method text() = "Vidas: " + vidas.toString()

}