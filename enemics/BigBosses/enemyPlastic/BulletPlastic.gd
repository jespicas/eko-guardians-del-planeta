class_name BulletPlastic extends RigidBody2D


@onready var animation_player := $AnimationPlayer as AnimationPlayer

func _ready() -> void:
	animation_player.play(&"dispar")
	gravity_scale = 0.0
	linear_velocity = Vector2.ZERO 	

func destroy() -> void:
	animation_player.play(&"destroy")


func _on_body_entered(body: Node) -> void:
	if body is Player:
		(body as Player)._loseLife()
		queue_free()
