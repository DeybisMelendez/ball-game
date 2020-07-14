extends Control

onready var is_html = OS.get_name()=="HTML5"

func _ready():
	$Label2.connect("button_up",self,"restart")
	$Label.text += str(Global.max_record)

func restart():
	if $LineEdit.text == "":
		OS.alert("Please, put your name", "Alert!")
	else:
		SilentWolf.Scores.persist_score($LineEdit.text, Global.max_record)
		get_tree().change_scene("res://scenes/game/Game.tscn")
