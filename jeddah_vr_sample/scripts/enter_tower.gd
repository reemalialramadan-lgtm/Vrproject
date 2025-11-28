extends Node

@export var interior_scene: PackedScene

func _ready():
    # Hook example: connect button press to _on_enter_tower
    pass

func _on_enter_tower_pressed():
    if interior_scene:
        # smooth fade and change
        get_tree().change_scene_to(interior_scene)

func exit_to_plaza():
    get_tree().change_scene("res://scenes/Plaza.tscn")
