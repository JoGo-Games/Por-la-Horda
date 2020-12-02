extends Control

var menu_controller
var previous_menu
var page = 1

func _ready():
	menu_controller = get_parent()

func _on_BackButton_pressed():
	if page == 2:
		page-=1
		change_page(false)
	else:
		menu_controller.animate_menu(1,previous_menu,"GuideMenu")

func _on_NextButton_pressed():
	page+=1
	change_page(true)

func change_page(_next):
	if _next:
		$Background/VBoxContainer/TextureRect.texture.region = Rect2(0,568,1340,568)
		$Background/VBoxContainer/HBoxContainer/NextButton.visible = false
		$Background/VBoxContainer/HBoxContainer/ExitButton.visible = true
	if !_next:
		$Background/VBoxContainer/TextureRect.texture.region = Rect2(0,0,1340,568)
		$Background/VBoxContainer/HBoxContainer/NextButton.visible = true
		$Background/VBoxContainer/HBoxContainer/ExitButton.visible = false


func _on_ExitButton_pressed():
	menu_controller.animate_menu(1,previous_menu,"GuideMenu")
