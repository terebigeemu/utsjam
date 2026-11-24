extends Node2D
# Written by Leo
@onready var sprite = get_node("AnimatableBody2D/AnimatedSprite2D")
@onready var collision_shape = get_node("AnimatableBody2D/Area2D/Shape Form")
@onready var physics = get_node("AnimatableBody2D")
@onready var hitbox = get_node("AnimatableBody2D/CollisionPhysics")
var living := true
var playing_forward := true
var sprite_speed : float
var fall : Vector2
#var AngofAtk : float
func _ready() -> void:
	# Start on a random frame (0, 1, 2, or 3)
	
	sprite.frame = randi() % sprite.sprite_frames.get_frame_count("flap")
	# Vary the bird size
	var resizing : float = 0.16 + 0.1 * randf()
	resizing *= 1.3
	sprite.scale = Vector2(resizing,resizing)
	collision_shape.scale = Vector2(resizing,resizing)
	hitbox.scale = Vector2(resizing,resizing)
	# original size is 400px
	# Initial Angle of Attack
	sprite.rotation = (-0.01 + 0.15 * randf())
	# Slightly vary the flapping and flight speed
	sprite_speed = 0.9 * (1 + randf())
	sprite.play("flap", 1.0 * sprite_speed, false)
	

func _on_animation_finished() -> void:
	playing_forward = !playing_forward
	# raise the angle of attack a bit every flap
	sprite.rotate(0.025 + 0.1 * randf())
	if playing_forward:
		sprite.play("flap", 4.6 * sprite_speed, false)
	else:
		# Add a rotation up if doing that for the motion
		# Rewind twice as fast
		sprite.play("flap", -1.0 * sprite_speed, true)

func _on_bird_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("Triggered by: ", body.name)
	if body == physics:
		return
	living = false
	fall = Vector2.from_angle(sprite.rotation - 0.226)
	fall *+ - sprite_speed * 100
	sprite.animation = "dead" 
	sprite.stop()   
	hitbox.set_deferred("disabled", true)

#	Notes on flight
# Flight is determined by its pitch attitude 
# (angle between AOA and trajectory)
# For pigeons, this is about 13 degrees (0.226 rad)
var a : int = 0
func _process(delta: float) -> void:
	if living:
		# drop_rate
		var drop : float = -((sprite.rotation + PI/2 )/PI)**.7 * 0.015
		sprite.rotate(drop)
		if sprite.rotation < - PI/2 or sprite.rotation > PI/2:
			sprite.rotation = (-0.01 + 0.15 * randf())
		var translation := Vector2.from_angle(sprite.rotation - 0.226).normalized()
		physics.position += translation * - sprite_speed * 100 * delta
		
		#collision_shape.position += translation * - sprite_speed * 100 * delta
		# Force the bird to fly up if it is crashing into the ground
		if sprite.global_position.y > 350:
			sprite.rotate(-drop * 1.5)
		if sprite.global_position.y < 150:
			sprite.rotate(drop*1.5)
		if sprite.global_position.x > 1360 or position.x < -200:
			queue_free()

	else:   
		a += 1
		fall += Vector2(0,3)
		physics.position += fall
		if a > 10:
			queue_free()
