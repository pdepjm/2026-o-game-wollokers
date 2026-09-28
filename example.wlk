import wollok.game.*


class Mono{
  const numero
  const costo
  const disparoVel
  method image() = "mono" + numero.toString() + ".png"
  var property position = game.center()
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

