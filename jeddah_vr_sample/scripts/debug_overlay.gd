extends CanvasLayer

@onready var label: RichTextLabel = $Panel/Label

# Polling interval to avoid spamming the UI. Show up to ~10 updates/sec
var tick = 0.0
var poll_interval = 0.1

func _process(delta):
    tick += delta
    if tick < poll_interval:
        return
    tick = 0
    _update_debug()

func _update_debug():
    var out = "[b]INTERNAL INPUT DEBUG[/b]\n"

    # Keyboard status (helpful on desktop)
    out += "[b]Keys pressed:[/b] "
    var keys = []
    for key in ["w","a","s","d","space","t"]:
        if Input.is_key_pressed( OS.find_scancode_from_string(key) ): # may return -1 for named keys
            keys.append(key)
    if keys.empty():
        out += "(none)\n"
    else:
        out += "%s\n".format(keys.join(", "))

    # Connected joystick/VR controllers
    var joypads = Input.get_connected_joypads()
    out += "[b]Connected joypads:[/b] %d\n" % joypads.size()
    for id in joypads:
        out += "  - id=%d name=%s\n" % [id, Input.get_joy_name(id)]
        # show first 8 axis values
        var axis_count = 8
        for a in range(axis_count):
            var val = Input.get_joy_axis(id, a)
            out += "    axis[%d]=%.3f  " % [a, val]
        out += "\n"
        # show button states for first 12 buttons (common range)
        var bcount = 12
        out += "    buttons: "
        for b in range(bcount):
            if Input.is_joy_button_pressed(id, b):
                out += "%d " % b
        out += "\n"

    # Try to detect XR nodes / XR controllers if present
    var left = get_tree().get_root().find_node("LeftController", true, false)
    var right = get_tree().get_root().find_node("RightController", true, false)
    if left:
        out += "[b]LeftController found[/b]\n"
        # print transform
        if left.has_method("get_global_transform"):
            var t = left.global_transform
            out += "  pos: (%.2f, %.2f, %.2f)\n" % [t.origin.x, t.origin.y, t.origin.z]
    if right:
        out += "[b]RightController found[/b]\n"
        if right.has_method("get_global_transform"):
            var t = right.global_transform
            out += "  pos: (%.2f, %.2f, %.2f)\n" % [t.origin.x, t.origin.y, t.origin.z]

    # Show input actions state for common actions
    var actions = ["move_forward","move_back","move_left","move_right","teleport","interact","enter_tower","menu"]
    out += "[b]Actions:[/b]\n"
    for a in actions:
        out += "  %s: %s\n" % [a, str(Input.is_action_pressed(a))]

    label.bbcode_text = out
