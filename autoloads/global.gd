extends Node

var max_record = 0
var nickname = ""
const APIKEY = "h1akn3lo9v5ZURxPgmOqM4Pq7vFylmGsa5P29bmI"
const GAMEID = "TheBallGame1"

func _ready():
	var new_nick = load_data("nick.dat")
	if new_nick != null:
		nickname = new_nick
	var new_record = load_data("record.dat")
	if new_record != null:
		max_record = new_record
	SilentWolf.configure({
	"api_key": APIKEY,
	"game_id": GAMEID,
	"game_version": "1.0.0",
	"log_level": 1
	})
	SilentWolf.configure_scores({
	"open_scene_on_close": "res://scenes/game/Game.tscn"
	})

func save_data(data, filename):
	var file = File.new()
	file.open("user://"+filename, file.WRITE)
	file.store_var(data)
	file.close()

func load_data(filename):
	var file = File.new()
	if not file.file_exists("user://"+filename):
		return
	file.open("user://"+filename, file.READ)
	var data = file.get_var()
	file.close()
	return data
