import wollok.game.*
import dinero.*

class Visuales{
    var property position
    var property image
}

object mapa {
    // Comprueba que la posición esté dentro del tablero
    method estaDentroDelTablero(posicion) {
        return posicion.x().between(0,139) &&
               posicion.y().between(0,69)
    }

    // Comprueba si una posición pertenece al camino
    method esCamino(posicion) {
        return
            self.esHorizontal(posicion, 0, 64, 19) ||
            self.esVertical(posicion, 64, 9, 19) ||
            self.esHorizontal(posicion, 64, 114, 9) ||
            self.esVertical(posicion, 114, 9, 35) ||
            self.esHorizontal(posicion, 97, 114, 35) ||
            self.esVertical(posicion, 97, 19, 35) ||
            self.esHorizontal(posicion, 81, 97, 19) ||
            self.esVertical(posicion, 81, 19, 44) ||
            self.esHorizontal(posicion, 67, 81, 44) ||
            self.esVertical(posicion, 67, 32, 44) ||
            self.esHorizontal(posicion, 55, 67, 32) ||
            self.esVertical(posicion, 55, 32, 44) ||
            self.esHorizontal(posicion, 41, 55, 44) ||
            self.esVertical(posicion, 41, 32, 44) ||
            self.esHorizontal(posicion, 25, 41, 32) ||
            self.esVertical(posicion, 25, 32, 59) ||
            self.esHorizontal(posicion, 25, 95, 59) ||
            self.esVertical(posicion, 95, 49, 59) ||
            self.esHorizontal(posicion, 95, 113, 49) ||
            self.esVertical(posicion, 113, 49, 65)
    }

    // Tramos horizontales
    method esHorizontal(posicion, xInicio, xFin, y) {
        return posicion.y() == y &&
               posicion.x().between(xInicio, xFin)
    }

    // Tramos verticales
    method esVertical(posicion, x, yInicio, yFin) {
        return posicion.x() == x &&
               posicion.y().between(yInicio, yFin)
    }
}

object interfazGenerador{
    method colocarInterfaz(){

        self.colocarVisuales(127, 42, "pastorDeSuenos.png")
        precios.ponerPrecios(130, 42, 230)
        self.colocarVisuales(127,30,"lamparaProtectora.png")
        precios.ponerPrecios(130, 30, 160)
        self.colocarVisuales(127,18,"oveja.png")
        precios.ponerPrecios(127,18,70)
        self.colocarVisuales(127,2, "perroGuardian.png")
        precios.ponerPrecios(130, 2, 120)
}


   method colocarVisuales(x, y, imagen){
        const nuevoVisual = new Visuales(
            position = game.at(x,y),
            image = imagen
        )
        game.addVisual(nuevoVisual)
    }
}