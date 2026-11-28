extends Node2D

@onready var score = $Score
@onready var multiplier_record = $MultiplierRecord
@onready var playAgain = $PlayAgainBtn
@onready var buttonAudio = $ButtonClick
@onready var backgroundAudio = $BackgroundMusic
@onready var username = $UsernameSubmit
@onready var scoreboard_submit = $ScoreboardSubmit

@export var leaderboard_name: String = "two-birds-one-stone"

var leaderboard_scene = preload("res://leaderboard.tscn")

#Hypothetical score storage thing
#@onready var scores = $Scores

func _ready() -> void:
	#To implement top scores
	#scoreBoard.text = scores.topFiveScores()
	score.text = str(Globals.score)
	multiplier_record.text = str(Globals.multiplier_record) + "X"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_again_btn_pressed() -> void:
	Globals.score = 0
	Globals.multiplier = 0
	Globals.multiplier_record = 0
	Globals.has_played_tutorial = true
	buttonAudio.play() 
	await buttonAudio.finished
	get_tree().change_scene_to_file("res://main.tscn") ###!!!! replace w/ the actual game scene HERE


func _on_scoreboard_submit_pressed() -> void:
	var user = username.text
	if user == "":
		user = "pigeonhater" + str(randi_range(10000,99999))
	await Talo.players.identify("username", user)
	var res := await Talo.leaderboards.add_entry(leaderboard_name, Globals.score, { multiplier = Globals.multiplier_record})
	scoreboard_submit.text = "Sent!"
	scoreboard_submit.disabled = true
	username.editable = false
	pass # Replace with function body.


func _on_scoreboard_scene_open_pressed() -> void:
	var instance = leaderboard_scene.instantiate()
	add_child(instance)
