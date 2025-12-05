extends CanvasLayer

# Interior UI Manager for TowerInterior scene - handles exit button

@onready var exit_btn = get_node("ExitBtn")

func _ready():
	# Connect exit button signal
	exit_btn.pressed.connect(_on_exit_pressed)
	print("Interior UI Manager ready. Exit button connected.")

func _on_exit_pressed():
	print("Exit button pressed - returning to Plaza")
	get_tree().change_scene_to_file("res://scenes/Plaza.tscn")
