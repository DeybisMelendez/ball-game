extends Node

var max_record = load_data("data.dat")

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
