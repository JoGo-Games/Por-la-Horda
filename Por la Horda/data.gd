extends Node

#Datos de guardado

const PATH = "user://data.save"
var loaded = false

var data = { #Datos que serán guardados y cargados 
	"level_unlocked" : 1,
	"sound_on" : true,
	"music_on" : true,
	"secscore_1" : 0,
	"minscore_1" : 0,
	"stars_1" : 0,
	"secscore_2" : 0,
	"minscore_2" : 0,
	"stars_2" : 0,
	"secscore_3" : 0,
	"minscore_3" : 0,
	"stars_3" : 0,
	"secscore_4" : 0,
	"minscore_4" : 0,
	"stars_4" : 0,
	"secscore_5" : 0,
	"minscore_5" : 0,
	"stars_5" : 0,
	}

func _ready(): #Busca y carga el archivo de datos o lo crea si aun no existe
	var pathfile = File.new()
	if pathfile.file_exists(PATH):
		load_data()
	else:
		save_data()
		load_data()

func load_data(): #Carga todos los datos y los asigna a las variables de la clase global
	if loaded:
		return

	var loadfile = File.new()
	loadfile.open(PATH,loadfile.READ)
	data = parse_json(loadfile.get_line())
	global.level_unlocked = data["level_unlocked"]
	global.sound_on = data["sound_on"]
	global.music_on = data["music_on"]
	global.level_score["secscore_1"] = data["secscore_1"]
	global.level_score["minscore_1"] = data["minscore_1"]
	global.level_score["stars_1"] = data["stars_1"]
	global.level_score["secscore_2"] = data["secscore_2"]
	global.level_score["minscore_2"] = data["minscore_2"]
	global.level_score["stars_2"] = data["stars_2"]
	global.level_score["secscore_3"] = data["secscore_3"]
	global.level_score["minscore_3"] = data["minscore_3"]
	global.level_score["stars_3"] = data["stars_3"]
	global.level_score["secscore_4"] = data["secscore_4"]
	global.level_score["minscore_4"] = data["minscore_4"]
	global.level_score["stars_4"] = data["stars_4"]
	global.level_score["secscore_5"] = data["secscore_5"]
	global.level_score["minscore_5"] = data["minscore_5"]
	global.level_score["stars_5"] = data["stars_5"]
	loadfile.close()
	loaded = true
	
func save_data(): #Sobreescribe el archivo de datos con los datos actualizados
	var savefile = File.new()
	savefile.open(PATH,savefile.WRITE)
	data_update()
	savefile.store_line(to_json(data))
	savefile.close()
	loaded = false

func data_update(): #Actualiza los datos guardados con los valores de las variables de global
	data = {
	"level_unlocked" : global.level_unlocked,
	"sound_on" : global.sound_on,
	"music_on" : global.music_on,
	"secscore_1" : global.level_score["secscore_1"],
	"minscore_1" : global.level_score["minscore_1"],
	"stars_1" : global.level_score["stars_1"],
	"secscore_2" : global.level_score["secscore_2"],
	"minscore_2" : global.level_score["minscore_2"],
	"stars_2" : global.level_score["stars_2"],
	"secscore_3" : global.level_score["secscore_3"],
	"minscore_3" : global.level_score["minscore_3"],
	"stars_3" : global.level_score["stars_3"],
	"secscore_4" : global.level_score["secscore_4"],
	"minscore_4" : global.level_score["minscore_4"],
	"stars_4" : global.level_score["stars_4"],
	"secscore_5" : global.level_score["secscore_5"],
	"minscore_5" : global.level_score["minscore_5"],
	"stars_5" : global.level_score["stars_5"],
	}