extends RigidBody2D

# written by adrian

@export var jump_impulse := 1000.0

func _input(event: InputEvent) -> void:
	
	var shoot_dir := global_position.direction_to(get_global_mouse_position())
	
	if Input.is_action_just_pressed("launch"):
		apply_central_impulse(shoot_dir * jump_impulse)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
