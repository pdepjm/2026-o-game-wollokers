import wollok.game.*


class Mono{
  const numero
  const costo
  const disparoVel
  const radio
  method image() = "mono" + numero.toString() + ".png"
  var property position = game.center()
}

class Globo{
const numero 
const velocidad
var property vida = 2
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
//Mono 1: dispara lentamente, pero tiene un radio de alcance grande.
//Mono 2: dispara rápidamente, pero tiene un radio de alcance pequeño.

object monoLento inherits Mono(
  numero = 1,
  costo = 100,
  disparoVel = 2,
  radio = 5
)

object monoRapido inherits Mono(
  numero = 2,
  costo = 200,
  disparoVel = 1,
  radio = 2
)

//golobos que se diferencian en velocidad y cantidad de vida 

object globoLento inherits Globo(
numero = 1, velocidad = 1 
)

object globoRapido inherits Globo(
numero = 2, velocidad = 2 
)







