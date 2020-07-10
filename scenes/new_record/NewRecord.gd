extends Control

func _ready():
	$Label2.connect("button_up",self,"restart")
	$Label.text += str(Global.max_record)

func restart():
	get_tree().change_scene("res://scenes/game/Game.tscn")
