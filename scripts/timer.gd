extends Timer

var totalTime: float = 30
var timeElapsed: float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(delta)
	timeElapsed = timeElapsed + delta


func _on_timeout() -> void:
	#if 
	#totalTime = 
	print ("DONE")
