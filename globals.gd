extends Node2D

# top tier code ftw
# written by adrian

var in_motion: bool = false

func _on_ground_exited(area: Area2D) -> void:
	in_motion = true

func _on_ground_entered(area: Area2D) -> void:
	in_motion = false
