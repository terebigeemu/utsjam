extends Node2D
# Written by Leo
@onready var sprite = $AnimatedSprite2D

func _ready():
	# Start on a random frame (0, 1, 2, or 3)
	sprite.frame = randi() % sprite.sprite_frames.get_frame_count("flap")
	# Slightly vary the flapping speed
	sprite.speed_scale = randf_range(0.6, 1.4)
	sprite.play("flap")
#	Add a force up if doing that for the motion
#	animation_loop()
#	
	
