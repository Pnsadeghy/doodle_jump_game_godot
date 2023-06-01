extends Node2D

signal on_add_new_platform(y: float)

@export var follower_node: NodePath
var follower

@export var first_y := 0
@export var min_space := 170
@export var max_space := 260
@export var per_amount := 10
var max_space_calculate
var spawn_round = 1

var static_platform_scene = preload("res://entities/platforms/static-platform/static-platform.tscn")
var break_platform_scene = preload("res://entities/platforms/break-platform/break-platform.tscn")
var jump_platform_scene = preload("res://entities/jump-platform/jump-platform.tscn")

var last_y = 0
var check_y = 0
var height
var width

var break_platform_used: float
var jump_platform_used: float

var break_platform_max := 2
var break_platform_rate := 0.5

func _ready():
	randomize()
	last_y = first_y
	follower = get_node(follower_node)
	var screen_size = get_viewport_rect().size
	height = screen_size.y * 1.5
	width = (screen_size.x - 100) / 2
	
	max_space_calculate = min_space + ((max_space - min_space) / 2)
	
	print(width)
	spawn()
	
func _process(delta):
	
	if check_y > follower.global_position.y:
		if max_space_calculate < max_space:
			max_space_calculate = max(max_space_calculate + 30, max_space)
		spawn_round += 1
		spawn()
	
func spawn():
	randomize()
	clear_platform_spawn_values()
	for i in per_amount:
		last_y -= randf_range(min_space, max_space_calculate)
		var x = randf_range(-width, width)
		
		var platform = get_platform(i)
			
		platform.global_position = Vector2(x, last_y)
		on_add_new_platform.emit(last_y)
		add_child(platform)
		
	check_y = last_y + height
	
	if break_platform_max < 5:
		break_platform_max += 1
		
	if break_platform_rate < 0.7:
		break_platform_rate += 0.05
	
func clear_platform_spawn_values():
	break_platform_used = 0
	jump_platform_used = 0
	
func get_platform(index: int):
	
	if spawn_round > 0 && break_platform_used < break_platform_max:
		if randf() < break_platform_rate:
			break_platform_used += 1
			return break_platform_scene.instantiate()
		
	if spawn_round > 0 && jump_platform_used < 1:
		if randf() < 0.5:
			jump_platform_used += 1
			return jump_platform_scene.instantiate()
	
	return static_platform_scene.instantiate()
