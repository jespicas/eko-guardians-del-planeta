extends Node2D

var numEnemies = 1

signal EnemyDead

signal NivellAcabat

var startLevelTime
var endLevelTime
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.IniciaLevel()	
	startLevelTime = Time.get_ticks_msec()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enemy_dead() -> void:
	numEnemies -= 1
	print(" EnemyDead")
	print(numEnemies)
	if numEnemies == 0:
		GlobalValues.EndLevel("Llenyataire")
		GlobalValues.SetLevelEnded(true)
		endLevelTime = Time.get_ticks_msec()
		GlobalValues.SetTimeElapsedFinishLevel((endLevelTime - startLevelTime)/1000)
		print((endLevelTime - startLevelTime)/1000)
		GlobalValues.EndLevelInfo("Bosc",GlobalValues.monedesCapturadesCurrentLevel, GlobalValues.TimeElapsedFinishLevel)
		NivellAcabat.emit()		
	pass # Replace with function body.


func _on_sotaterra_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		print("reset level")
		(body as Player)._playerDead()
	pass # Replace with function body.
