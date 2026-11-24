extends Node2D

@export var minHeight: float
@export var maxHeight: float


var speed: float

func _ready() -> void:
	var spawnHeight = randf_range(minHeight, maxHeight)
	var direction = randi_range(1,2)
	
	if direction == 1:
		position = Vector2(-100, spawnHeight)
		speed = 230
	else:
		position = Vector2(1060, spawnHeight)
		speed = -230

func _process(delta: float) -> void:
	position.x += delta * speed
	if position.x > 1060 or position.x < -100:
		queue_free()
