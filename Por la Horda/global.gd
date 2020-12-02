extends Node

var level_unlocked = 1
var level_score = {
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
var level_buttons:int
var current_scene = null
var current_level = 1
var current_bestscore
var current_bestscore_total
var current_midscore
var current_midscore_total
var sound_on = true
var music_on = true

onready var Map = preload("res://Menu/Map/Map.tscn")
onready var Game = preload("res://Game/game.tscn")
onready var Main = preload("res://Menu/MenuController.tscn")

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	set_sound(false)
	set_music(false)
	
func change_scene(_scene, _current_level):
	call_deferred("set_scene",_scene)

func set_scene(_scene):
	current_scene.free()
	if _scene == "MainMenu":
		current_scene = Main.instance()
	if _scene == "Map":
		current_scene = Map.instance()
	if _scene == "Game":
		current_scene = Game.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

func set_sound(_change):
	if _change:
		sound_on = !sound_on
		data.save_data()
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Sfx"), !sound_on)   

func set_music(_change):
	if _change:
		music_on = !music_on
		data.save_data()
	AudioServer.set_bus_mute(AudioServer.get_bus_index("BGM"), !music_on)  

func set_current_score(_score,_index):
	if _index == 1:
		current_bestscore = _score
		current_bestscore_total = current_bestscore[0]*60 + current_bestscore[1]
	if _index == 2:
		current_midscore = _score
		current_midscore_total = current_midscore[0]*60 + current_midscore[1]