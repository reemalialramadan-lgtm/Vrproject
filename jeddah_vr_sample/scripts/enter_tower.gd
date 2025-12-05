extends Node

# Tower transition handler - manages scene changes between Plaza and TowerInterior

@export var interior_scene: PackedScene

func _ready():
	# If this script is attached to a node in TowerInterior, handle exit button
	pass

func _on_enter_tower_pressed():
	"""Called when user presses 'Enter Tower' button in Plaza menu"""
	if interior_scene:
		get_tree().change_scene_to_file(interior_scene.resource_path)
	else:
		push_error("Interior scene not assigned!")

func exit_to_plaza():
	"""Called when user presses 'Exit' button in TowerInterior"""
	get_tree().change_scene_to_file("res://scenes/Plaza.tscn")

