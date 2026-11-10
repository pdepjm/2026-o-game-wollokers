
import wollok.game.*

object pantallaInicio {
    method image() = "pantallaInicio.png"
    method position() = game.center()
    method esPesadilla() = false
}

object estadoInicio {
    var inicioCerrado = false
    
    method cerrar() {
        if (not inicioCerrado) {
            game.removeVisual(pantallaInicio)
            inicioCerrado = true
        }
    }

    method estaCerrado() = inicioCerrado
}