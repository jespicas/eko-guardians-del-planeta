class_name Enemy extends CharacterBody2D

enum State {
	WALKING,
	DEAD,
	TOCAT,
	SALTA
}

const WALK_SPEED = 240.0
const JUMP_VELOCITY = -525.0

const numVoltesAlaPlataforma = 3
var _state := State.WALKING
var videsEnemic = 4
var is_shooting := false

var direccio = "esquerra"
var numVoltes = 0
var haArribatAlFinal = false
var iniciPlataforma = true

@onready var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var platform_detector := $PlatformDetector as RayCast2D
@onready var floor_detector_left := $FloorDetectorLeft as RayCast2D
@onready var floor_detector_right := $FloorDetectorRight as RayCast2D
@onready var sprite := $Sprite2D as Sprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var gun = sprite.get_node(^"Gun") as GunEnemy

signal enemyDead()

func _physics_process(delta: float) -> void:
	if _state != State.TOCAT:
		if _state == State.WALKING and velocity.is_zero_approx():
			if haArribatAlFinal == true:
				velocity.x = -WALK_SPEED
			else:
				velocity.x = WALK_SPEED
		velocity.y += gravity * delta
		if not floor_detector_left.is_colliding():
			if get_last_slide_collision() != null:
				var collider = get_last_slide_collision().get_collider()
				if collider != null and (collider.get("name") == "Platform4" or collider.get("name") == "Platform3"):
					haArribatAlFinal = true
					iniciPlataforma = false
				if collider != null and collider.get("name") == "Platform6" and haArribatAlFinal == true:
					iniciPlataforma = true
					haArribatAlFinal = false	
				if numVoltes >= numVoltesAlaPlataforma and haArribatAlFinal == true and iniciPlataforma == false:
					_state = State.SALTA
					print("platform4 i ha de saltar")
			if _state != State.SALTA:
				if haArribatAlFinal == true:
					velocity.x = -WALK_SPEED
					numVoltes += 1
				else:
					velocity.x = WALK_SPEED
		elif not floor_detector_right.is_colliding():
			if _state != State.SALTA:
				velocity.x = -WALK_SPEED
				numVoltes += 1
				if numVoltes >= numVoltesAlaPlataforma and haArribatAlFinal == false and iniciPlataforma == true:
					if get_last_slide_collision() != null:
						var collider = get_last_slide_collision().get_collider()
						if collider != null and collider.get("name") != "Platform4":
							_state = State.SALTA
						else:
							_state = State.WALKING
							

		if is_on_wall():
			if direccio == "dreta":
				direccio = "esquerra"
				velocity.x = -WALK_SPEED
			else:
				direccio = "dreta"
				velocity.x =  WALK_SPEED
	
		if _state == State.SALTA:
			if haArribatAlFinal == true:
				print("saltaesquerra?")
				velocity.x = -WALK_SPEED
				velocity.y = JUMP_VELOCITY
			else:
				velocity.y = JUMP_VELOCITY
			_state = State.WALKING
			numVoltes = 0
		move_and_slide()

		if velocity.x > 0.0:
			sprite.scale.x = 0.8
		elif velocity.x < 0.0:
			sprite.scale.x = -0.8

	var animation := get_new_animation()
	if animation != animation_player.current_animation:
		animation_player.play(animation)


func destroy() -> void:
#	print("Call MuMinator Destroy")
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
	#print("Dispara cada 4 segons??")
	#if randi() % 2 == 0:
#		print("dispara")
	is_shooting = gun.shoot(sprite.scale.x)
	
	pass # Replace with function body.


func _on_cooldown_timeout() -> void:
	is_shooting = false
	pass # Replace with function body.


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
