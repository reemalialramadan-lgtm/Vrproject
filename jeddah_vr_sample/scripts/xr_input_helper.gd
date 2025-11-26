extends Node

# xr_input_helper.gd
# Helper that maps XR controller axes and buttons to Godot Input actions.
# Attach this to your XROrigin3D node or a central controller manager.

@export var left_controller_node_path: NodePath = "LeftController"
@export var right_controller_node_path: NodePath = "RightController"

# Axis indexes (common defaults) — adjust after inspecting DebugOverlay output
@export var thumbstick_x_axis_index := 0
@export var thumbstick_y_axis_index := 1
@export var trigger_axis_index := 2

@export var axis_deadzone: float = 0.35

# Button indexes (best guess for many controllers) — may vary between runtimes
@export var button_primary_index := 0 # A / trigger button fallback
@export var button_secondary_index := 1 # B / grip / alternate
@export var button_menu_index := 2

func _process(delta):
    var left = get_node_or_null(left_controller_node_path)
    var right = get_node_or_null(right_controller_node_path)

    _process_controller(left, true)
    _process_controller(right, false)

func _process_controller(controller: Node, is_left: bool):
    if controller == null or not controller.is_inside_tree():
        return

    # Read axes if available
    var x = 0.0
    var y = 0.0
    var trigger_val = 0.0
    if controller.has_method("get_joystick_axis"):
        x = controller.get_joystick_axis(thumbstick_x_axis_index)
        y = controller.get_joystick_axis(thumbstick_y_axis_index)
        # many controllers expose triggers as axes too
        trigger_val = controller.get_joystick_axis(trigger_axis_index)

    # Map thumbstick to movement actions (left controller commonly handles locomotion)
    if is_left:
        if y < -axis_deadzone:
            Input.action_press("move_forward")
        else:
            Input.action_release("move_forward")

        if y > axis_deadzone:
            Input.action_press("move_back")
        else:
            Input.action_release("move_back")

        if x < -axis_deadzone:
            Input.action_press("move_left")
        else:
            Input.action_release("move_left")

        if x > axis_deadzone:
            Input.action_press("move_right")
        else:
            Input.action_release("move_right")

    # Trigger -> interact
    if trigger_val > 0.5:
        Input.action_press("interact")
    else:
        Input.action_release("interact")

    # Buttons
    if controller.has_method("is_button_pressed"):
        if controller.is_button_pressed(button_secondary_index):
            Input.action_press("enter_tower")
        else:
            Input.action_release("enter_tower")

        if controller.is_button_pressed(button_menu_index):
            Input.action_press("menu")
        else:
            Input.action_release("menu")

# Optional: export an API to query state programmatically
func get_button_mapping_info():
    return {
        "thumbstick_x_index": thumbstick_x_axis_index,
        "thumbstick_y_index": thumbstick_y_axis_index,
        "trigger_index": trigger_axis_index,
        "primary_button": button_primary_index,
        "secondary_button": button_secondary_index,
        "menu_button": button_menu_index
    }
