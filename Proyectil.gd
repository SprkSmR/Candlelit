extends Area2D
export (float) var dmg = 15
var rapidez = 1500

func _physics_process(delta):
	position += transform.x * rapidez * delta
	
func _on_Proyectil_body_entered(body: KinematicBody2D) -> void:
	if body.is_in_group("NoJugador"):
		$efecto.set_frame(1)
		$Fisico.disabled = true
		body.queue_free()
		self.queue_free()
