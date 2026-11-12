import wollok.game.*
import pesadillas.*
import mapa.*
import dinero.*
import vidas.*

// CLASE BASE
class ProtectorDeSuenos {
    var property position = game.center()

    // Métodos para los hijos
    method image()
    method costo()
    method danio()
    method radioAtaque()
    method cooldown()
    method atacar()
    method puedeAtacar(pesadilla)

    // Identificación de tipos
    method esPesadilla() = false
    method esOveja() = false
    method esPerroGuardian() = false
    method esLamparaProtectora() = false
    method esPastorDeSuenos() = false

    // Devuelve el 50% del precio original
    method precioDeVenta() = self.costo().div(2)

    // Comprueba si una pesadilla está dentro del rango
    method estaEnRango(pesadilla) {
        const distanciaX =
            position.x() - pesadilla.position().x()
        const distanciaY =
            position.y() - pesadilla.position().y()
        return distanciaX * distanciaX +
               distanciaY * distanciaY
               <= self.radioAtaque() * self.radioAtaque()
    }

    // Devuelve las pesadillas en rango que puede dañar

    method objetivosEnRango() {
        return gestorDePesadillas.activos().filter({
            pesadilla =>
                self.estaEnRango(pesadilla) &&
                self.puedeAtacar(pesadilla)
        })
    }

    // Método para atacar un único objetivo
    method daniarPrimerObjetivo(objetivos) {
        if (not objetivos.isEmpty()) {
            objetivos.first().recibirDanio(self.danio())
        }
    }

    // Ciclo de ataques
    method iniciarAtaques() {
        self.atacar()
        if (gestorDeProtectores.activos().contains(self)) {
            self.programarAtaque()
        }
    }

    // Programa un ataque después del cooldown
    method programarAtaque() {
        game.schedule(self.cooldown(), {
            =>
            if (
                gestorDeProtectores.activos().contains(self) &&
                not contadorDeVidas.sinVidas()
            ) {
                self.atacar()
                if (gestorDeProtectores.activos().contains(self)) {
                    self.programarAtaque()
                }
            }
        })
    }

    // Elimina al protector
    method destruir() {
        gestorDeProtectores.eliminar(self)
        game.removeVisual(self)
    }
}


class Oveja inherits ProtectorDeSuenos {
    override method image() = "oveja.png"
    override method costo() = 70
    override method danio() = 1
    override method radioAtaque() = 2
    override method cooldown() = 1400
    override method esOveja() = true

    override method puedeAtacar(pesadilla) =
        not pesadilla.esCamuflada()
    // Ataca solamente a un enemigo por vez
    override method atacar() {
        self.daniarPrimerObjetivo(self.objetivosEnRango())
    }
}


class PerroGuardian inherits ProtectorDeSuenos {
    override method image() = "perroGuardian.png"
    override method costo() = 120
    override method danio() = 1
    override method radioAtaque() = 2.5
    override method cooldown() = 800
    override method esPerroGuardian() = true
    override method puedeAtacar(pesadilla) = true
    
    // Prioriza las pesadillas camufladas
    override method atacar() {
        const objetivos = self.objetivosEnRango()
        const camufladas = objetivos.filter({
            pesadilla => pesadilla.esCamuflada()
        })
        if (not camufladas.isEmpty()) {
            self.daniarPrimerObjetivo(camufladas)
        } else {
            self.daniarPrimerObjetivo(objetivos)
        }
    }
}


class LamparaProtectora inherits ProtectorDeSuenos {
    override method image() = "lamparaProtectora.png"
    override method costo() = 160
    override method danio() = 4
    override method radioAtaque() = 3
    override method cooldown() = 500
    override method esLamparaProtectora() = true
    override method puedeAtacar(pesadilla) =
        not pesadilla.esGrande()

    // Daña a todos los enemigos compatibles en su rango
    // Despues se autodestruye
    override method atacar() {
        const objetivos = self.objetivosEnRango()
        if (not objetivos.isEmpty()) {
            objetivos.forEach({
                pesadilla =>
                    pesadilla.recibirDanio(self.danio())
            })
            self.destruir()
        }
    }
}


class PastorDeSuenos inherits ProtectorDeSuenos {
    override method image() = "pastorDeSuenos.png"
    override method costo() = 230
    override method danio() = 1
    override method radioAtaque() = 4
    override method cooldown() = 3500
    override method esPastorDeSuenos() = true
    method duracionRalentizacion() = 1500
    override method puedeAtacar(pesadilla) = true

    // Daña a todos los enemigos dentro de su rango
    // y los ralentiza
    override method atacar() {
        const objetivos = self.objetivosEnRango()
        objetivos.forEach({
            pesadilla =>
                pesadilla.recibirDanio(self.danio())
                pesadilla.aplicarRalentizacion(
                    self.duracionRalentizacion()
                )
        })
    }
}

object gestorDeProtectores {
    const property activos = []
    method limite() = 10
    method cantidad() = activos.size()

    // Comprueba si ya existe un protector en la posición
    method hayProtectorEn(posicion) {
        return activos.any({
            protector =>
                game.onSameCell(
                    protector.position(),
                    posicion
                )
        })
    }

    // Comprueba si se puede colocar un protector
    method puedeColocarEn(posicion) {
        return
            self.cantidad() < self.limite() &&
            mapa.estaDentroDelTablero(posicion) &&
            not mapa.esCamino(posicion) &&
            not self.hayProtectorEn(posicion) &&
            not contadorDeVidas.sinVidas()
    }

    // Compra y coloca un protector
    method colocar(protector, posicion) {
        if (
            self.puedeColocarEn(posicion) &&
            dinero.puedePagar(protector.costo())
        ) {
            dinero.pagar(protector.costo())
            protector.position(posicion)
            activos.add(protector)
            game.addVisual(protector)
            protector.iniciarAtaques()
            true
        } else {
            false
        }
    }

    // Vende el protector ubicado en una posición
    method venderEn(posicion) {
        const encontrados = activos.filter({
            protector =>
                game.onSameCell(
                    protector.position(),
                    posicion
                )
        })
        if (not encontrados.isEmpty()) {
            const seleccionado = encontrados.first()
            activos.remove(seleccionado)
            game.removeVisual(seleccionado)
            dinero.ganar(seleccionado.precioDeVenta())
            true
        } else {
            false
        }
    }

    // Elimina un protector del gestor
    method eliminar(protector) {
        activos.remove(protector)
    }
}
