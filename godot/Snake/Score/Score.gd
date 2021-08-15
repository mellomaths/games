extends Node2D

onready var screen_size = get_viewport().size


func update_score(snake_lenth: int):
	$ScoreText.text = str(snake_lenth - 2)
	

func _ready():
	$Apple.position = Vector2(screen_size.x - 60, screen_size.y - 40)
	$ScoreText.rect_position = Vector2(screen_size.x - 40, screen_size.y - 50)

func _draw():
	var score_width = $Apple.get_rect().size.x + $ScoreText.get_rect().size.x - 16
	var bg_rect = Rect2($Apple.position.x - 20, $Apple.position.y - 20, score_width, 40)
	draw_rect(bg_rect, Color8(166, 209, 60))
	draw_rect(bg_rect, Color8(0, 0, 0), false)
