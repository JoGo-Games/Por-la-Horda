extends Control

var menu_controller
var previous_menu
var page = 1
var texture_rect_y = 0

func _ready():
	menu_controller = get_parent()

func _on_BackButton_pressed():
	if page >= 2:
		page-=1
		texture_rect_y -= 600
		change_page()
	else:
		menu_controller.animate_menu(1,previous_menu,"StoryMenu")

func _on_NextButton_pressed():
	page+=1
	texture_rect_y += 600
	change_page()

func change_page():
	$Background/VBoxContainer/TextureRect.texture.region = Rect2(0,texture_rect_y,1350,600)
	if page == 5:
		$Background/VBoxContainer/HBoxContainer/NextButton.visible = false
		$Background/VBoxContainer/HBoxContainer/ExitButton.visible = true
	else:
		if $Background/VBoxContainer/HBoxContainer/ExitButton.visible == true:
			$Background/VBoxContainer/HBoxContainer/NextButton.visible = true
			$Background/VBoxContainer/HBoxContainer/ExitButton.visible = false


func _on_ExitButton_pressed():
	menu_controller.animate_menu(1,previous_menu,"StoryMenu")
