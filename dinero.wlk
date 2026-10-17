import wollok.game.*

object dinero {
    var property cantidad = 999
    method position() = game.at(5, 63)  
    method text() = "Dinero: " + cantidad.toString()

    method puedePagar(costo) = cantidad >= costo
    method pagar(costo) { cantidad -= costo }
    method ganar(monto) { cantidad += monto }
}
