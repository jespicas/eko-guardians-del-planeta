class_name EnemyPepsipa extends CharacterBody2D

enum State {
	WALKING,
	DEAD,
	TOCAT,
}

const WALK_SPEED = 140.0

var _state := State.WALKING
var videsEnemic = 1
var is_shooting := false

var direccio = "dreta"

@onready var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var platform_detector := $PlatformDetector as RayCast2D
@onready var floor_detector_left := $FloorDetectorLeft as RayCast2D
@onready var floor_detector_right := $FloorDetectorRight as RayCast2D
@onready var sprite := $Sprite2D as Sprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var gun = sprite.get_node(^"Gun") as GunPepsipa

signal enemyDead()

func _physics_process(delta: float) -> void:
	if _state != State.TOCAT:
		if _state == State.WALKING and velocity.is_zero_approx():
			velocity.x = WALK_SPEED
		velocity.y += gravity * delta
		if not floor_detector_left.is_colliding():
			velocity.x = WALK_SPEED
		elif not floor_detector_right.is_colliding():
			velocity.x = -WALK_SPEED

		if is_on_wall():
			if direccio == "dreta":
				direccio = "esquerra"
				velocity.x = -WALK_SPEED
			else:
				direccio = "dreta"
				velocity.x =  WALK_SPEED
		move_and_slide()

		if velocity.x > 0.0:
			sprite.scale.x = 0.8
		elif velocity.x < 0.0:
			sprite.scale.x = -0.8

	var animation := get_new_animation()
	if animation != animation_player.current_animation:
		animation_player.play(animation)


func destroy() -> void:
	print("Call Pepsipa Destroy")
	if _state != State.DEAD and $Tocat.is_stopped():
		videsEnemic -= 1
		if videsEnemic >= 0:
			_state= State.TOCAT
			$Tocat.start()
		else:
			_state= State.TOCAT
			$TocatDead.start()

func get_new_animation() -> StringName:
	var animation_new: StringName
	if _state == State.TOCAT:
		animation_new = &"tocat"
	if _state == State.WALKING:
		if velocity.x == 0:
			animation_new = &"idle"
		else:
			animation_new = &"walk"
	else:
		if _state == State.TOCAT:
			animation_new = &"tocat"
		else:
			animation_new = &"dead"
	if is_shooting:
		animation_new = &"dispara"
	return animation_new


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player" and _state != State.DEAD:
		body._loseLife()
	pass # Replace with function body.


func _on_tocat_timeout() -> void:
	_state = State.WALKING
	pass # Replace with function body.


func _on_tocat_dead_timeout() -> void:
	_state = State.DEAD
	velocity = Vector2.ZERO
	enemyDead.emit()
	self.collision_mask = 0
	#$CollisionShape2D.disabled = true
	pass # Replace with function body.


func _on_disparar_timeout() -> void:
#	print("Dispara cada 4 segons??")
	if randi() % 2 == 0:
#		print("dispara pepsipa")
		is_shooting = gun.shoot(sprite.scale.x)
	
	pass # Replace with function body.


func _on_cooldown_timeout() -> void:
	is_shooting = false
	pass # Replace with function body.
