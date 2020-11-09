extends Camera2D

func _ready():  
    set_process_input(true)

func _input(event):
    if event == InputEventScreenDrag:
        self.move_local_x(event.relative_x)
        self.move_local_y(event.relative_y)
