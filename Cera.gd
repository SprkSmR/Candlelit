#heredar funciones y atributos de un objeto tipo Area2D
extends Area2D
#crear una variable "rng"
var rng = RandomNumberGenerator.new()
#crear una variable para la cantidad de cera
var cera

#funcion ejecutada cuando el objeto aparece
func _ready():
	#generar nuevos numeros aleatorios
	rng.randomize()
	#asignarle a la cantidad de cera un valor entre 5 y 15
	cera = rng.randi_range(5, 15)
	#asignarle a la cera un modelo entre 0 y 3
	$pedazoCera.set_frame(rng.randi_range(0, 3))
	add_to_group("NoJugador")
#funcion ejecutada cuando un cuerpo interactúa con la cera
func _on_Cera_body_entered(body: KinematicBody2D) -> void:
	#sumarle la cantidad de cera al objeto con el que choca
	body.nivelCera += cera
	#eliminar el objeto de cera
	self.queue_free()
