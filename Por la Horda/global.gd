extends Node

var level_unlocked = 1
var level_buttons:int
var current_scene = null
var current_level = 1
var current_bestscore
var current_midscore

onready var Map = preload("res://Menu/Map/Map.tscn")
onready var Game = preload("res://Game/game.tscn")

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_scene(_scene, _current_level):
	if _current_level > 0:
		current_level = _current_level
	call_deferred("set_scene",_scene)


func set_scene(_scene):
	current_scene.free()
	if _scene == "Map":
		current_scene = Map.instance()
	if _scene == "Game":
		current_scene = Game.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)