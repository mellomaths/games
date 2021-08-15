extends KinematicBody2D

var DEFAULT_SPEED = 600

var speed = DEFAULT_SPEED
var velocity = Vector2.ZERO

func random_velocity_param(options, how_many):
	return options[randi() % how_many]
	
func bounce_on_collision(collision):
	if collision:
		velocity = velocity.bounce(collision.normal)
		$CollisionSound.play()
		
func stop_ball():
	speed = 0
	
func start_ball():
	speed = DEFAULT_SPEED
	velocity.x = random_velocity_param([-1, 1], 2)
	velocity.y = random_velocity_param([-0.8, 0.8], 2)
	
func restart_ball():
	start_ball()
	
func _ready():
	randomize()
	start_ball()
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * speed * delta)
	bounce_on_collision(collision)
