extends Sprite2D

# written by adrian

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.in_motion == false:
		look_at(get_global_mouse_position())
