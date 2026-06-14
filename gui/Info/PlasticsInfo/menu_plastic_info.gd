extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.AddLastLevelInfo("serpInfo")
	pass # Replace with function body.

func _input(event) -> void:
	if event.is_pressed():
		get_tree().change_scene_to_file("res://gui/Menu.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if $Panel/Label.visible == true:
		$Panel/Label.hide()
	else:
		$Panel/Label.show()
	pass # Replace with function body.
