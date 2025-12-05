extends CanvasLayer

# UI Manager for Plaza scene - handles button interactions

@onready var btn_explore = get_node("../UIRoot/MenuPanel/VBox/BtnExplore")
@onready var btn_interior = get_node("../UIRoot/MenuPanel/VBox/BtnInterior")
@onready var btn_back = get_node("../UIRoot/BtnBack")
@onready var player = get_node("../Player")
@onready var menu_panel = get_node("../UIRoot/MenuPanel")

@export var interior_scene: PackedScene

var menu_visible = true

func _ready():
	# Connect button signals
	btn_explore.pressed.connect(_on_explore_pressed)
	btn_interior.pressed.connect(_on_interior_pressed)
	btn_back.pressed.connect(_on_back_pressed)
	
	# Show menu by default
	show_menu()

func show_menu():
	menu_visible = true
	menu_panel.visible = true
	btn_back.visible = false
	if player:
		player.set_process(false)  # Disable player movement while menu is open

func hide_menu():
	menu_visible = false
	menu_panel.visible = false
	btn_back.visible = true
	if player:
		player.set_process(true)  # Enable player movement

func _on_explore_pressed():
	print("Explore Exterior button pressed")
	hide_menu()

func _on_interior_pressed():
	print("Enter Tower Interior button pressed")
	if interior_scene:
		get_tree().change_scene_to_file(interior_scene.resource_path)
	else:
		push_error("Interior scene not assigned in UIManager!")

func _on_back_pressed():
	print("Back button pressed")
	show_menu()
