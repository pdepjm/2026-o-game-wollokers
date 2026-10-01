import wollok.game.*


class Mono {

  const numero
  const costo
  const disparoVel
  const radioAtaque

  method image() = "mono" + numero.toString() + ".png"

  var property position = game.center()

  method getDisparoVel() = disparoVel

  method getRadioAtaque() = radioAtaque
 
  method atacar(globos) {
      const globoObjetivo = globos.find({ globo =>
          self.estaEnRango(globo)
      })

      if (globoObjetivo != null) {
          game.removeVisual(globoObjetivo)
          globos.remove(globoObjetivo)
      }
  }

  method estaEnRango(globo) {
      const distanciaX = (position.x() - globo.position().x()).abs()
      const distanciaY = (position.y() - globo.position().y()).abs()

      return distanciaX <= radioAtaque && distanciaY <= radioAtaque
  }
}

class Globo{
const numero 
const velocidad
method image() = "globo" + numero.toString() + ".png"
var property position = game.at(0,3)
method avanzar() {position = position.right(velocidad)}

}

object cursor{
  var property position = game.center()
   method subir(){position = position.up(1)}
   method bajar(){position = position.down(1)}
   method izquierda(){position = position.left(1)}
   method derecha(){position = position.right(1)}
  method image() = "goat.png"
}

