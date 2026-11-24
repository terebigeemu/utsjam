extends Node2D

@onready var audio = $AudioStreamPlayer
@onready var flickerAudio = $FlickerAudio
@onready var startButton = $StartButton 
@onready var darkness = $AnimatedDarkness

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _on_start_button_pressed():
	audio.play() 
	await audio.finished
	get_tree().change_scene_to_file.call_deferred("res://main.tscn") ###!!!! replace w/ the actual game scene HERE


func _on_timer_timeout() -> void:
	darkness.play("default")
	darkness.modulate.a = 0.8
	
	flickerAudio.play() 
	await flickerAudio.finished
	
	darkness.modulate.a = 0.0
