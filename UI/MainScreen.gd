extends Control
var scene_to_load

func _ready():
	$VBoxContainer/Button.grab_focus()
	
func _on_Button_pressed():
	scene_to_load = "res://Levels_Recursed/Level0.tscn"
	$fade_in.show()
	$fade_in.fade_in()

func _on_fade_in_fade_finished():
	get_tree().change_scene(scene_to_load)


func _on_Quit_pressed():
	get_tree().quit()
