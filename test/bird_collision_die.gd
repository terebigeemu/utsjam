#extends AnimatableBody2D
#
#var alive: bool = true;
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if alive == false:
		#AnimatedSprite.queue_free()
#
#
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#alive = false
	#print("not alive anymore")
