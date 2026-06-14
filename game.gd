class_name Game extends Node

@onready var _pause_menu := $InterfaceLayer/PauseMenu as PauseMenu
@onready var _hud_game := $InterfaceLayer2/HudGame as HudGame

signal refresh_life()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"toggle_fullscreen"):
		var mode := DisplayServer.window_get_mode()
		if mode == DisplayServer.WINDOW_MODE_FULLSCREEN or \
				mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		get_tree().root.set_input_as_handled()

	elif event.is_action_pressed(&"toggle_pause"):
		var tree := get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			_pause_menu.open()
		else:
			_pause_menu.close()
		get_tree().root.set_input_as_handled()


func _on_player_2_coin_collected() -> void:
	pass # Replace with function body.
			
func _on_level_nivell_acabat() -> void:
	$InterfaceLayer2/HudGame.levelFinalitzat()
	print("levelFinalitzat!")
	pass # Replace with function body.


func _on_level_2_nivell_acabat() -> void:
	$InterfaceLayer2/HudGame.levelFinalitzat()
	print("levelFinalitzat!")	
	pass # Replace with function body.


func _on_ready() -> void:
	refresh_life.emit()
	get_node("/root/Music" ).stop()

	pass # Replace with function body.
