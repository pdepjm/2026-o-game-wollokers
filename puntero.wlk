import wollok.game.*

object puntero{
  var property position = game.center()
   method subir(){position = position.up(1)}
   method bajar(){position = position.down(1)}
   method izquierda(){position = position.left(1)}
   method derecha(){position = position.right(1)}
  method image() = "goat.png"
}
