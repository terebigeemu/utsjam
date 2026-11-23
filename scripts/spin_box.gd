extends SpinBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#@onready var whole_number := int(value)


func _on_value_changed(value: float) -> void:
	var whole_number = int(value)
	print("Entered number: ", whole_number)
	
	get_parent().numberOfBirdsHit = whole_number # Replace with function body.
