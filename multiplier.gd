extends Label

var canSee: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = "X" + str(Globals.multiplier)
	visible = Globals.canSee
