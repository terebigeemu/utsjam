extends Area2D

# written by adrian

func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		print("RigidBody2D entered area: ", body.name)
		Globals.touched_ground = true
		body.freeze = true
		body.linear_velocity = Vector2.ZERO
		body.angular_velocity = 0.0
		body.reparent(self)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
