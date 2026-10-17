import wollok.game.*
import dinero.*

class Globo{
const numero 
var property velocidad //siempre escrita en milisegundos porfavor
var property direccion 
var property vivo = true 

method image() = "globo" + numero.toString() + ".png"

var property position = game.at(0,19)

// ahora se mueve solo si el globo esta vivo
 method avanzar(){
    if (vivo) { 

    position = direccion.proximaPosicion(position)
    game.schedule(velocidad, {self.avanzar()})
 }
}


 method pinchar(){
    if (vivo) {                         
        vivo = false                   
        gestorDeGlobos.eliminar(self)   
        game.removeVisual(self)       
        dinero.ganar(1)                
    }
 }



 method cambiarDireccion(globo) {
        globo.direccion(direccion)
    }
}


object gestorDeGlobos {
    const property activos = []
    method agregar(globo) { activos.add(globo) }
    method eliminar(globo) { activos.remove(globo) }
}


object derecha {
    method proximaPosicion(posicion) = posicion.right(1)
}

object izquierda {
    method proximaPosicion(posicion) = posicion.left(1)
}

object arriba {
    method proximaPosicion(posicion) = posicion.up(1)
}

object abajo {
    method proximaPosicion(posicion) = posicion.down(1)
}
