extends Node2D

# Preload your saved bird scene
var bird_node = preload("res://test/test_bird.tscn")

# Timer Function from Thomas

func _ready():
	_random_time()

func _random_time():
	var spawnTime = randf_range(0.3, 2.0)
	$Timer.start(spawnTime)
	
func _on_spawn_timer_timeout() -> void:
	for i in range(100):
		var pos := Vector2.from_angle(2*PI*randf())
		pos *= 100 * randf()
		pos += Vector2(-100,randf_range(120,380))
		pigeon_spawn(pos)
var h_pos : int
func pigeon_spawn(pos):
	var instance = bird_node.instantiate()
#	# randomly give them the diff stuff
	
	if randf() < 0.5:
		#instance.get_node("AnimatedSprite2D").flip_h = true
		instance.scale.x = -1
		# very naughty practice
		instance.position = pos - Vector2(100,0)
	else:
		instance.position = pos + Vector2(960+200,0)
	add_child(instance)

#func _process(delta : float)

# if told to die or makes contact with the ball, just change 
# it to a dropping bird animation
# priority is interaction with adrian's ball
