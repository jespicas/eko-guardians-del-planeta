class_name bombollaObject extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0

@onready var animation_player := $AnimationPlayer as AnimationPlayer

@onready var downDetector := $DownDetector as RayCast2D
@onready var upDetector := $UpDetector as RayCast2D
@onready var LeftDetector := $LeftDetector as RayCast2D
@onready var RightDetector := $RightDetector as RayCast2D

func _ready() -> void:
	animation_player.play("bombolla")
	
func _physics_process(delta: float) -> void:
		# Vector2.UP is (0, -1)
	velocity = Vector2.UP * SPEED
	
	move_and_slide()
	if upDetector.is_colliding() and not upDetector.get_collider() is Player:
		queue_free()
		
		
	
