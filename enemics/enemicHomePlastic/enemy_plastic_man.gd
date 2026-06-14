class_name EnemyPlasticMan extends CharacterBody2D

enum State {
	WALKING,
	DEAD,
	TOCAT,
}

const WALK_SPEED = 50.0
const SWIM_SPEED = 50.0 

var _state := State.WALKING
var videsEnemic = 1
var is_shooting := false

# Direcciones independientes: 1 o -1
var direccion_horizontal: int = 1
var direccion_vertical: int = -1

@onready var platform_detector := $PlatformDetector as RayCast2D
@onready var floor_detector_left := $FloorDetectorLeft as RayCast2D
@onready var floor_detector_right := $FloorDetectorRight as RayCast2D
@onready var top_detector_left := $TopDetectorLeft as RayCast2D
@onready var top_detecto_right := $TopDetectorRight as RayCast2D
@onready var sprite := $Sprite2D as Sprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var gun = sprite.get_node(^"Gun") as GunPlasticMan

@export var amplitud_flotacion: float = 5.0
@export var velocidad_flotacion: float = 2.0
var tiempo: float = 0.0

signal enemyDead()

func _physics_process(delta: float) -> void:
	if _state == State.TOCAT or _state == State.DEAD:
		velocity = Vector2.ZERO
		actualizar_animacion()
		return

	# --- 1. REBOTE EN TECHO Y SUELO (Solo invierte el eje Y) ---
	if is_on_ceiling() and direccion_vertical == -1:
		direccion_vertical = 1
	elif is_on_floor() and direccion_vertical == 1:
		direccion_vertical = -1

	# --- 2. REBOTE EN PAREDES Y BORDES (Solo invierte el eje X) ---
	if is_on_wall():
		if direccion_horizontal == 1 and is_on_wall_boundary_right():
			direccion_horizontal = -1
		elif direccion_horizontal == -1 and is_on_wall_boundary_left():
			direccion_horizontal = 1
	
	if floor_detector_left.is_colliding():
		if (position.y > 650):
			#position.y  = position.y-5
			velocity.y = direccion_vertical * SWIM_SPEED
		print(position.y)
		print("floor left")		
	if top_detector_left.is_colliding():
		if (position.y < 0):
			velocity.y = 1 * SWIM_SPEED
		print(position.y)
	
	tiempo += (delta * velocidad_flotacion)/100
	var desplazamiento_y = sin(tiempo) * amplitud_flotacion
	
	# Mantiene la posición x y modifica la y
	velocity.y += desplazamiento_y 
	# Control opcional de acantilados (si quieres que rebote al llegar al borde del suelo)
	#elif not floor_detector_left.is_colliding() and direccion_horizontal == -1:
	#	direccion_horizontal = 1  
	#elif not floor_detector_right.is_colliding() and direccion_horizontal == 1:
	#	direccion_horizontal = -1 

	# --- 3. ASIGNAR VELOCIDADES FINALES ---
	velocity.x = direccion_horizontal * WALK_SPEED
	#velocity.y = direccion_vertical * SWIM_SPEED


	# --- 4. EJECUTAR MOVIMIENTO ---
	move_and_slide()
	# El efecto de flotar (subir y bajar suavemente usando seno)


	# --- 5. VOLTEAR EL SPRITE SEGÚN LA X ---
	if velocity.x > 0.0:
		sprite.scale.x = 0.8
	elif velocity.x < 0.0:
		sprite.scale.x = -0.8

	actualizar_animacion()


# Funciones de seguridad para evitar vibraciones en las paredes laterales
func is_on_wall_boundary_right() -> bool:
	return get_wall_normal().x < 0

func is_on_wall_boundary_left() -> bool:
	return get_wall_normal().x > 0


func actualizar_animacion() -> void:
	var animation := get_new_animation()
	if animation != animation_player.current_animation:
		animation_player.play(animation)


func destroy() -> void:
	print("Call Robot Destroy")
	if _state != State.DEAD and $Tocat.is_stopped():
		videsEnemic -= 1
		if videsEnemic >= 0:
			_state = State.TOCAT
			$Tocat.start()
		else:
			_state = State.TOCAT
			$TocatDead.start()


func get_new_animation() -> StringName:
	if _state == State.TOCAT:
		return &"tocat"
	if _state == State.DEAD:
		return &"dead"
	if is_shooting:
		return &"dispara"
	
	if velocity.x == 0:
		return &"idle"
	else:
		return &"walk"


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player" and _state != State.DEAD:
		body._loseLife()


func _on_tocat_timeout() -> void:
	_state = State.WALKING


func _on_tocat_dead_timeout() -> void:
	_state = State.DEAD
	velocity = Vector2.ZERO
	enemyDead.emit()
	self.collision_mask = 0


func _on_disparar_timeout() -> void:
	if randi() % 2 == 0 and _state == State.WALKING:
#		print("dispara")
		is_shooting = gun.shoot(sprite.scale.x)


func _on_cooldown_timeout() -> void:
	is_shooting = false
