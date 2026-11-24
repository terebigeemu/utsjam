extends Control

var tutorial_scene = preload("res://tutorial_overlay.tscn")

func _on_timer_timeout() -> void:
	position.x = 100000000000
