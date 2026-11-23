extends RigidBody2D

# written by adrian

@export var jump_impulse := 1000.0
@export var movement_threshold := 700

var should_teleport := false
var target_pos := Vector2.ZERO

func _input(event: InputEvent) -> void:
	
	#var shoot_dir := global_position.direction_to(get_global_mouse_position())
	
	if Input.is_action_just_pressed("launch") and Globals.in_motion == false:
		target_pos = get_global_mouse_position()
		should_teleport = true
		Globals.throw_in_progress.emit(true)
		#apply_central_impulse(shoot_dir * jump_impulse)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Globals.in_motion == false:
		look_at(get_global_mouse_position())		
	
	if (linear_velocity.length_squared() > movement_threshold) or (angular_velocity > movement_threshold):
		Globals.in_motion = true
	else:
		Globals.in_motion = false
		
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if should_teleport == true:
		state.transform.origin = target_pos
		state.linear_velocity = Vector2.ZERO # Optional: stops old momentum
		should_teleport = false
