extends Node2D

# Preload your saved bird scene
var bird_node = preload("res://test/test_bird.tscn")

# Timer Function from Thomas

func _ready():
	#pigeon_spawn()
	$Timer.start(1)

func _random_time():
	var spawnTime = randf_range(1.0, 3.0)
	$Timer.start(spawnTime)
	
func _on_spawn_timer_timeout() -> void:
	_random_time()
	pigeon_spawn()
# Modified Loop from Leo
func pigeon_spawn():
	$PigeonSpawnAudio.play()
	var dir := bool(randi() % 2)
	for i in range(randfn(5,7)):
		var instance = bird_node.instantiate()
		var pos := Vector2.from_angle(2*PI*randf())
		pos *= 100 * randf()
		pos += Vector2(-100,randf_range(100,200))
		if not dir:
			instance.scale.x = -1
			# very naughty practice
			instance.position = pos - Vector2(100,0)
		else:
			instance.position = pos + Vector2(960+200,0)
		add_child(instance)


# if told to die or makes contact with the ball, just change 
# it to a dropping bird animation
# priority is interaction with adrian's ball
