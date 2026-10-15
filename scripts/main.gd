extends Node3D

# Raat Ki Aakhri Sawari - First-Person Horror Prototype
# Godot 4.3 compatible

var is_anomaly := false
var camera_holder: Node3D
var head: Node3D
var title_label: Label
var hint_label: Label
var button_front: Button
var button_rear: Button
var button_anomaly: Button
var anomaly_label: Label
var joy_stick: Control

# Touch joystick
var touch_start := Vector2.ZERO
var joy_start_pos := Vector2.ZERO
var joy_current_pos := Vector2.ZERO
var joy_active := false
var joy_offset := Vector2.ZERO

# Movement
const MOVE_SPEED := 3.0
const LOOK_SPEED := 0.003
var vertical_rotation := 0.0

# Respawn position
var respawn_position := Vector3(0, 1.2, 0)
var respawn_rotation := 0.0

func _ready():
	camera_holder = get_node("CameraHolder")
	head = get_node("CameraHolder/Head")
	title_label = get_node("CameraHolder/HUD/TitleLabel")
	hint_label = get_node("CameraHolder/HUD/HintLabel")
	button_front = get_node("CameraHolder/HUD/ButtonFront")
	button_rear = get_node("CameraHolder/HUD/ButtonRear")
	button_anomaly = get_node("CameraHolder/HUD/ButtonAnomaly")
	anomaly_label = get_node("CameraHolder/HUD/AnomalyLabel")
	joy_stick = get_node("CameraHolder/HUD/JoyStick")
	
	# Mouse setup for desktop
	get_viewport().set_input_as_handled()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# Connect button signals
	button_front.pressed.connect(_on_button_front_pressed)
	button_rear.pressed.connect(_on_button_rear_pressed)
	button_anomaly.pressed.connect(_on_button_anomaly_pressed)
	
	# Initial hint text
	hint_label.text = "Use WASD to move. Mouse to look. FRONT or REAR to exit."


func _input(event):
	# Mouse look (desktop)
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * LOOK_SPEED)
		vertical_rotation -= event.relative.y * LOOK_SPEED
		vertical_rotation = clamp(vertical_rotation, -80.0, 80.0)
		head.rotation.x = deg_to_rad(-vertical_rotation)
	
	# Pointer/joystick movement (mobile/touch)
	if event is InputEventScreenTouch:
		if event.pressed:
			if _is_in_joystick_area(event.position):
				joy_active = true
				joy_start_pos = event.position
				joy_current_pos = event.position
				touch_start = event.position
			elif _is_in_button_area(event.position, button_front.rect_position, button_front.rect_size):
				_on_button_front_pressed()
			elif _is_in_button_area(event.position, button_rear.rect_position, button_rear.rect_size):
				_on_button_rear_pressed()
			elif _is_in_button_area(event.position, button_anomaly.rect_position, button_anomaly.rect_size):
				_on_button_anomaly_pressed()
		else:
			joy_active = false
	
	if event is InputEventScreenDrag and joy_active:
		joy_current_pos = event.position
		joy_offset = (joy_current_pos - joy_start_pos).normalized() * 2.0
		var move_dir = joy_offset
		if move_dir.length() > 0.1:
			_handle_movement(move_dir)


func _process(delta):
	# Touch joystick visual feedback
	if joy_active:
		joy_stick.position = joy_start_pos + (joy_current_pos - joy_start_pos).normalized() * min((joy_current_pos - joy_start_pos).length(), 60.0)
	else:
		joy_stick.position = joy_start_pos


func _handle_movement(move_dir: Vector2):
	var forward = -transform.basis.z
	forward.y = 0
	forward = forward.normalized()
	
	var right = transform.basis.x
	right.y = 0
	right = right.normalized()
	
	var movement = forward * (-move_dir.y) + right * move_dir.x
	movement = movement.normalized() * MOVE_SPEED * delta
	
	transform.origin += movement


