class_name BulletPolucio extends RigidBody2D


@onready var animation_player := $AnimationPlayer as AnimationPlayer
@export var max_speed: float = 340.0
@export var noise_speed: float = 15.5 # Higher = quicker direction changes

var noise: FastNoiseLite = FastNoiseLite.new()
var time_passed: float = 10.0

signal enemyDead()

func _ready() -> void:
	gravity_scale = 0.0
	noise.seed = randi() # Randomizes the path every game run
	noise.frequency = 0.1

func _physics_process(delta: float) -> void:
	time_passed += delta * noise_speed
	
	# Get unique noise values for X and Y axes (-1.0 to 1.0)
	var drift_x = noise.get_noise_1d(time_passed)
	var drift_y = noise.get_noise_1d(time_passed + 1000.0) # Offset to make Y different from X
	
	var target_velocity = Vector2(drift_x, drift_y) * max_speed
	linear_velocity = linear_velocity.lerp(target_velocity, 0.05)
	
func destroy() -> void:
	animation_player.play(&"destroy")
	enemyDead.emit()
	print("bullePolucio Dead")
	queue_free()
	


func _on_body_entered(body: Node) -> void:
	if body is Player:
		(body as Player)._loseLife()
		print("bulletpolucio toca player")
#		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_enemy_dead() -> void:
	print("enemyydead ...")

	pass # Replace with function body.
