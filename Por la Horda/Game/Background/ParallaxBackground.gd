extends ParallaxBackground

export (float) var _offset = 0
var _off

func _ready():
	_off = _offset

func _process(delta):
	_offset -= _off
	
	#Movimiento del parallax
	scroll_offset = Vector2(_offset, 0)