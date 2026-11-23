extends RigidBody2D

# written by adrian

@export var jump_impulse := 1000.0
@export var movement_threshold := 700

func _input(event: InputEvent) -> void:
	
	var shoot_dir := global_position.direction_to(get_global_mouse_position())
	
	if Input.is_action_just_pressed("launch") and Globals.in_motion == false:
		apply_central_impulse(shoot_dir * jump_impulse)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Globals.in_motion == false:
		look_at(get_global_mouse_position())		
	
	if (linear_velocity.length_squared() > movement_threshold) or (angular_velocity > movement_threshold):
		Globals.in_motion = true
		print("true")
	else:
		Globals.in_motion = false
		print("false")
