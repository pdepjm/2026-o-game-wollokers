import wollok.game.*

object dinero {
    var property cantidad = 350
    method position() = game.at(5, 63)
    method text() = "Dinero: " + cantidad.toString()

    method puedePagar(costo) = cantidad >= costo
    method pagar(costo) {
        if (self.puedePagar(costo)) {
            cantidad -= costo
        }
    }
    method ganar(monto) {
        cantidad += monto
    }
    method esPesadilla() = false
}