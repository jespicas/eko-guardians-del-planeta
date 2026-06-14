class_name HudGame extends Control

@export var fade_in_duration := 0.3
@export var fade_out_duration := 0.2

@onready var center_cont := $ColorRect/CenterContainer as CenterContainer
@onready var resume_button := center_cont.get_node(^"VBoxContainer/ResumeButton") as Button
@onready var coins_counter := $ColorRect/CoinsCounter as CoinsCounter

signal refresh_life()
signal playerDead()

func close() -> void:
	var tween := create_tween()
	get_tree().paused = false
	tween.tween_property(
		self,
		^"modulate:a",
		0.0,
		fade_out_duration
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(
		center_cont,
		^"anchor_bottom",
		0.5,
		fade_out_duration
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_callback(hide)


func open() -> void:
	show()
	resume_button.grab_focus()

	modulate.a = 0.0
	center_cont.anchor_bottom = 0.5
	var tween := create_tween()
	tween.tween_property(
		self,
		^"modulate:a",
		1.0,
		fade_in_duration
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(
		center_cont,
		^"anchor_bottom",
		1.0,
		fade_out_duration
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)


func _on_coin_collected() -> void:
	coins_counter.collect_coin()


func _on_resume_button_pressed() -> void:
	close()


func _on_singleplayer_button_pressed() -> void:
	if visible:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://game_singleplayerDesert.tscn")


func _on_splitscreen_button_pressed() -> void:
	if visible:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://game_splitscreenDesert.tscn")


func _on_quit_button_pressed() -> void:
	if visible:
		get_tree().quit()


func _on_player_coin_collected() -> void:
	coins_counter.collect_coin()
	pass # Replace with function body.


func _on_player_3_coin_collected() -> void:
	coins_counter.collect_coin()
	pass # Replace with function body.


func _on_player_2_coin_collected() -> void:
	coins_counter.collect_coin()
	pass # Replace with function body.


func _on_refresh_life() -> void:
	print("refresh life")
	print(GlobalValues.videsPlayer)
	if GlobalValues.videsPlayer == 4:
		$ColorRect/Vides/vida5.hide()
	if GlobalValues.videsPlayer == 3:
		$ColorRect/Vides/vida5.hide()
		$ColorRect/Vides/vida4.hide()
	if GlobalValues.videsPlayer == 2:
		$ColorRect/Vides/vida5.hide()
		$ColorRect/Vides/vida4.hide()
		$ColorRect/Vides/vida3.hide()
	if GlobalValues.videsPlayer == 1:
		$ColorRect/Vides/vida5.hide()
		$ColorRect/Vides/vida4.hide()
		$ColorRect/Vides/vida3.hide()
		$ColorRect/Vides/vida2.hide()
	if GlobalValues.videsPlayer == 0:
		$ColorRect/Vides/vida5.hide()
		$ColorRect/Vides/vida4.hide()
		$ColorRect/Vides/vida3.hide()
		$ColorRect/Vides/vida2.hide()
		$ColorRect/Vides/vida1.hide()
	
	if GlobalValues.videsPlayer == 0:
		$ColorRect/Retry.show()
		$ColorRect/Retry.StartMissatge()	
	pass # Replace with function body.

func levelFinalitzat():
	GlobalValues.SetLevelEnded(true)
	$ColorRect/LevelFinalitzat.SetMonedes()
	$ColorRect/LevelFinalitzat.SetTemps()
	$ColorRect/LevelFinalitzat.SetSecrets() 
	get_tree().paused = true
	$ColorRect/LevelFinalitzat.show()


func _on_player_refresh_life() -> void:
	print("refresh life")
	print(GlobalValues.videsPlayer)
	if GlobalValues.videsPlayer == 4:
		$ColorRect/Vides/vida5.hide()
	if GlobalValues.videsPlayer == 3:
		$ColorRect/Vides/vida5.hide()
		$ColorRect/Vides/vida4.hide()
	if GlobalValues.videsPlayer == 2:
		$ColorRect/Vides/vida5.hide()
		$ColorRect/Vides/vida4.hide()
		$ColorRect/Vides/vida3.hide()
	if GlobalValues.videsPlayer == 1:
		$ColorRect/Vides/vida5.hide()
		$ColorRect/Vides/vida4.hide()
		$ColorRect/Vides/vida3.hide()
		$ColorRect/Vides/vida2.hide()
	if GlobalValues.videsPlayer == 0:
		$ColorRect/Vides/vida5.hide()
		$ColorRect/Vides/vida4.hide()
		$ColorRect/Vides/vida3.hide()
		$ColorRect/Vides/vida2.hide()
		$ColorRect/Vides/vida1.hide()
	
	if GlobalValues.videsPlayer == 0:
		$ColorRect/Retry.show()
		$ColorRect/Retry.StartMissatge()	

		
		
	pass # Replace with function body.


func _on_player_dead() -> void:
	$ColorRect/Retry.show()
	$ColorRect/Retry.StartMissatge()
	#GlobalValues.ResetLevel()	
	pass # Replace with function body.
