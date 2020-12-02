extends Area2D

export (Array,int) var bestscore
export (Array,int) var midscore
var unlocked = true

func level_locked():
	unlocked = false
	$Sprite.texture.region = Rect2(0, 123, 180, 123)

func level_unlocked():
	unlocked = true
	$Sprite.texture.region = Rect2(0,0,180,123)