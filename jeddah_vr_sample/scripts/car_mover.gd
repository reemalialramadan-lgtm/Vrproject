# Circular car mover - makes a MeshInstance3D move in a circle around the tower
extends Node3D

@export var radius: float = 50.0
@export var speed: float = 0.6        # revolutions per minute-ish
@export var height: float = 0.5
@export var offset: float = 0.0       # initial angle offset in radians
var angle := 0.0

func _ready():
    angle = offset

func _process(delta):
    # speed is in rotations per second scaled small
    angle += speed * delta
    var x = cos(angle) * radius
    var z = sin(angle) * radius
    global_transform.origin = Vector3(x, height, z)
    look_at(Vector3(0, height, 0), Vector3.UP)
