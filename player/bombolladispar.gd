class_name bombolladispar extends Marker2D

const BULLET_SCENE = preload("res://player/bombollaObject.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

		 
func shoot(direction: float = 1.0) -> bool:
	var bullet := BULLET_SCENE.instantiate() as bombollaObject
	bullet.global_position = global_position
	bullet.position.y = bullet.position.y - 15 
	bullet.set_as_top_level(true)
	add_child(bullet)
	return true
