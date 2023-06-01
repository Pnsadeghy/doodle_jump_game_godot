extends Node2D

var max_height = 0
var score = 0
var high_score = 0
@onready var player = $Player
@onready var hud = $HUD
var platform_list = []

const SAVE_FILE_PATH = "user://savedata.save"

func _ready():
	load_high_score()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.global_position.y < max_height:
		max_height = player.global_position.y
		if max_height < platform_list[0]:
			platform_list.remove_at(0)
			score += 1
			hud.set_score(score)

func _on_platform_spawner_on_add_new_platform(y):
	platform_list.append(y)

func _on_game_start_pressed():
	$StartUI.visible = false
	$Game.visible = true
	$HUD.visible = true


func _on_player_game_over():
	save_score()
	get_tree().change_scene_to_file("res://scenes/start_scene/start_scene.tscn")
	
func save_score():
	if score < high_score: return
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	save_data.store_var(score)
	save_data.close()

func load_high_score():
	if !FileAccess.file_exists(SAVE_FILE_PATH): return
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	high_score = save_data.get_var()
	save_data.close()
