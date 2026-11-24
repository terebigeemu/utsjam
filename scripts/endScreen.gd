extends Node2D

@onready var score = $Score
@onready var playAgain = $PlayAgainBtn
@onready var buttonAudio = $ButtonClick
@onready var backgroundAudio = $BackgroundMusic


#Hypothetical score storage thing
#@onready var scores = $Scores

func _ready() -> void:
	#To implement top scores
	#scoreBoard.text = scores.topFiveScores()
	score.text = "Final Score: " + str(Globals.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_again_btn_pressed() -> void:
	buttonAudio.play() 
	await buttonAudio.finished
	get_tree().change_scene_to_file("res://main.tscn") ###!!!! replace w/ the actual game scene HERE
