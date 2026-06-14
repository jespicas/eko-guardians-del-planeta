extends Node2D

var numEnemies = 1
var startLevelTime
var endLevelTime

signal EnemyDead
signal AddEnemy

var startLevel
signal NivellAcabat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.IniciaLevel()
	startLevelTime = Time.get_ticks_msec()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
# Aquesta és la funció que tens connectada a la senyal 'AddEnemy' de l'enemic
func _on_enemy_polucio_add_enemy(bullet: Node) -> void:
	# 1. Afegim la bala al nivell
	numEnemies += 1
	print("add extra enemic")
	print(numEnemies)
	add_child(bullet)
	
	# 2. Connectem la senyal de la bala a una funció d'aquest script de Nivell
	bullet.enemyDead.connect(_on_bullet_touched)

# Aquesta funció s'executarà quan toquin la bala!
func _on_bullet_touched() -> void:
	print("¡El NIVEL se ha enterado de que tocaron la bala/RigidBody!")
	numEnemies -= 1
	print(" EnemyDead")
	print(numEnemies)
	if numEnemies == 0:
		GlobalValues.EndLevel("Polucio")
		GlobalValues.SetLevelEnded(true)
		endLevelTime = Time.get_ticks_msec()
		GlobalValues.SetTimeElapsedFinishLevel((endLevelTime - startLevelTime)/1000)
		print((endLevelTime - startLevelTime)/1000)
		GlobalValues.EndLevelInfo("Polucio",GlobalValues.monedesCapturadesCurrentLevel, GlobalValues.TimeElapsedFinishLevel)
		NivellAcabat.emit()	# Posa aquí els punts que guanya el jugador, efectes, etc.

func _on_enemy_dead() -> void:
	numEnemies -= 1
	print(" EnemyDead")
	print(numEnemies)
	if numEnemies == 0:
		GlobalValues.EndLevel("Polucio")
		GlobalValues.SetLevelEnded(true)
		endLevelTime = Time.get_ticks_msec()
		GlobalValues.SetTimeElapsedFinishLevel((endLevelTime - startLevelTime)/1000)
		print((endLevelTime - startLevelTime)/1000)
		GlobalValues.EndLevelInfo("Polucio",GlobalValues.monedesCapturadesCurrentLevel, GlobalValues.TimeElapsedFinishLevel)
		NivellAcabat.emit()
		#get_tree().change_scene_to_file("res://gui/Menu.tscn")	
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		print("reset level")
		(body as Player)._playerDead()
	pass # Replace with function body.


func _on_secret_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		print("enter secret 1")
		GlobalValues.AddSecrets()
		$Secret1.disconnect("body_entered", Callable(self, "_on_secret_body_entered"))
	pass # Replace with function body.


func _on_secret_2_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		print("enter secret 2")
		GlobalValues.AddSecrets()
		$Secret2.disconnect("body_entered", Callable(self, "_on_secret_body_entered"))
	pass # Replace with function body.
