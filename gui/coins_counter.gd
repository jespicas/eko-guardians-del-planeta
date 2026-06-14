class_name CoinsCounter extends Panel

@onready var _coins_label := $Label as Label


func _ready() -> void:
	_coins_label.set_text(str(GlobalValues.monedesCapturades))
	($AnimatedSprite2D as AnimatedSprite2D).play()


func collect_coin() -> void:
	GlobalValues.AddMoneda()
	_coins_label.set_text(str(GlobalValues.monedesCapturades))
