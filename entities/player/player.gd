extends RigidBody2D

signal game_over

@export var jump_speed := 800
@export var speed = 300

@onready var animation = $Animation

var velocity := Vector2.ZERO
var camera
var screen_height

func _ready():
	camera = get_viewport().get_camera_2d()
	screen_height = get_viewport_rect().size.y

func _integrate_forces(state):
	rotation = 0

func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		linear_velocity = Vector2(speed, linear_velocity.y)
		animation.flip_h = false
	elif Input.is_action_pressed("move_left"):
		linear_velocity = Vector2(-speed, linear_velocity.y)
		animation.flip_h = true
	else:
		linear_velocity = Vector2(0, linear_velocity.y)

func _on_jump_area_body_entered(body):
	if body.is_in_group("platforms") and linear_velocity.y > 0:
		if body.has_method("on_used"):
			body.on_used()
		var jump_force = 1
		if body.get("jump_force") != null:
			jump_force = body.jump_force
		on_jump(jump_force)
		
func on_jump(jump_force):
	animation.play("jump")
	linear_velocity = Vector2(0, -(jump_speed * jump_force))


func _on_visible_on_screen_notifier_2d_screen_exited():
	if global_position.y > camera.global_position.y + screen_height / 2:
		game_over.emit()
	elif (global_position.x > 0 and linear_velocity.x > 0) or (global_position.x < 0 and linear_velocity.x < 0):
		set_deferred("global_position", Vector2(-global_position.x, global_position.y))

func _on_animation_animation_finished():
	animation.play("idle")
