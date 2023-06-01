extends Node2D

const SAVE_FILE_PATH = "user://savedata.save"

func _ready():
	if !FileAccess.file_exists(SAVE_FILE_PATH): 
		$StartUI/CenterContainer/VBoxContainer/MaxScore.visible = false
		return
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	var high_score = save_data.get_var()
	save_data.close()
	$StartUI/CenterContainer/VBoxContainer/MaxScore.text = "MAX SCORE: " + str(high_score)

func _on_game_start_pressed():
	get_tree().change_scene_to_file("res://scenes/game-scene/game.tscn")
