extends Node2D

@onready var audio = $AudioStreamPlayer
@onready var flickerAudio = $FlickerAudio
@onready var startButton = $StartButton 
@onready var darkness = $AnimatedDarkness
@onready var color_rect: ColorRect = $ColorRect

var leaderboard_scene = preload("res://leaderboard.tscn")

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	color_rect.modulate.a = 0.0
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _on_start_button_pressed():
	audio.play() 
	#await audio.finished
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween := create_tween()
	tween.tween_property(color_rect, "modulate:a", 1.0, 1)
	await tween.finished
	get_tree().change_scene_to_file.call_deferred("res://main.tscn") ###!!!! replace w/ the actual game scene HERE


func _on_timer_timeout() -> void:
	darkness.play("default")
	darkness.modulate.a = 0.8
	
	flickerAudio.play() 
	await flickerAudio.finished
	
	darkness.modulate.a = 0.0


func _on_scoreboard_scene_open_pressed() -> void:
	var instance = leaderboard_scene.instantiate()
	add_child(instance)
	instance.global_position = Vector2(0, 75)
