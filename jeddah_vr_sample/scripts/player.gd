extends Node3D

# Minimal placeholder player controller intended for VR usage.
# Replace this with OpenXR/XR origin and controllers in your main project.

@export var speed : float = 3.0

func _physics_process(delta):
    # placeholder: no real VR input here. Add Input mappings or XR controller handling.
    var dir = Vector3.ZERO
    if Input.is_action_pressed("move_forward"):
        dir += -transform.basis.z
    if Input.is_action_pressed("move_back"):
        dir += transform.basis.z
    if Input.is_action_pressed("move_left"):
        dir += -transform.basis.x
    if Input.is_action_pressed("move_right"):
        dir += transform.basis.x

    if dir.length() > 0.1:
        global_translate(dir.normalized() * speed * delta)

func teleport_to_marker(marker: Node3D):
    global_transform.origin = marker.global_transform.origin

