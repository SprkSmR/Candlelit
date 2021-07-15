#hereda las funciones y atributos de un objeto tipo Node2D
extends Node2D

#variable para guardar numeros aleatorios
var rng = RandomNumberGenerator.new()	
#variable que almacena el tipo de objeto Cera
var pedazoCera = load("res://Cera.tscn")
#variable que almacena el tipo de objeto Vela_personaje
var jugador_escena = load("res://Vela_personaje.tscn")
#variable que almacena la pantalla de derrota
var pop_up = load("res://perdiste")

#funcion que se activa cuando la escena entra
func _ready():
	#instanciar un objeto del tipo jugador en la escena
	var jugador = jugador_escena.instance()
	#acomodar la poisicion en el centro de la pantalla
	jugador.position.x = get_viewport().size.x/2
	jugador.position.y = get_viewport().size.y/2
	#añadir al jugador como elemento del arbol de la escena
	add_child(jugador)

#funcion que se activa cada vez que transcurre un fotograma
func _process(delta):
	#generar numeros aleatorios nuevos
	rng.randomize()
	#si el numero es igual a 1
	if rng.randi_range(0, 125) == 1:
		#instanciar un objeto del tipo cera
		var cera = pedazoCera.instance()
		#generar numeros aleatorios nuevos
		rng.randomize()
		#ubicar el objeto en una posicion aleatoria de la pantalla
		var x = rng.randf_range(0, get_viewport().size.x)
		rng.randomize()
		var y = rng.randf_range(0, get_viewport().size.y)
		cera.position.y = y
		cera.position.x = x
		#añadir el objeto de cera como elemento del arbol de la escena
		add_child(cera)
