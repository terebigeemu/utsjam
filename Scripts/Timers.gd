extends Node2D

const bird = preload("res://test/test_bird.tscn")

func _ready():
	_random_time()

func _random_time():
	var spawnTime = randf_range(0.3, 2.0)
	$SpawnTimer.start(spawnTime)
	

func _on_spawn_timer_timeout() -> void:
	for i in range(20):
		var pos := Vector2.from_angle(2*PI*randf())
		pos *= 100 * randf()
		pos += Vector2(-100,randf_range(100,200))
		pigeon_spawn(pos)
	
func pigeon_spawn(pos):
	var instance = bird.instantiate()
#	# randomly give them the diff stuff
	
	if randf() < 0.5:
		instance.scale.x = -1
		# very naughty practice
		instance.position = pos - Vector2(100,0)
	else:
		instance.position = pos + Vector2(960+200,0)
	add_child(instance)