func _unhandled_input(event):
	# Keyboard/mouse movement
	if event is InputEventKey:
		if event.pressed:
			var dir := Vector3.ZERO
			match event.keycode:
				KEY_W, KEY_UP:
					dir -= transform.basis.z
				KEY_S, KEY_DOWN:
					dir += transform.basis.z
				KEY_A, KEY_LEFT:
					dir -= transform.basis.x
				KEY_D, KEY_RIGHT:
					dir += transform.basis.x
			
			if dir != Vector3.ZERO:
				dir.y = 0
				dir = dir.normalized() * MOVE_SPEED
				transform.origin += dir * 0.02


func _on_button_front_pressed():
	if not is_anomaly:
		# Normal mode: FRONT is correct exit
		title_label.text = "You found the way out! The coach fades..."
		hint_label.text = "S-8 resolved. Normal timeline saved."
		get_tree().create_timer(3.0).timeout.connect(func(): _respawn())
	else:
		# Anomaly mode: FRONT is wrong
		title_label.text = "The door slams shut. Something is wrong."
		hint_label.text = "Wrong exit in anomaly state! Respawning..."
		hint_label.add_theme_color_override("font_color", Color.RED)
		get_tree().create_timer(2.0).timeout.connect(func(): _respawn())


func _on_button_rear_pressed():
	if is_anomaly:
		# Anomaly mode: REAR is correct exit
		title_label.text = "You found the hidden exit! The anomaly is sealed."
		hint_label.text = "Anomaly contained. Train continues..."
		get_tree().create_timer(3.0).timeout.connect(func(): _respawn())
	else:
		# Normal mode: REAR is wrong
		title_label.text = "The rear door is bolted shut."
		hint_label.text = "Wrong exit! Go FRONT when things are normal."
		hint_label.add_theme_color_override("font_color", Color.RED)
		get_tree().create_timer(2.0).timeout.connect(func(): _respawn())


func _on_button_anomaly_pressed():
	is_anomaly = not is_anomaly
	if is_anomaly:
		title_label.text = "Raat Ki Aakhri Sawari — 02:15 AM"
		hint_label.text = "ANOMALY DETECTED — Only REAR exit works now."
		hint_label.add_theme_color_override("font_color", Color(1, 0.4, 0.4))
		anomaly_label.visible = true
		# Darken scene slightly
		get_node("CameraHolder/CeilingLight1").energy = 0.3
		get_node("CameraHolder/CeilingLight2").energy = 0.3
	else:
		title_label.text = "Raat Ki Aakhri Sawari — 02:15 AM"
		hint_label.text = "Normal mode restored. Only FRONT exit works."
		hint_label.add_theme_color_override("font_color", Color.WHITE)
		anomaly_label.visible = false
		# Restore lights
		get_node("CameraHolder/CeilingLight1").energy = 0.8
		get_node("CameraHolder/CeilingLight2").energy = 0.8


func _respawn():
	# Reset to starting position (S-8 coach spawn)
	transform.origin = respawn_position
	rotation_degrees.y = respawn_rotation
	vertical_rotation = 0.0
	head.rotation.x = 0.0
	is_anomaly = false
	title_label.text = "Raat Ki Aakhri Sawari — 02:15 AM"
	hint_label.text = "Use WASD to move. Mouse to look. FRONT or REAR to exit."
	hint_label.add_theme_color_override("font_color", Color.WHITE)
	anomaly_label.visible = false
	get_node("CameraHolder/CeilingLight1").energy = 0.8
	get_node("CameraHolder/CeilingLight2").energy = 0.8


func _is_in_joystick_area(position: Vector2) -> bool:
	var rect := Rect2(joy_stick.position, joy_stick.size)
	return rect.has_point(position)


func _is_in_button_area(position: Vector2, btn_pos: Vector2, btn_size: Vector2) -> bool:
	var rect := Rect2(btn_pos, btn_size)
 return rect.has_point(position)
