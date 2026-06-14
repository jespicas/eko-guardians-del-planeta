extends Node

var videsPlayer = 5
var monedesCapturades = 0
var monedesCapturadesCurrentLevel = 0
var secretsCurrentLevel = 0
var secrets = 0
var numeroRetry = 3
var levelDesert  := false
var levelLlenyataire := false
var levelPolucio := false
var levelPlastic := false
var levelClima := false
var levelFoc := false

var levelEnded := false
var TimeElapsedFinishLevel

var DesertNivell = {"monedes": 0,"temps": 0,"name": "Desert", "finalitzat": false}
var LlenyataireNivell = {"monedes": 0,"temps": 0,"name": "Bosc", "finalitzat": false}
var FocNivell = {"monedes": 0,"temps": 0,"name": "Foc", "finalitzat": false}
var PolucioNivell = {"monedes": 0,"temps": 0,"name": "Polucio", "finalitzat": false}
var PlasticNivell = {"monedes": 0,"temps": 0,"name": "Plastic", "finalitzat": false}
var ClimaNivell = {"monedes": 0,"temps": 0,"name": "Clima", "finalitzat": false}
var nivells = [DesertNivell,LlenyataireNivell,FocNivell,PolucioNivell,PlasticNivell,ClimaNivell]

var lastLevelInfo = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func AddLastLevelInfo(value):
	lastLevelInfo = value
func ResetMarcador():
	videsPlayer = 5
	monedesCapturades = 0
	monedesCapturadesCurrentLevel= 0
	secretsCurrentLevel = 0
	secrets = 0
	levelEnded = false
	numeroRetry = 3
	levelDesert  = false
	levelLlenyataire = false
	levelPolucio = false
	levelPlastic = false
	levelClima = false
	levelFoc = false	
	
func AddMoneda():
	monedesCapturades += 1
	monedesCapturadesCurrentLevel += 1

func AddSecrets():
	secrets += 1
	secretsCurrentLevel += 1	
func PerduaVidaPlayer():
	videsPlayer -= 1
func PlayerDead():
	videsPlayer = 0
	
func GastaRetry():
	numeroRetry -= 1
	if (numeroRetry == -1):
		ResetMarcador()
		get_tree().change_scene_to_file("res://gui/Portada.tscn")
		
func ComencaDeNou():
	ResetMarcador()
	get_tree().change_scene_to_file("res://gui/Portada.tscn")
			
func ResetLevel():
	monedesCapturades = monedesCapturades - monedesCapturadesCurrentLevel
	monedesCapturadesCurrentLevel = 0
	videsPlayer = 5
	levelEnded = false
	get_tree().reload_current_scene()

func IniciaLevel():
	levelEnded = false
	monedesCapturadesCurrentLevel = 0
	
func EndLevel(nameLevel: String) -> void:
	if nameLevel == "Desert":
		levelDesert = true
	if nameLevel == "Llenyataire":
		levelLlenyataire = true
	if nameLevel == "Polucio":
		levelPolucio = true
	if nameLevel == "Plastic":
		levelPlastic = true
	if nameLevel == "Clima":
		levelClima = true
	if nameLevel == "Foc":
		levelFoc = true

func EndLevelInfo(nameLevel: String,monedes: int, elapsedTime: int) -> void:
	for item in nivells:
		if item.name == nameLevel:
			item.monedes = item.monedes + monedes
			item.temps = item.temps + elapsedTime
			item.finalitzat = true
	#print(nivells )
	pass
func GetLevelInfo(nameLevel: String):
	for nivell in nivells:
		if nivell.name == nameLevel:
			return nivell
	return null
func SetLevelEnded(value):
	levelEnded = value

func SetTimeElapsedFinishLevel(value):
	TimeElapsedFinishLevel = value
