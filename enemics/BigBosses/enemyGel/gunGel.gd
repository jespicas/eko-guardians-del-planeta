class_name GunGel extends Marker2D
## Represents a weapon that spawns and shoots bullets.
## The Cooldown timer controls the cooldown duration between shots.


const BULLET_VELOCITY = 850.0
const BULLET_SCENE = preload("res://enemics/BigBosses/enemyGel/bulletGel.tscn")

@export var cantidad: int = 10
@export var fuerza_impulso: float = 850.0

@onready var sound_shoot := $Shoot as AudioStreamPlayer2D
@onready var timer := $Cooldown as Timer

func esparcir():
	for i in range(cantidad):
		var obj = BULLET_SCENE.instantiate() as BulletGel
		add_child(obj)
		
		# Coloca el objeto en la posición de inicio
		obj.global_position = global_position
		
		# Genera un ángulo aleatorio en radianes (0 a 2*PI)
		var angulo_aleatorio = randf_range(0, PI * 2)
		
		# Convierte el ángulo a un vector 2D
		var direccion = Vector2(cos(angulo_aleatorio), sin(angulo_aleatorio))
				
		# Aplica el impulso (puedes añadir una fuerza de torsión/spin si quieres)
		obj.apply_impulse(direccion * fuerza_impulso)
		obj.angular_velocity = randf_range(-5.0, 5.0) # Gira al azar
		obj.gravity_scale = 1.0

# This method is only called by Player.gd.
func shoot(direction: float = 1.0) -> bool:
	if not timer.is_stopped():
		return false
	esparcir()		
	#var bullet := BULLET_SCENE.instantiate() as BulletRobot
	#bullet.global_position = global_position
	#bullet.global_position.x -= 15
	
	#bullet.linear_velocity = Vector2(direction * BULLET_VELOCITY, 0.0)

	#bullet.set_as_top_level(true)
	#add_child(bullet)
	sound_shoot.play()
	timer.start()
	return true
