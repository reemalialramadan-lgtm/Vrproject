# Drone mover - flies in a circle above the tower and gently bobs up and down
extends Node3D

@export var radius: float = 35.0
@export var speed: float = 0.35
@export var base_height: float = 12.0
@export var bob_amplitude: float = 1.0
@export var bob_speed: float = 2.0
@export var offset: float = 0.0

var t := 0.0

func _ready():
    t = offset

func _process(delta):
    t += speed * delta
    var x = cos(t + offset) * radius
    var z = sin(t + offset) * radius
    var y = base_height + sin(OS.get_ticks_msec() / 1000.0 * bob_speed + offset) * bob_amplitude
    global_transform.origin = Vector3(x, y, z)
    look_at(Vector3(0, base_height, 0), Vector3.UP)
