extends AnimatedSprite2D

# written by adrian

@export var hand_scroll_factor: float = 0.05
@export var scroll_offset_x: float = 6000.0
@export var scroll_offset_y: float = -6

@onready var rock_sprite: AnimatedSprite2D = get_node("Rock")
@onready var person: Parallax2D = get_node("../../PersonParallax")

var last_scroll_offset: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.throw_in_progress.connect(_on_throw)

func _on_throw(status: bool) -> void:
	print("throw signal received")
	Globals.in_throw = true
	self.play()
	rock_sprite.play()
	var mouse_pos = get_viewport().get_mouse_position()
	last_scroll_offset = hand_scroll_factor * (mouse_pos + Vector2(scroll_offset_x,scroll_offset_y))

func _on_animation_finished() -> void:
	self.stop()
	rock_sprite.stop()
	Globals.throw_finished.emit()
	Globals.in_throw = false
	print("throw finished")
	
func _input(event):
	if (event is InputEventMouseMotion):
		if Globals.in_throw == false:
			var mouse_pos = get_viewport().get_mouse_position()
			person.scroll_offset = hand_scroll_factor * (mouse_pos + Vector2(scroll_offset_x,scroll_offset_y))
