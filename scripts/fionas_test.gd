extends Node2D

@export var radius: float = 50.0
@export var fill_color: Color = Color(0.3882353, 0.75, 0.2784314, 1)
@export var bg_color: Color = Color(1, 0.3882353, 0.2784314, 1)
@export var duration: float = 67.0
@export	var numberOfBirdsHit: int = 0


@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time = duration # set uo the initial timer time
	timer.one_shot = true # once the timer is up it won't repeat
	timer.start() # start the timer

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	var center := Vector2(1800, 150) / 2.0 # the position of the center of the timer
	draw_circle(center, radius, bg_color) # optional background circle
	
	if timer.is_stopped() or timer.wait_time <= 0.0:
		print ("donzoes") # put code to exit this scene and go to end screen
		get_tree().change_scene_to_file("res://end.tscn")
		return
		
	for birdHits in numberOfBirdsHit:
		timer.start(timer.time_left + 1) #add one second for each backlog of bird hit
	numberOfBirdsHit = 0 # reset
		
	######!!!!!!!! if you want to change the max amount of time left do it here
	if timer.time_left > duration: #if someone hits a bird at 29.5 seconds we don't want to exceed the 30 sec limit
		timer.start(duration)
	
	var ratio: float = timer.time_left / duration # ratio of timeleft to total time
	var start_angle: float = -PI / 2.0 # top (12 o'clock)
	var end_angle: float = start_angle + (TAU * ratio)
	
	# draw filled pie slice using polygon points
	var points := PackedVector2Array([center])
	var steps: int = max(3, int(64 * ratio))
	for i in range(steps + 1):
		var angle := lerpf(start_angle, end_angle, float(i) / steps)
		points.append(center + Vector2(cos(angle), sin(angle)) * radius)
	
	draw_colored_polygon(points, fill_color)
