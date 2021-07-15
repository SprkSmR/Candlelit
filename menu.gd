#heredar funciones y atributos de un objeto tipo Area2D
extends MarginContainer

#funcion que se activa cuando "iniciar" es presionado
func _on_iniciar_pressed():
	#cambia la escena al juego
	get_tree().change_scene("res://Principal.tscn")

#funcion que se activa cuando "salir" es presionado
func _on_salir_pressed():
	#sale del juego
	get_tree().quit()
