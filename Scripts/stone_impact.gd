extends Area2D

@onready var stone_impact = get_node("../StoneImpact")

# adrian

func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		stone_impact.play()
