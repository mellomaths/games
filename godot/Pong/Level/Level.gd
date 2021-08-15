extends Node

var player_score = 0
var opponent_score = 0

func reset_ball_position():
	$Ball.position = Vector2(640, 360)
	
func reset_paddles_positions():
	$Player.position.y = 360
	# $Opponent.position.y = 360
	
func update_score_text(score_label, score):
	score_label.text = str(score)
	
func update_countdown_label():
	$CountdownLabel.text = str(int($CountdownTimer.time_left) + 1)
	
func update_countdown_label_visibility(visible):
	$CountdownLabel.visible = visible
	
func score_goal(from_player):
	if from_player:
		player_score += 1
	else:
		opponent_score += 1
		
func start_countdown():
	$CountdownTimer.start()
	update_countdown_label_visibility(true)
	
func on_goal(from_player):
	reset_ball_position()	
	score_goal(from_player)
	get_tree().call_group("BallGroup", "stop_ball")
	start_countdown()
	$ScoreSound.play()
	reset_paddles_positions()

func _on_GoalLeft_body_entered(body):
	on_goal(true)

func _on_GoalRight_body_entered(body):
	on_goal(false)
	
func _process(delta):
	update_score_text($PlayerScore, player_score)
	update_score_text($OpponentScore, opponent_score)
	update_countdown_label()
	if player_score == 0 and opponent_score == 0:
		update_countdown_label_visibility(false)
	
func _on_CountdownTimer_timeout():
	get_tree().call_group("BallGroup", "restart_ball")
	update_countdown_label_visibility(false)
