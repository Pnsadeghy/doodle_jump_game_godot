extends Camera2D

@export var follower_node: NodePath
var follower

# Called when the node enters the scene tree for the first time.
func _ready():
	follower = get_node(follower_node)


func _physics_process(delta):
	if follower.global_position.y < global_position.y:
		global_position.y = follower.global_position.y
