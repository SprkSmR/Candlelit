#hereda las funciones y atributos de un objeto de tipo KinematicBody2D
extends KinematicBody2D

#exporta las variables para hacerlas visibles
export (int) var speed = 400
export (bool) var estado = true
export (float) var nivelCera = 100.00

#conserva las siguientes variables como internas
var maquina_estados
var velocity = Vector2()
var rng = RandomNumberGenerator.new()
var actual
var pop_up
var disparo = load("res://Proyectil.tscn")

func _ready():
	#inicializa la maquina de estados de las animaciones del personaje
	maquina_estados = $AnimationTree.get("parameters/playback")
	add_to_group("Jugador")

#funcion para revisar el estado actual de la cera y actuar segun el mismo
func revisarCera():
	#si tiene cera
	if estado == true:
		#revisa cada uno de los intervalos de cera y aplica su modelo
		if nivelCera <= 100 && nivelCera > 87.5:
			$Visual/Mobil/Cera.set_frame(0)
		if nivelCera <= 87.5 && nivelCera > 75:
			$Visual/Mobil/Cera.set_frame(1)
		if nivelCera <= 75 && nivelCera > 62.5:
			$Visual/Mobil/Cera.set_frame(2)
		if nivelCera <= 62.5 && nivelCera > 50:
			$Visual/Mobil/Cera.set_frame(3)
		if nivelCera <= 50 && nivelCera > 37.5:
			$Visual/Mobil/Cera.set_frame(4)
		if nivelCera <= 37.5 && nivelCera > 25:
			$Visual/Mobil/Cera.set_frame(5)
		if nivelCera <= 25 && nivelCera > 12.5:
			$Visual/Mobil/Cera.set_frame(6)
		if nivelCera <= 12.5 && nivelCera > 0:
			$Visual/Mobil/Cera.set_frame(7)
		if nivelCera >= 50:
			$Visual/Mobil/Vela.scale.y = nivelCera/100
			$Visual/Mobil/Cera.position.y = 235*(1 - nivelCera/100)
			$Visual/Mobil/Vela.position.y = 135*(1 - nivelCera/100) 
			$Visual/Mobil/Flama.position.y = -273 + 235*(1 - nivelCera/100)
		if nivelCera <= 0:
			estado = false
	#si no tiene cera
	if estado == false:
		#deshabilita todos las partes visuales pertinenetes
		$Visual/Mobil/Ojos.set_frame(1)
		$Visual/Fijo/Miembros.visible = false
		$Visual/Mobil/Flama.visible = false
		$AnimationTree.active = false
		
#funcion de parpadeo
func parpadeo():
	#genera numeros aleatorios
	rng.randomize()
	#si el numero es 1, ejecuta la animacion de parpadeo
	if rng.randi_range(1, 100) == 1:
		$AnimationTree.set("parameters/"+actual+"/OneShot/active", true)

func disparar():
	var d = disparo.instance()
	get_parent().add_child(d)
	d.transform = $Visual/Mobil/Flama/Disparador.global_transform

#funcion que controla el movimiento del personaje
func get_input():
	$Visual/Mobil/Flama/Disparador.look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if Input.is_action_just_pressed("Click"):
		disparar()
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		maquina_estados.travel("caminar")
		actual = "caminar"
	else:
		maquina_estados.travel("idle")
		actual = "idle"

#funcion ejecutada cada fotograma nuevo
func _physics_process(delta):
	#revision de la cera
	revisarCera()
	#revision del estado
	if estado == true:
		#mientras haya cera, la perdera, parpadeara y recibira ordenes.
		nivelCera -= 0.1
		get_input()
		parpadeo()
		velocity = move_and_slide(velocity)


