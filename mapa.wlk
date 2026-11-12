import wollok.game.*
import dinero.*

class Visuales{
    var property position
    var property image
}

object instrucciones{
    var property  position = game.at(15,2)
    var property text = "E: Iniciar Ronda
            1: Oveja
            2: Perro Guardian
            3: Lampara Protectora
            4: Pastor de Sueño
            0: Vender Protector"
    var property color = "FFFFFFFF"

}




object mapa {
    const matrizCamino = [
        // Fila 0
        [
            false,false,false,false,
            false,false,false,false,
            false,false,false,false,
            false,false
        ],
        // Fila 1
        [
            false,false,false,true,
            true,true,true,true,
            false,false,false,true,
            true,true
        ],
        // Fila 2
        [
            false,false,false,true,
            false,false,false,true,
            false,false,false,true,
            false,false
        ],
        // Fila 3
        [
            false,false,false,true,
            false,true,true,true,
            false,false,false,true,
            false,false
        ],
        // Fila 4
        [
            false,false,false,true,
            false,true,false,false,
            false,true,true,true,
            false,false
        ],
        // Fila 5
        [
            false,true,true,true,
            false,true,false,false,
            false,true,false,false,
            false,false
        ],
        // Fila 6
        [
            false,true,false,false,
            false,true,false,false,
            false,true,false,false,
            false,false
        ],
        // Fila 7
        [
            false,true,false,false,
            false,true,false,false,
            false,true,true,true,
            true,false
        ],
        // Fila 8
        [
            false,true,false,false,
            false,true,false,false,
            false,false,false,false,
            true,false
        ],
        // Fila 9
        [
            false,true,false,false,
            false,true,true,true,
            true,true,true,true,
            true,false
        ]
    ]

    // Orden de las casillas que recorren las pesadillas.
    // Las posiciones ya están convertidas al sistema de Wollok.

    const recorrido = [

        game.at(1,0),
        game.at(1,1),
        game.at(1,2),
        game.at(1,3),
        game.at(1,4),

        game.at(2,4),
        game.at(3,4),

        game.at(3,5),
        game.at(3,6),
        game.at(3,7),
        game.at(3,8),

        game.at(4,8),
        game.at(5,8),
        game.at(6,8),
        game.at(7,8),

        game.at(7,7),
        game.at(7,6),

        game.at(6,6),
        game.at(5,6),

        game.at(5,5),
        game.at(5,4),
        game.at(5,3),
        game.at(5,2),
        game.at(5,1),
        game.at(5,0),

        game.at(6,0),
        game.at(7,0),
        game.at(8,0),
        game.at(9,0),
        game.at(10,0),
        game.at(11,0),
        game.at(12,0),

        game.at(12,1),
        game.at(12,2),

        game.at(11,2),
        game.at(10,2),
        game.at(9,2),

        game.at(9,3),
        game.at(9,4),
        game.at(9,5),

        game.at(10,5),
        game.at(11,5),

        game.at(11,6),
        game.at(11,7),
        game.at(11,8),

        game.at(12,8),
        game.at(13,8)
    ]


    // Devuelve la posición correspondiente a un paso
    method posicionDelCamino(indice) =
        recorrido.get(indice)


    // Último índice del recorrido: 46
    method ultimoIndiceDelCamino() =
        recorrido.size() - 1


    // Cantidad total de casillas: 47
    method cantidadDeCasillasDelCamino() =
        recorrido.size()


    method estaDentroDelTablero(posicion) {
        return posicion.x().between(0,13) &&
               posicion.y().between(0,9)
    }

    method esCamino(posicion) {
        if (self.estaDentroDelTablero(posicion)) {
            const fila = 9 - posicion.y()
            const columna = posicion.x()
            return matrizCamino.get(fila).get(columna)
        } else {
            return false
        }
    }
}

object interfazGenerador{
    method colocarInterfaz(){

        self.colocarVisuales(15, 6, "pastorDeSuenos.png")
        precios.ponerPrecios(15, 5, 230)
        self.colocarVisuales(15,4,"lamparaProtectora.png")
        precios.ponerPrecios(15, 3, 160)
        self.colocarVisuales(16,6,"oveja.png")
        precios.ponerPrecios(16,5,70)
        self.colocarVisuales(16,4, "perroGuardian.png")
        precios.ponerPrecios(16, 3, 120)

       
        
        
}


   method colocarVisuales(x, y, imagen){
        const nuevoVisual = new Visuales(
            position = game.at(x,y),
            image = imagen
        )
        game.addVisual(nuevoVisual)
    }

 
}

  

