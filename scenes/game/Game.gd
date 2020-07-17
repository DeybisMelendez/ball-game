extends Node2D

export (PackedScene) var Ball

onready var Press = $Main/MainMenu/Press
onready var LoseMenu = $Main/LoseMenu
onready var Max = $Main/Max
onready var Leaderboard = $Main/MainMenu/Leaderboard
onready var PlayerBall = $PlayerBall
onready var Title = $Main/MainMenu/Title
onready var Desc = $Main/MainMenu/Desc
onready var Score = $Main/Score
onready var Audio = $Main/Audio

var score = 0
func _ready():
	Press.connect("button_up",self,"start_game")
	LoseMenu.get_node("PlayAgain").connect("button_up",self,"restart")
	Max.text = "Max:" + str(Global.max_record)
	Leaderboard.connect("button_up", self, "leaderboard")
	randomize()

func start_game():
	PlayerBall.can_move = true
	Title.hide()
	Press.hide()
	Leaderboard.hide()
	Desc.hide()
	Score.show()
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
		Audio.play()
		yield(Audio,"finished")
		get_tree().change_scene("res://scenes/new_record/NewRecord.tscn")
	else:
		Audio.play()
		LoseMenu.show()

func instance_ball(add_score):
	var new = Ball.instance()
	new.scale_size = PlayerBall.scale_size * rand_range(0.2,1.5)
	new.position = Vector2((randi()%2)*720, (randi()%2)*1280)
	call_deferred("add_child", new)
	if add_score:
		score += 1
		Score.text = str(score)

func leaderboard():
	get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")
