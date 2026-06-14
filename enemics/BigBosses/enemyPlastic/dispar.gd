extends RayCast2D

@export var daño: int = 10
@onready var laser: RayCast2D = $Laser
@onready var linea_laser: Line2D = $linea_laser

func _physics_process(delta):
	dibujar_laser()

func dibujar_laser() -> void:
	linea_laser.clear_points()
	linea_laser.add_point(Vector2.ZERO) # Origen del láser en el enemigo
	
	if laser.is_colliding():
		var colision = laser.get_collider()
		linea_laser.add_point(laser.to_local(laser.get_collision_point()))
		
		# Comprueba si el objeto golpeado es el jugador y le aplica daño
		if colision.is_in_group("Jugador"):
			if colision.has_method("recibir_daño"):
				colision.recibir_daño(daño)
	else:
		# Si no choca con nada, el láser llega a su distancia máxima
		linea_laser.add_point(laser.target_position)

# Detecta cuando el jugador entra al rango de visión del enemigo
func _on_area_deteccion_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jugador"):
#		jugador = body
		set_physics_process(true)

# Detecta cuando el jugador sale del rango
func _on_area_deteccion_body_exited(body: Node2D) -> void:
	if body.is_in_group("Jugador"):
#		jugador = null
		set_physics_process(false)
		linea_laser.clear_points()
