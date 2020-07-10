extends Node2D

export (PackedScene) var Ball
var score = 0

func _ready():
	$CanvasLayer/Press.connect("button_up",self,"start_game")
	$CanvasLayer/Ups.connect("button_up",self,"restart")
	$CanvasLayer/Max.text = "Max:" + str(Global.max_record)
func start_game():
	$PlayerBall.can_move = true
	$CanvasLayer/Title.hide()
	$CanvasLayer/Press.hide()
	for i in 24:
		instance_ball(false)

func restart():
	get_tree().paused = false
	get_tree().reload_current_scene()


func end():
	get_tree().paused = true
	if Global.max_record < score:
		Global.max_record = score
		Global.save_data(Global.max_record, "data.dat")
		get_tree().paused = false
		get_tree().change_scene("res://scenes/new_record/NewRecord.tscn")
	else:
		$CanvasLayer/Ups.show()

func instance_ball(add_score):
	var new = Ball.instance()
	new.scale_size = $PlayerBall.scale_size * rand_range(0.2,1.5)
	new.position = Vector2(randi()%720+720, randi()%1280+1280)
	add_child(new)
	if add_score:
		score += 1
		$CanvasLayer/Score.text = str(score)

