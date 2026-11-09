import wollok.game.*
import pesadillas.*
import mapa.*
import dinero.*
import protectores.*

// FLECHAS
class Flecha {
    var property position
    const direccion
    var property image
    method esPesadilla() = false
    method cambiarDireccion(pesadilla) {
        pesadilla.direccion(direccion)
    }
}

// CASILLA FINAL
class CasillaFinal {
    var property position
    var property image
    method esPesadilla() = false
    method chocarCon(objeto) {
        if (objeto.esPesadilla()) {
            objeto.llegarAlFinal()
        }
    }
}

// MAPA
object flechero {
    method armarMapa1() {
        self.colocarFlechas(10,28,derecha,"flechaDerecha.png")
        self.colocarFlechas(28,28,arriba,"flechaArriba.png")
        self.colocarFlechas(28,56,derecha,"flechaDerecha.png")
        self.colocarFlechas(63,56,abajo, "flechaAbajo.png")
        self.colocarFlechas(63,45,izquierda,"flechaIzquierda.png")
        self.colocarFlechas(45,43,abajo,"flechaAbajo.png")
        self.colocarFlechas(45,2,derecha,"flechaDerecha.png")
        self.colocarFlechas(107,2,arriba,"flechaArriba.png")
        self.colocarFlechas(107,14,izquierda,"flechaIzquierda.png")
        self.colocarFlechas(81,14,arriba,"flechaArriba.png")
        self.colocarFlechas(81,35,derecha,"flechaDerecha.png")
        self.colocarFlechas(97,35,arriba,"flechaArriba.png")
        self.colocarFlechas(97,56,derecha, "flechaDerecha.png")
        self.colocarFinal(116,56)
        interfazGenerador.colocarInterfaz()
        
    }

    method colocarFlechas(x, y, apunta, imagen) {
        const nuevaFlecha = new Flecha(
            position = game.at(x,y),
            direccion = apunta,
            image = imagen
        )
        game.addVisual(nuevaFlecha)
        game.onCollideDo(nuevaFlecha, {
            objeto =>
                if (objeto.esPesadilla()) {
                    nuevaFlecha.cambiarDireccion(objeto)
                }
        })
    }

    method colocarFinal(x,y) {
        const nuevoFinal = new CasillaFinal(
            position = game.at(x,y),
            image = "end.png"
        )
        game.addVisual(nuevoFinal)
        game.onCollideDo(nuevoFinal, {
            objeto =>
                if (objeto.esPesadilla()) {
                    nuevoFinal.chocarCon(objeto)
                }
        })
    }

    
    
}