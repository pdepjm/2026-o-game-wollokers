import wollok.game.*
import globos.*
import mainExample.*




const listaDeRondas = [ronda1,ronda2]


object entreTiempo{

var rondaActual = 0
var enRonda = false
    method espera(){
        keyboard.e().onPressDo({

            if(not enRonda){
            const rondaSiguiente = listaDeRondas.get(rondaActual)
            rondaSiguiente.iniciarRonda()
            rondaActual+=1
            console.println("Inicio la ronda:" + rondaActual.toString())
            enRonda = true
            }
        })
    } 


 method terminarRonda(){
        enRonda = false
        console.println("termino la ronda")
    }
}



object ronda1{
    var property globosXRonda = 0

    method iniciarRonda(){

        game.onTick(2000, "generar", {

        const globoNuevo = new Globo(numero = 1, direccion = derecha, velocidad = 500)
        gestorDeGlobos.agregar(globoNuevo) 
        game.addVisual(globoNuevo)
		globoNuevo.avanzar()
        globosXRonda +=1


        if(20 < globosXRonda){
            entreTiempo.terminarRonda()
            game.removeTickEvent("generar")
        
        }
	})



 game.onTick(5000, "generarRojo", {
    
        const globoNuevo = new Globo(numero = 2, direccion = derecha, velocidad = 200)
        gestorDeGlobos.agregar(globoNuevo) 
        game.addVisual(globoNuevo)
		globoNuevo.avanzar()
        globosXRonda+=1

        if(20 < globosXRonda){
            entreTiempo.terminarRonda()
            game.removeTickEvent("generarRojo")
           
        }

	})
    }

}

object ronda2{
 var property globosXRonda = 0

    method iniciarRonda(){

        game.onTick(2000, "generar", {

        const globoNuevo = new Globo(numero = 1, direccion = derecha, velocidad = 500)
        gestorDeGlobos.agregar(globoNuevo) 
        game.addVisual(globoNuevo)
		globoNuevo.avanzar()
        globosXRonda +=1


        if(20 < globosXRonda){
            entreTiempo.terminarRonda()
            game.removeTickEvent("generar")
            
        }
	})



 game.onTick(5000, "generarRojo", {
    
        const globoNuevo = new Globo(numero = 2, direccion = derecha, velocidad = 200)
        gestorDeGlobos.agregar(globoNuevo) 
        game.addVisual(globoNuevo)
		globoNuevo.avanzar()
        globosXRonda+=1

        if(20 < globosXRonda){
            entreTiempo.terminarRonda()
            game.removeTickEvent("generarRojo")
           
        }

	})
    }
}