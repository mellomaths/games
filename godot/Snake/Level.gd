extends Node

const SNAKE = 0
const APPLE = 1

const SNAKE_DEFAULT_POSITION = [Vector2(5, 10), Vector2(4, 10), Vector2(3, 10)]
const SNAKE_DEFAULT_DIRECTION = Vector2(1,0)

var apple_position
var snake_body = SNAKE_DEFAULT_POSITION
var snake_direction = SNAKE_DEFAULT_DIRECTION
var add_apple = false

func delete_tiles(tile_id: int):
	var cells = $Map.get_used_cells_by_id(tile_id)
	for cell in cells:
		$Map.set_cell(cell.x, cell.y, -1)
	

func random_position_on_board():
	randomize()
	return randi() % 20


func place_apple():
	var x = random_position_on_board()
	var y = random_position_on_board()
	return Vector2(x, y)
	
	
func draw_apple(position):
	$Map.set_cell(position.x, position.y, APPLE)
	

func relation_between_vectors(first: Vector2, second: Vector2):
	var relation = second - first
	if relation == Vector2(1, 0): return 'right'
	if relation == Vector2(-1, 0): return 'left'
	if relation == Vector2(0, 1): return 'down'
	if relation == Vector2(0, -1): return 'up'
	
	
func snake_head_direction(snake_body):
	return relation_between_vectors(snake_body[1], snake_body[0])
	

func snake_tail_direction(snake_body):
	return relation_between_vectors(snake_body[-1], snake_body[-2])

	
func draw_snake_head(block: Vector2, snake_body):
	var head_direction = snake_head_direction(snake_body)
	var tile
	if head_direction == 'right': tile = Vector2(2,0)	
	if head_direction == 'left': tile = Vector2(3,1)	
	if head_direction == 'down': tile = Vector2(3,0)	
	if head_direction == 'up': tile = Vector2(2,1)	
	$Map.set_cell(block.x, block.y, SNAKE, false, false, false, tile)
	

func draw_snake_tail(block: Vector2, snake_body):
	var tail_direction = snake_tail_direction(snake_body)
	var tile
	if tail_direction == 'right': tile = Vector2(0,0)	
	if tail_direction == 'left': tile = Vector2(1,0)	
	if tail_direction == 'down': tile = Vector2(0,1)	
	if tail_direction == 'up': tile = Vector2(1,1)	
	$Map.set_cell(block.x, block.y, SNAKE, false, false, false, tile)
	

func draw_snake_middle(block: Vector2, block_index: int, snake_body):
	var previous_block = snake_body[block_index + 1] - block
	var next_block = snake_body[block_index - 1] - block
	
	var tile = Vector2(8,0)
	if previous_block.x == next_block.x: # Going left or right
		tile = Vector2(4,1)
	elif previous_block.y == next_block.y: # Going up or down
		tile = Vector2(4,0)
	else: # It's a curve 
		"""
		Doing the same logic for curves using head and tails direction
		it's kinda laggy tho.
		
		var head_direction = snake_head_direction(snake_body)
		var tail_direction = snake_tail_direction(snake_body)
		if (head_direction == 'up' and tail_direction == 'right') or (head_direction == 'left' and tail_direction == 'down'):
			tile = Vector2(6,1)
		elif (head_direction == 'up' and tail_direction == 'left') or (head_direction == 'right' and tail_direction == 'down'):
			tile = Vector2(5,1)
		elif (head_direction == 'down' and tail_direction == 'right') or (head_direction == 'left' and tail_direction == 'up'):
			tile = Vector2(6,0)
		elif (head_direction == 'down' and tail_direction == 'left') or (head_direction == 'right' and tail_direction == 'up'):
			tile = Vector2(5,0)
		"""
		if previous_block.x == -1 and next_block.y == -1 or next_block.x == -1 and previous_block.y == -1:
			tile = Vector2(6,1)
		elif previous_block.x == -1 and next_block.y == 1 or next_block.x == -1 and previous_block.y == 1:
			tile = Vector2(6,0)
		elif previous_block.x == 1 and next_block.y == -1 or next_block.x == 1 and previous_block.y == -1:
			tile = Vector2(5,1)
		elif previous_block.x == 1 and next_block.y == 1 or next_block.x == 1 and previous_block.y == 1:
			tile = Vector2(5,0)
	
	$Map.set_cell(block.x, block.y, SNAKE, false, false, false, tile)
	
	
func draw_snake():
		
	for block_index in snake_body.size():
		var block = snake_body[block_index]
		
		if block_index == 0: # Head
			draw_snake_head(block, snake_body)
		elif block_index == snake_body.size() - 1: # Tail
			draw_snake_tail(block, snake_body)
		else: # Middle
			draw_snake_middle(block, block_index, snake_body)
		
func move_snake():
	delete_tiles(SNAKE)
	var body_copy
	if add_apple:
		body_copy = snake_body.slice(0, snake_body.size() - 1)
		add_apple = false
	else:
		body_copy = snake_body.slice(0, snake_body.size() - 2) # Exclude the last one
	var new_head = body_copy[0] + snake_direction
	body_copy.insert(0, new_head)
	snake_body = body_copy
	
	
func is_snake_moving_up():
	return snake_direction == Vector2(0,-1)
	
	
func is_snake_moving_right():
	return snake_direction == Vector2(1,0)
	
	
func is_snake_moving_left():
	return snake_direction == Vector2(-1,0)
	

func is_snake_moving_down():
	return snake_direction == Vector2(0,1)
	
	
func check_apple_eaten():
	if apple_position == snake_body[0]:
		apple_position = place_apple()
		add_apple = true
		get_tree().call_group('ScoreGroup', 'update_score', snake_body.size())
		$CrunchSound.play()
		
	
func check_game_over():
	var head = snake_body[0]
	# snake leaves the screen
	if head.x > 20 or head.x < 0: reset_game()
	if head.y > 20 or head.y < 0: reset_game()
	
	# snake bites its own tail
	for block in snake_body.slice(1, snake_body.size() - 1):
		if block == head:
			reset_game()
	

func reset_game():
	snake_body = SNAKE_DEFAULT_POSITION
	snake_direction = SNAKE_DEFAULT_DIRECTION


func _ready():
	# var test = $Map.get_used_cells_by_id(1)
	# $Map.set_cell(0, 0, 0, false, false, false, Vector2(2,0))
	apple_position = place_apple()
	draw_apple(apple_position)
	draw_snake()
	pass
	

func _input(event):
	if Input.is_action_just_pressed("ui_up") and not is_snake_moving_down(): snake_direction = Vector2(0, -1)
	if Input.is_action_just_pressed("ui_right") and not is_snake_moving_left(): snake_direction = Vector2(1, 0)
	if Input.is_action_just_pressed("ui_left") and not is_snake_moving_right(): snake_direction = Vector2(-1, 0)
	if Input.is_action_just_pressed("ui_down") and not is_snake_moving_up(): snake_direction = Vector2(0, 1)
	

func _on_SnakeTick_timeout():
	move_snake()
	draw_apple(apple_position)
	draw_snake()
	check_apple_eaten()
	
func _process(delta):
	check_game_over()
	if apple_position in snake_body: apple_position = place_apple()
