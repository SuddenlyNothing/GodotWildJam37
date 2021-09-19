extends Control

func _ready() -> void:
	MusicPlayer.play(0)

func _on_Button_pressed():
	OptionsMenu.set_active(true)
