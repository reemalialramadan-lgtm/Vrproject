WebXR controller mapping & verification guide for Godot 4 (Web export)

Overview
- WebXR controllers expose a set of inputs: buttons (trigger, grip), axes (thumbstick), and poses (position/rotation). Godot receives WebXR input via OpenXR runtime or through the HTML5 export's WebXR bridge.
- This guide shows how to map those inputs to Godot InputMap actions and provides example scripts to handle controller input and verify in-headset.

Recommended input actions
- move_forward (Axis via left thumbstick Y negative)
- move_back (Axis via left thumbstick Y positive)
- move_left (Axis via left thumbstick X negative)
- move_right (Axis via left thumbstick X positive)
- teleport (Button -> primary / A / X depending on controller)
- interact (Button -> trigger)
- enter_tower (Button -> secondary or UI touch)
- menu (Button -> menu button)

Configuring InputMap in Godot
- Use the Godot editor: Project -> Project Settings -> Input Map
- Add the actions above, then add the fallback inputs you want to support (keyboard for desktop testing, joystick mappings, and custom code to read XR controller buttons). Example mappings:
  - move_forward -> Keyboard W, Gamepad Left Stick Y axis negative
  - teleport -> Key T, JoyButton 0 (controller button mapped), OR handle in XR script

Sample XR controller reader (GDScript)
Add to an XR-aware script attached to your player or XROrigin node.

```
# sample_xr_input.gd
extends Node

# these are custom action names mentioned above
func _process(delta):
    # For WebGL builds we rely on the XR controllers to supply input via XRController3D nodes.
    var left = $XROrigin/LeftController
    var right = $XROrigin/RightController

    if left and left.is_instance_valid():
        # trigger value (0..1)
        var trigger_val = left.get_joystick_axis(AnalogList.TRIGGER) if left.has_method("get_joystick_axis") else 0
        if trigger_val > 0.5:
            Input.action_press("interact")
        else:
            Input.action_release("interact")

        # thumbstick axes example (use actual axis indexes depending on controller)
        var x = left.get_joystick_axis(0)
        var y = left.get_joystick_axis(1)
        if y < -0.4:
            Input.action_press("move_forward")
        else:
            Input.action_release("move_forward")

        if y > 0.4:
            Input.action_press("move_back")
        else:
            Input.action_release("move_back")

        if x < -0.4:
            Input.action_press("move_left")
        else:
            Input.action_release("move_left")

        if x > 0.4:
            Input.action_press("move_right")
        else:
            Input.action_release("move_right")

    # Simple button press (e.g., secondary button) -> enter tower action
    if right and right.is_instance_valid():
        if right.is_button_pressed(0): # pseudo: check which button index maps on web build
            Input.action_press("enter_tower")
        else:
            Input.action_release("enter_tower")

```

Controller index mapping notes
- Button/axis indices vary by browser and controller model. During testing, print all available axes and button states to console to find the correct indices.
- The WebXR emulator on desktop can help: WebXR Emulator extension exposes controller values to test.

Verification checklist (in-headset)
1. Deploy the web build (Netlify or gh-pages) and open it in your headset browser over HTTPS.
2. Use the browser devtools or an on-screen debug overlay to print controller axis/button states.
3. Verify each action:
   - Thumbstick movement -> player movement or teleport
   - Trigger -> interact with kiosks/hotspots
   - A / B or grip -> enter/exit tower / open menu
4. If mapping is off: adjust axis indexes and button indices in the XR input script.

Debugging tips
- Add an in-VR debug overlay (a small panel that prints InputEvent details) so you can see the actual values in headset.
- Fallback to touch/mouse interactions for users without controllers.
- Keep movement minimal and use teleport or short smooth steps to reduce motion sickness.

Reference
- Godot docs (XR / OpenXR)
- WebXR spec & emulator tools
- Your headset browser WebXR compatibility docs (Meta Browser for Brain/Meta 2)
