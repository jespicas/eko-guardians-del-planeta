extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label2.text = "Et queden %s reintents"%[GlobalValues.numeroRetry]
#	$si.grab_focus()	
	pass # Replace with function body.

func StartMissatge():
	print(str(GlobalValues.numeroRetry))
	$Timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func TornaAComencar():
	$Timer.stop()
	GlobalValues.GastaRetry()
	GlobalValues.ResetLevel()
	hide()	

func _on_timer_timeout() -> void:
	TornaAComencar()
	pass # Replace with function body.
