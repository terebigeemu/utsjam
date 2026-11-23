extends Node2D
# Written by Leo
@onready var sprite = $AnimatedSprite2D
var playing_forward := true
var sprite_speed : float
#var AngofAtk : float
func _ready() -> void:
	# Start on a random frame (0, 1, 2, or 3)
	sprite.frame = randi() % sprite.sprite_frames.get_frame_count("flap")
	# Vary the initial angle of attack
	var scale : float = 0.18 + 0.2 * randf()
	sprite.scale = Vector2(scale,scale)
	# original size is 400px
	sprite.rotate(-0.01 + 0.15 * randf())
	# Slightly vary the flapping and flight speed
	sprite_speed = 0.5 + randf()
	sprite.play("flap", 1.0 * sprite_speed, false)

func _on_animation_finished() -> void:
	playing_forward = !playing_forward
	# raise the angle of attack a bit every flap
	sprite.rotate(0.02 + 0.15 * randf())
	if playing_forward:
		sprite.play("flap", 4.6 * sprite_speed, false)
	else:
		# Add a rotation up if doing that for the motion
		# Rewind twice as fast
		sprite.play("flap", -1.0 * sprite_speed, true)

#	Notes on flight
# Flight is determined by its pitch attitude 
# (angle between AOA and trajectory)
# For pigeons, this is about 13 degrees (0.226 rad)

func _process(delta: float) -> void:
	# drop_rate
	var drop : float = -( sprite.rotation + PI/2 ) / PI * 0.01
	sprite.rotate(drop)	
	var translation := Vector2.from_angle(sprite.rotation).normalized()
	sprite.global_position += translation * - sprite_speed * 100 * delta
