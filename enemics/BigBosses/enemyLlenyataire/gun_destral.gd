class_name BulletDestral extends RigidBody2D


@onready var animation_player := $AnimationPlayer as AnimationPlayer

func _ready() -> void:
	animation_player.play(&"dispar")

func destroy() -> void:
	animation_player.play(&"destroy")


func _on_body_entered(body: Node) -> void:
	if body is Player:
		(body as Player)._loseLife()
		queue_free()
