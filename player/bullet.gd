class_name Bullet extends RigidBody2D


@onready var animation_player := $AnimationPlayer as AnimationPlayer


func destroy() -> void:
	animation_player.play(&"destroy")


func _on_body_entered(body: Node) -> void:
	if body is Enemy:
		(body as Enemy).destroy()
	if body is EnemyLlenyetaire:
		(body as EnemyLlenyetaire).destroy()
	if body is EnemyPolucio:
		print("enemyPolucio")
		(body as EnemyPolucio).destroy()	
	if body is EnemyMuminator:
		(body as EnemyMuminator).destroy()
	if body is EnemySerpentus:
		(body as EnemySerpentus).destroy()
	if body is EnemyLlangardaix:
		(body as EnemyLlangardaix).destroy()
	if body is EnemyOssus:
		(body as EnemyOssus).destroy()
	if body is EnemyPepsipa:
		(body as EnemyPepsipa).destroy()
	if body is EnemyRobot:
		(body as EnemyRobot).destroy()
	if body is EnemyPlasticMan:
		(body as EnemyPlasticMan).destroy()
	if body is EnemyTauroPlastic:
		(body as EnemyTauroPlastic).destroy()
	if body is EnemyCupito:
		(body as EnemyCupito).destroy()
	if body is EnemyFuguin:
		(body as EnemyFuguin).destroy()
	if body is BulletPolucio:
		(body as BulletPolucio).destroy()
	if body is EnemyPlastic:
		(body as EnemyPlastic).destroy()
	if body is EnemyGel:
		(body as EnemyGel).destroy()
