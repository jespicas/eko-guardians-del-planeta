class_name Menu extends Control

@export var fade_in_duration := 0.3
@export var fade_out_duration := 0.2

@onready var initialPositionEko = Vector2(391.0,447)
@onready var SerpPositionEko = Vector2(451.0,414)
@onready var LlenyatairePositionEko = Vector2(399.0,289)
@onready var ContaminacioPositionEko = Vector2(376.0,201)
@onready var PlasticsPositionEko = Vector2(382.0,63)
@onready var ClimaPositionEko = Vector2(424.0,92)
@onready var FabricasPositionEko = Vector2(462.0,224)
@onready var FabricasInfoPositionEko = Vector2(454.0,243)
@onready var SerpPositionInfoEko = Vector2(428.0,377)
@onready var ClimaPositionInfoEko = Vector2(468,96)
@onready var PlasticsPositionInfoEko = Vector2(393,101)
@onready var ContaminacioPositionInfoEko = Vector2(401,201)
@onready var LlenyatairePositionInfoEko = Vector2(356.0,290)

@onready var currentPositionEko = ""

func _ready() -> void:
	var  music = get_node("/root/Music") as AudioStreamPlayer
	if !music.playing:
		music.play()
		
	GlobalValues.SetTimeElapsedFinishLevel(0)
	print(GlobalValues.lastLevelInfo)
	if GlobalValues.lastLevelInfo == "llenyataireInfo":
		$EkoMenu.set_position(LlenyatairePositionEko)
		currentPositionEko = "llenyataire"
		$EkoMenu.flip_h = true
		$llenyataireSelected.show()
		GlobalValues.AddLastLevelInfo("")
	elif GlobalValues.lastLevelInfo == "serpInfo":
		$EkoMenu.set_position(SerpPositionEko)
		currentPositionEko = "serp"
		$EkoMenu.flip_h = false
		$serpSelected.show()
		GlobalValues.AddLastLevelInfo("")		
	elif GlobalValues.lastLevelInfo == "contaminacioInfo":
		$EkoMenu.set_position(ContaminacioPositionEko)
		currentPositionEko = "contaminacio"
		$EkoMenu.flip_h = true
		$contaminacioSelected.show()
		GlobalValues.AddLastLevelInfo("")				
	else:
		$EkoMenu.set_position(initialPositionEko)
		currentPositionEko = "initial"
	if GlobalValues.levelLlenyataire == true:
		$levelLlenyataireDone.show()
		$LevelFinalitzatBosc/nomNivell.text = "DeForestacio"
		var info = GlobalValues.GetLevelInfo("Bosc")
		$LevelFinalitzatBosc.show()
		$LevelFinalitzatBosc/monedes.text = str(info.monedes)
		$LevelFinalitzatBosc/temps.text = str(info.temps)
	else:
		$LevelFinalitzatBosc.hide()
	if GlobalValues.levelDesert == true:
		$serpLevelDone.show()
		$LevelFinalitzatDesert.show()
		$LevelFinalitzatDesert/nomNivell.text = "Desertitzacio"
		var info = GlobalValues.GetLevelInfo("Desert")
		$LevelFinalitzatDesert/monedes.text = str(info.monedes)
		$LevelFinalitzatDesert/temps.text = str(info.temps)
	else:
		$LevelFinalitzatDesert.hide()
	if GlobalValues.levelPlastic == true:
		$plasticLevelDone.show()
		$LevelFinalitzatPlastic.show()
		$LevelFinalitzatPlastic/nomNivell.text = "Plastics"
		var info = GlobalValues.GetLevelInfo("Plastic")
		$LevelFinalitzatPlastic/monedes.text = str(info.monedes)
		$LevelFinalitzatPlastic/temps.text = str(info.temps)
	else:
		$LevelFinalitzatPlastic.hide()
	if GlobalValues.levelPolucio == true:
		$LevelFinalitzatPolucio/nomNivell.text = "Polucio"
		$polucioLevelDone.show()
		var info = GlobalValues.GetLevelInfo("Polucio")
		$LevelFinalitzatPolucio/monedes.text = str(info.monedes)
		$LevelFinalitzatPolucio/temps.text = str(info.temps)
		$LevelFinalitzatPolucio.show()
	else:
		$LevelFinalitzatPolucio.hide()		
	if GlobalValues.levelFoc == true:
		$LevelFinalitzatFoc/nomNivell.text = "Foc"
		$focLevelDone.show()
		$LevelFinalitzatFoc.show()
	else:
		$LevelFinalitzatFoc.hide()		
	if GlobalValues.levelClima == true:
		$LevelFinalitzatClima/nomNivell.text = "Canvi Climatic"
		$climaLevelDone.show()
		$LevelFinalitzatClima.show()
		var info = GlobalValues.GetLevelInfo("Clima")
		$LevelFinalitzatClima/monedes.text = str(info.monedes)
		$LevelFinalitzatClima/temps.text = str(info.temps)
		$LevelFinalitzatClima.show()
	else:
		$LevelFinalitzatClima.hide()		

