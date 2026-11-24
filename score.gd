extends Label

func _process(delta):
	self.text = "Score: " + str(Globals.score)

# Add the following code when the ball collides with a bird
# 
