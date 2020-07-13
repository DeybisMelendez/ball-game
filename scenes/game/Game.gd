extends Node2D

export (PackedScene) var Ball
var score = 0
var is_android = OS.get_name() == "Android"
func _ready():
	$CanvasLayer/Press.connect("button_up",self,"start_game")
	$CanvasLayer/Ups.connect("button_up",self,"restart")
	$CanvasLayer/Max.text = "Max:" + str(Global.max_record)
	$CanvasLayer/Leaderboard.connect("button_up", self, "leaderboard")
	randomize()
	if is_android:
		Ads.Mopub.show_banner_ad(true)

func start_game():
	$PlayerBall.can_move = true
	$CanvasLayer/Title.hide()
	$CanvasLayer/Press.hide()
	$CanvasLayer/Leaderboard.hide()
	$CanvasLayer/Title3.hide()
	$CanvasLayer/Score.show()
	for i in 24:
		instance_ball(false)

func restart():
	Ads.Mopub.show_interstitial_ad()
	get_tree().paused = false
	get_tree().reload_current_scene()


func end():
	get_tree().paused = true
	if Global.max_record < score:
		Global.max_record = score
		Global.save_data(Global.max_record, "data.dat")
		get_tree().paused = false
		$CanvasLayer/AudioStreamPlayer.play()
		yield($CanvasLayer/AudioStreamPlayer,"finished")
		get_tree().change_scene("res://scenes/new_record/NewRecord.tscn")
	else:
		$CanvasLayer/AudioStreamPlayer.play()
		$CanvasLayer/Ups.show()

func instance_ball(add_score):
	var new = Ball.instance()
	new.scale_size = $PlayerBall.scale_size * rand_range(0.2,1.5)
	new.position = Vector2((randf() *2 -1)*720, (randf() *2 -1)*1280)
	call_deferred("add_child", new)
	if add_score:
		score += 1
		$CanvasLayer/Score.text = str(score)

func leaderboard():
	get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")
