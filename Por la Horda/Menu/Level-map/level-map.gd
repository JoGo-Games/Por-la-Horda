extends Area2D

export (Array,int) var bestscore
export (Array,int) var midscore
var unlocked = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func level_locked():
	unlocked = false
	$Sprite.texture.region = Rect2(0, 123, 180, 123)
