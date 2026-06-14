extends Panel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print ( GlobalValues.monedesCapturadesCurrentLevel)
	$monedes.text =  str(GlobalValues.monedesCapturadesCurrentLevel)
	pass # Replace with function body.

func SetMonedes():
	$monedes.text =  str(GlobalValues.monedesCapturadesCurrentLevel)
func SetTemps():
	$temps.text = str(GlobalValues.TimeElapsedFinishLevel)
func SetSecrets():
	if (GlobalValues.secretsCurrentLevel != 0):
		$secrets.text = str(GlobalValues.secretsCurrentLevel)
		$txtSecrets.show()
		$secrets.show()
	else:
		$secrets.hide()
		$txtSecrets.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event) -> void:
	if GlobalValues.levelEnded == true:
		if event is InputEventKey and event.is_pressed():
			get_tree().paused = false
			get_tree().change_scene_to_file("res://gui/Menu.tscn")
