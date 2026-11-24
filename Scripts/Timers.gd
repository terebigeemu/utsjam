extends Node2D

const bird = preload("res://animatedBird.tscn")

func _ready():
	_random_time()

func _random_time():
	var spawnTime = randf_range(0.3, 2.0)
	$SpawnTimer.start(spawnTime)

func _on_spawn_timer_timeout() -> void:
	var new_bird = bird.instantiate()
	add_child(new_bird)
	_random_time()
