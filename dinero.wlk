import wollok.game.*

object dinero {


    var property cantidad = 350
    method position() = game.at(14, 9)
    method text() = "🌙 = " + cantidad.toString()
    method textColor() = "FFFFFFFF"
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

object precios{
    method ponerPrecios(x, y, cantidad) {
        const cartelNuevo = new PrecioVisual(
            position = game.at(x, y),
            cantidad = cantidad
        )
        game.addVisual(cartelNuevo)
    }
}

class PrecioVisual {
    var property position
    const cantidad
    method text() = "🌙" + cantidad.toString() 
    method textColor() = "FFFFFFFF" 
    method esPesadilla() = false
}