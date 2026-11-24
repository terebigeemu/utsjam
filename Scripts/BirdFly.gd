extends Node2D

@export var minHeight: float
@export var maxHeight: float

@onready var sounds = [$PIGEON1, $PIGEON2, $PIGEON3, $PIGEON4, $PIGEON5, $PIGEON6, $PIGEON7, $PIGEON8, $PIGEON9, $PIGEON10]
var soundIndex
var soundChance1
var speed: float
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var spawnHeight = randf_range(minHeight, maxHeight)
	var direction = randi_range(1,2)
	soundChance1 = rng.randf_range(10, 20)
	soundIndex = rng.randf_range(0, 10.0)
	
	if direction == 1:
		position = Vector2(-100, spawnHeight)
		speed = 230
	else:
		position = Vector2(1060, spawnHeight)
		speed = -230
		
	get_tree().create_timer(soundChance1)
		
func _process(delta: float) -> void:
	position.x += delta * speed
	soundChance1 = rng.randf_range(10, 20)
	soundIndex = rng.randf_range(0, 10.0)
	if position.x > 1060 or position.x < -100:
		queue_free()
		
func _on_timer_timeout() -> void:
	sounds[soundIndex].play() 
