class_name Player extends CharacterBody2D


signal coin_collected()
signal refresh_life()
signal playerDead()


const WALK_SPEED = 300.0
const ACCELERATION_SPEED = WALK_SPEED * 6.0
const JUMP_VELOCITY = -725.0
## Maximum speed at which the player can fall.
const TERMINAL_VELOCITY = 700
var blinkTimes = 0
const maxNumBlinks = 10

const SPEED = 300.0
const ACCEL = 20.0   # Velocidad con la que alcanza la velocidad máxima
const FRICTION = 1.8 # Qué tanto patina cuando NO presionas una tecla
const STOP_THRESHOLD = 5.0

## The player listens for input actions appended with this suffix.[br]
## Used to separate controls for multiple players in splitscreen.
@export var action_suffix := ""

var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var platform_detector := $PlatformDetector as RayCast2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var shoot_timer := $ShootAnimation as Timer
@onready var sprite := $Sprite2D as Sprite2D
@onready var jump_sound := $Jump as AudioStreamPlayer2D
@onready var gun = sprite.get_node(^"Gun") as Gun
@onready var bombollaa = sprite.get_node(^"Marker2D") as bombolladispar
@onready var camera := $Camera as Camera2D
var _double_jump_charged := false

var is_underwater = false
var is_onice = false  
# Underwater parameters
var water_gravity = 0.2  # 30% of normal gravity
var water_drag = 0.02   # High drag to slow movement
var swim_power = -300    # Weaker upward force

func _ready() -> void:
	if get_parent() != null:
		print(get_parent().name)
	if get_parent() != null and get_parent().name == "LevelPlastics" or get_parent().name == "LevelPlasticsBoss":
		is_underwater = true
	elif get_parent() != null and get_parent().name == "Levelgelprimer" or get_parent().name == "LevelGelBoss":
		is_onice = true
	else: 
		is_onice = false
		is_underwater = false


func _physics_process(delta: float) -> void:
	if is_underwater:
		gravity = -gravity
		gravity -= 100
		
	if is_on_floor():
		_double_jump_charged = true
	if Input.is_action_just_pressed("jump" + action_suffix):
		try_jump()
	elif Input.is_action_just_released("jump" + action_suffix) and velocity.y < 0.0:
		# The player let go of jump early, reduce vertical momentum.
		velocity.y *= 0.6
	# Fall.
	
	if is_underwater == false:
		velocity.y = minf(TERMINAL_VELOCITY, velocity.y + gravity * delta)
	else:
		velocity.y = minf(400, velocity.y + gravity * delta)
	if is_onice == false:
		var direction := Input.get_axis("move_left" + action_suffix, "move_right" + action_suffix) * WALK_SPEED
		velocity.x = move_toward(velocity.x, direction, ACCELERATION_SPEED * delta)

	if not is_zero_approx(velocity.x):
		if velocity.x > 0.0:
			sprite.scale.x = 1.0
		else:
			sprite.scale.x = -1.0

	floor_stop_on_slope = not platform_detector.is_colliding()
	
	# Underwater physics
	if is_underwater:
		# Reduce gravity
		velocity.y += (gravity * water_gravity) * delta
		# Apply drag (resistance)
		velocity.y = lerp(velocity.y, 0.0, water_drag)
		
		# Swim input
		if Input.is_action_just_pressed("jump"):
			velocity.y = swim_power
		if Input.is_action_just_pressed("ui_down"):
			velocity.y -= swim_power
	if is_onice:
			# 1. Obtener la dirección del jugador (-1 a 1 en el eje X)
		var input_dir = Input.get_axis("move_left" + action_suffix, "move_right" + action_suffix) 
		# 2. Calcular la velocidad objetivo deseada
		var target_speed = input_dir * SPEED
		
		# 3. Aplicar movimiento con inercia (patinado)
		if input_dir != 0:
			# Aceleración hacia el movimiento
			velocity.x = lerpf(velocity.x, target_speed, ACCEL * delta)
		else:
			# Desaceleración suave al soltar la tecla (aquí está el efecto de patinar)
			velocity.x = lerpf(velocity.x, 0, FRICTION * delta)
		
		# Detener completamente si la velocidad es casi cero (para evitar deslizamiento infinito)
		if abs(velocity.x) < STOP_THRESHOLD and input_dir == 0:
			velocity.x = 0
			
		# 4. Ejecutar el movimiento del personaje

	move_and_slide()

	var is_shooting := false
	if Input.is_action_just_pressed("shoot" + action_suffix):
		is_shooting = gun.shoot(sprite.scale.x)

	var animation := get_new_animation(is_shooting)
	if animation != animation_player.current_animation and shoot_timer.is_stopped():
		if is_shooting:
			shoot_timer.start()
		animation_player.play(animation)

	if blinkTimes == maxNumBlinks:
		$StartBlink.stop()
		blinkTimes = 0

func get_new_animation(is_shooting := false) -> String:
	var animation_new: String
	if is_on_floor():
		if absf(velocity.x) > 0.1:
			animation_new = "run"
		else:
			animation_new = "idle"
	else:
		if velocity.y > 0.0:
			animation_new = "falling"
		else:
			animation_new = "jumping"
	if is_shooting:
		animation_new += "_weapon"
	return animation_new

func try_jump() -> void:
	if is_on_floor():
		jump_sound.pitch_scale = 1.0
	elif _double_jump_charged:
		_double_jump_charged = false
		velocity.x *= 2.5
		jump_sound.pitch_scale = 1.5
	else:
		return
	velocity.y = JUMP_VELOCITY
	jump_sound.play()

func _loseLife() -> void:
	if $StartBlink.is_stopped():
		GlobalValues.PerduaVidaPlayer()
		$StartBlink.start()
		refresh_life.emit()

func _playerDead() -> void:
	playerDead.emit()


func _on_start_blink_timeout() -> void:
	blinkTimes += 1	
	if $Sprite2D.visible == true:
		$Sprite2D.hide()
	else:
		$Sprite2D.show()
	if blinkTimes == maxNumBlinks:
		$Sprite2D.show()

	pass # Replace with function body.


func _on_timer_timeout() -> void:
	if is_underwater:
		bombollaa.shoot(sprite.scale.y)
	pass # Replace with function body.
