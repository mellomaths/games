extends KinematicBody2D

var speed = 500
var ball

func get_ball():
	return get_parent().find_node("Ball")
	
func get_opponent_direction():
	if abs(ball.position.y - position.y) > 25:
		if ball.position.y > position.y: return 1
		else: return -1
	else: return 0

func _ready():
	ball = get_ball()
	
func _physics_process(delta):
	move_and_slide(Vector2(0, get_opponent_direction() * speed))

	
