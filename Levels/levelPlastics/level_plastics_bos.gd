extends Node2D
var numEnemies = 1
var startLevelTime
var endLevelTime
signal EnemyDead

var initialPositionEnemy

var startLevel
signal NivellAcabat
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.IniciaLevel()
	startLevelTime = Time.get_ticks_msec()
	initialPositionEnemy = $Enemies/EnemyPlastic.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enemy_dead() -> void:
	numEnemies -= 1
	print(" EnemyDead")
	print(numEnemies)
	if numEnemies == 0:
		GlobalValues.EndLevel("Plastic")
		GlobalValues.SetLevelEnded(true)
		endLevelTime = Time.get_ticks_msec()
		GlobalValues.SetTimeElapsedFinishLevel((endLevelTime - startLevelTime)/1000)
		print((endLevelTime - startLevelTime)/1000)
		GlobalValues.EndLevelInfo("Plastic",GlobalValues.monedesCapturadesCurrentLevel, GlobalValues.TimeElapsedFinishLevel)
		NivellAcabat.emit()
		#get_tree().change_scene_to_file("res://game_singleplayerDesertBigBoss.tscn")	
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("levelplasticboss entered:"+body.get_name())
	if body.get_name() == "EnemyPlastic":
		print(initialPositionEnemy)
		$Enemies/EnemyPlastic.position = initialPositionEnemy
	pass # Replace with function body.
