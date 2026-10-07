import wollok.game.*

class Globo{
const numero 
const velocidad
method image() = "globo" + numero.toString() + ".png"
var property position = game.at(0,3)
method avanzar() {position = position.right(velocidad)}

}