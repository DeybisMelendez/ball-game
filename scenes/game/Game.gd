extends Node2D

export (PackedScene) var Ball

onready var Press = $Main/MainMenu/Press
onready var LoseMenu = $Main/LoseMenu
onready var MainMenu = $Main/MainMenu
onready var Max = $Main/Max
onready var Leaderboard = $Main/MainMenu/Leaderboard
onready var PlayerBall = $PlayerBall
onready var Title = $Main/MainMenu/Title
onready var Desc = $Main/MainMenu/Desc
onready var Score = $Main/Score
onready var Audio = $Main/Audio
onready var Nick = $Main/MainMenu/Nick

var score = 0
var ended = false
func _ready():
	Press.connect("button_up",self,"start_game")
	LoseMenu.get_node("PlayAgain").connect("button_up",self,"restart")
	Max.text = "Max:" + str(Global.max_record)
	Leaderboard.connect("button_up", self, "leaderboard")
	if Global.nickname != "":
		Nick.text = Global.nickname
	randomize()

func start_game():
	PlayerBall.can_move = true
	MainMenu.hide()
	Score.show()
	if Nick.text == "":
		Global.nickname = "Anonymous"
	else:
		Global.nickname = Nick.text
		Global.save_data(Nick.text, "nick.dat")
	for i in 24:
		instance_ball(false)

func restart():
	get_tree().paused = false
	get_tree().reload_current_scene()

func end():
	if not ended:
		ended = true
		get_tree().paused = true
		if Global.max_record < score:
			Global.max_record = score
			Global.save_data(Global.max_record, "record.dat")
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
