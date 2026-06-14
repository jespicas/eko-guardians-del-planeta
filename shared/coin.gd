class_name Coin extends Area2D
## Collectible that disappears when the player touches it.


@onready var animation_player := $AnimationPlayer as AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	animation_player.play(&"picked")
	if body is Player:
		(body as Player).coin_collected.emit()


func _on_sotaterra_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		print("reset level")
		(body as Player)._playerDead()
