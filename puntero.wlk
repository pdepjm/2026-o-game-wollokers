import wollok.game.*
import mapa.*

object puntero {

    var property position = game.at(8,4)
    method image() = "cursor.png"
    method esPesadilla() = false

    method moverA(nuevaPosicion) {
        if (mapa.estaDentroDelTablero(nuevaPosicion)) {
            position = nuevaPosicion
        }
    }
}