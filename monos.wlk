import wollok.game.*
import globos.*

class Mono {

  var property position = game.center()

  method costo() = 1
  method disparoVel() = 1000
  method radioAtaque() = 10
  method image() = "mono1.png"

  method estaEnRango(globo) {

    const distanciaX = position.x() - globo.position().x()
    const distanciaY = position.y() - globo.position().y()

    return distanciaX * distanciaX + distanciaY * distanciaY
      <= self.radioAtaque() * self.radioAtaque()
  }

  method atacar() {

    const globosEnRango = gestorDeGlobos.activos().filter({
      globo => self.estaEnRango(globo)
    })

    if (not globosEnRango.isEmpty()) {
      globosEnRango.first().pinchar()
    }
  }

  method iniciarAtaque() {

    game.schedule(self.disparoVel(), {

      self.atacar()

      self.iniciarAtaque()
    })
  }
}

class MonoRapido inherits Mono {

  override method disparoVel() = 500

  override method radioAtaque() = 10

  override method image() = "mono1.png"
}

class MonoLejano inherits Mono {

  override method disparoVel() = 2000

  override method radioAtaque() = 25

  override method image() = "mono2.png"
}