func _hideExpectSelected(selected):
	$serpInfoSelected.hide()
	$serpSelected.hide()
	$FabricasInfoSelected.hide()
	$fabricaSelected.hide()
	$climaInfoSelected.hide()
	$plasticInfoSelected.hide()
	$polucioInfoSelected.hide()
	$llenyetaireInfoSelected.hide()
	$climaSelected.hide()
	$plasticSelected.hide()
	$contaminacioSelected.hide()
	$llenyataireSelected.hide()
	
	if selected == "serpInfo":
		$serpInfoSelected.show()
	elif selected == "serp":
		$serpSelected.show()
	elif selected == "fabricasInfo":
		$FabricasInfoSelected.show()
	elif selected == "fabricas":
		$fabricaSelected.show()
	elif selected == "climaInfo":
		$climaInfoSelected.show()
	elif selected == "plasticsInfo":
		$plasticInfoSelected.show()
	elif selected == "contaminacioInfo":
		$polucioInfoSelected.show()
	elif selected == "llenyataireInfo":
		$llenyetaireInfoSelected.show()
	elif selected == "clima":
		$climaSelected.show()
	elif selected == "plastics":
		$plasticSelected.show()
	elif selected == "contaminacio":
		$contaminacioSelected.show()
	elif selected == "llenyataire":
		$llenyataireSelected.show()
	
func _moveEko(positionEko, currentPosition) -> void:
	create_tween().tween_property($EkoMenu, "position", positionEko, 1)
	currentPositionEko = currentPosition
	_hideExpectSelected(currentPosition)
	if (currentPosition == "plastics" or currentPosition == "plasticsInfo" or currentPosition == "contaminacio" or currentPosition == "contaminacioInfo" or currentPosition == "llenyataire" or currentPosition == "llenyataireInfo"):
		$EkoMenu.flip_h = true
	else:
		$EkoMenu.flip_h = false
		
