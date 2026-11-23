extends AnimatedSprite2D

# written by adrian

@export var hand_scroll_offset: float = 0.1

@onready var rock_sprite: AnimatedSprite2D = get_node("Rock")
@onready var person: Parallax2D = get_node("../../PersonParallax")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.throw_in_progress.connect(_on_throw)
	pass # Replace with function body.

func _on_throw(status: bool) -> void:
	print("throw signal received")
	self.play()
	rock_sprite.play()

func _on_animation_finished() -> void:
	self.stop()
	rock_sprite.stop()
	
func _input(event):
	if event is InputEventMouseMotion:
		var mouse_pos = get_viewport().get_mouse_position()
		person.scroll_offset = hand_scroll_offset * mouse_pos
