import globos.*
import wollok.game.*
import vidas.*

class Flecha {
    var property position
    const direccion
    var property image

    method cambiarDireccion(globo) {
        globo.direccion(direccion)
    }
}

class CasillaFinal {
    var property position
    var property image

    method chocarCon(globo) {
        contadorDeVidas.perderVida()
        globo.vivo(false)
        gestorDeGlobos.eliminar(globo)
        game.removeVisual(globo)
    }
}


object armarFlechas {

    method armarMapa1() {
        self.colocarFlechas(64,19,abajo, "flechaAbajo.png")
        self.colocarFlechas(64,9,derecha, "flechaDerecha.png")
        self.colocarFlechas(114,9, arriba, "flechaArriba.png")
        self.colocarFlechas(114,35,izquierda,"flechaIzquierda.png")
        self.colocarFlechas(97,35,abajo,"flechaAbajo.png")
        self.colocarFlechas(97,19,izquierda,"flechaIzquierda.png")
        self.colocarFlechas(81,19,arriba,"flechaArriba.png")
        self.colocarFlechas(81,44,izquierda,"flechaIzquierda.png")
        self.colocarFlechas(67,44,abajo,"flechaAbajo.png")
        self.colocarFlechas(67,32,izquierda,"flechaIzquierda.png")
        self.colocarFlechas(55,32,arriba,"flechaArriba.png")
        self.colocarFlechas(55,44,izquierda,"flechaIzquierda.png")
        self.colocarFlechas(41,44,abajo,"flechaAbajo.png")
        self.colocarFlechas(41,32,izquierda,"flechaIzquierda.png")
        self.colocarFlechas(25,32,arriba,"flechaArriba.png")
        self.colocarFlechas(25,59,derecha,"flechaDerecha.png")
        self.colocarFlechas(95,59,abajo,"flechaAbajo.png")
        self.colocarFlechas(95,49,derecha,"flechaDerecha.png")
        self.colocarFlechas(113,49,arriba,"flechaArriba.png")
        self.colocarFinal(113,65)
    }


    method colocarFlechas(x, y, apunta, imagen) {
        const nuevaFlecha = new Flecha(
            position = game.at(x,y),
            direccion = apunta,
            image = imagen
        )

        game.addVisual(nuevaFlecha)
        game.onCollideDo(nuevaFlecha, {
            globo => nuevaFlecha.cambiarDireccion(globo)
        })
    }

    method colocarFinal(x,y) {
        const nuevoFinal = new CasillaFinal(
            position = game.at(x,y),
            image = "final.png"
        )

        game.addVisual(nuevoFinal)
        game.onCollideDo(nuevoFinal, {
            globo => nuevoFinal.chocarCon(globo)
        })
    }
}