func AllLevelsFinished() -> bool:
	return GlobalValues.levelClima == true and GlobalValues.levelDesert == true && GlobalValues.levelPolucio == true && GlobalValues.levelPlastic == true && GlobalValues.levelLlenyataire == true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up"):
		if currentPositionEko.contains("initial"):
			_moveEko(SerpPositionEko, "serp")
		elif currentPositionEko == "serp":
			_moveEko(SerpPositionInfoEko,"serpInfo")
		elif currentPositionEko == "serpInfo":
			_moveEko(FabricasInfoPositionEko,"fabricasInfo")
		elif currentPositionEko == "fabricasInfo":
			_moveEko(FabricasPositionEko,"fabricas")
		elif currentPositionEko == "llenyataire":
			_moveEko(ContaminacioPositionInfoEko,"contaminacioInfo")
		elif currentPositionEko == "contaminacioInfo":
			_moveEko(PlasticsPositionInfoEko,"plasticsInfo")
		elif currentPositionEko == "fabricas":
			_moveEko(ClimaPositionInfoEko,"climaInfo")
		elif currentPositionEko == "contaminacio":
			_moveEko(PlasticsPositionInfoEko,"plasticsInfo")
		elif currentPositionEko == "plastics":
			_moveEko(initialPositionEko,"initial")
		elif currentPositionEko == "plasticsInfo":
			_moveEko(PlasticsPositionEko,"plastics")
		elif currentPositionEko == "climaInfo":
			_moveEko(ClimaPositionEko,"clima")
		elif currentPositionEko == "clima":
			_moveEko(initialPositionEko,"initial")
	if Input.is_action_just_pressed("ui_down"):
		if currentPositionEko.contains("initial"):
			_moveEko(ClimaPositionEko,"clima")
		elif currentPositionEko == "serp":
			_moveEko(initialPositionEko,"initial")
		elif currentPositionEko == "llenyataire":
			_moveEko(SerpPositionEko,"serp")
		elif currentPositionEko == "fabricas":
			_moveEko(FabricasInfoPositionEko,"fabricasInfo")
		elif currentPositionEko == "fabricasInfo":
			_moveEko(SerpPositionInfoEko,"serpInfo")
		elif currentPositionEko == "serpInfo":
			_moveEko(SerpPositionEko,"serp")
		elif currentPositionEko == "contaminacio":
			_moveEko(LlenyatairePositionEko,"llenyataire")
		elif currentPositionEko == "contaminacioInfo":
			_moveEko(LlenyatairePositionEko,"llenyataire")
		elif currentPositionEko == "plastics":
			_moveEko(PlasticsPositionInfoEko,"plasticsInfo")
		elif currentPositionEko == "plasticsInfo":
			_moveEko(ContaminacioPositionEko,"contaminacio")
		elif currentPositionEko == "clima":
			_moveEko(ClimaPositionInfoEko,"climaInfo")
		elif currentPositionEko == "climaInfo":
			_moveEko(FabricasPositionEko,"fabricas")
	if Input.is_action_just_pressed("ui_right"):
		if currentPositionEko.contains("initial"):
			_moveEko(SerpPositionEko,"serp")
		elif currentPositionEko == "serp":
			pass
		elif currentPositionEko == "llenyataire":
			_moveEko(FabricasPositionEko,"fabricas")
		elif currentPositionEko == "fabricas":
			pass
		elif currentPositionEko == "contaminacio":
			_moveEko(ContaminacioPositionInfoEko,"contaminacioInfo")
		elif currentPositionEko == "plastics":
			_moveEko(ClimaPositionEko,"clima")
		elif currentPositionEko == "plasticsInfo":
			_moveEko(ClimaPositionInfoEko,"climaInfo")
		elif currentPositionEko == "clima":
			pass			
		elif currentPositionEko == "llenyataireInfo":
			_moveEko(LlenyatairePositionEko,"llenyataire")
		elif currentPositionEko == "contaminacioInfo":
			_moveEko(FabricasPositionEko, "fabricas")
	if Input.is_action_just_pressed("move_left"):
		if currentPositionEko.contains("initial"):
			_moveEko(LlenyatairePositionEko,"llenyataire")
		elif currentPositionEko == "serp":
			_moveEko(LlenyatairePositionEko,"llenyataire")
		elif currentPositionEko == "llenyataire":
			_moveEko(LlenyatairePositionInfoEko,"llenyataireInfo")
		elif currentPositionEko == "fabricas":
			_moveEko(ContaminacioPositionEko,"contaminacio")
		elif currentPositionEko == "fabricasInfo":
			_moveEko(LlenyatairePositionEko,"llenyataire")
		elif currentPositionEko == "contaminacio":
			_moveEko(ContaminacioPositionEko,"contaminacio")
		elif currentPositionEko == "plastics":
			_moveEko(PlasticsPositionEko,"plastics")
		elif currentPositionEko == "clima":
			_moveEko(ClimaPositionEko,"clima")
		elif currentPositionEko == "climaInfo":
			_moveEko(PlasticsPositionInfoEko,"plasticsInfo")
		elif currentPositionEko == "contaminacioInfo":
			_moveEko(ContaminacioPositionEko,"contaminacio")
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("shoot"):
		if currentPositionEko == "serp":
			if GlobalValues.levelDesert == false:
				get_tree().change_scene_to_file("res://game_singleplayerDesert.tscn")
		if currentPositionEko ==  "llenyataire":
			if GlobalValues.levelLlenyataire == false:
				get_tree().change_scene_to_file("res://game_singleplayerBosc.tscn")
		if currentPositionEko == "contaminacio":
			if GlobalValues.levelPolucio == false:
				get_tree().change_scene_to_file("res://game_singleplayerPolucio.tscn")
		if currentPositionEko == "clima":
			if GlobalValues.levelClima == false:
				get_tree().change_scene_to_file("res://game_singleplayerGelFirst.tscn")
		if currentPositionEko == "plastics":
			if GlobalValues.levelPlastic == false:
				get_tree().change_scene_to_file("res://game_singleplayerPlastics.tscn")
		if currentPositionEko == "serpInfo":
			get_tree().change_scene_to_file("res://gui/Info/DesertInfo/menuDesertInfo.tscn")
		if currentPositionEko == "llenyataireInfo":
			get_tree().change_scene_to_file("res://gui/Info/DeforestacioInfo/menuLlenyataireInfo.tscn")
		if currentPositionEko == "contaminacioInfo":
			get_tree().change_scene_to_file("res://gui/Info/ContaminacioInfo/menuContaminacioInfo.tscn")
		if currentPositionEko == "plasticsInfo":
			get_tree().change_scene_to_file("res://gui/Info/PlasticsInfo/menuPlastics.tscn")
		if currentPositionEko == "climaInfo":			
			get_tree().change_scene_to_file("res://gui/Info/gelInfo/menuGel.tscn")
		if AllLevelsFinished():
			get_tree().change_scene_to_file("res://final/finalJoc.tscn")
			
			
func _on_quit_button_pressed() -> void:
		get_tree().quit()
