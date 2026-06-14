extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/Music" ).stop()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event) -> void:
	if event.is_pressed():
		GlobalValues.ComencaDeNou()

func _on_video_stream_player_finished() -> void:
	$Panel.show()
	$Panel2.show()
	pass # Replace with function body.
