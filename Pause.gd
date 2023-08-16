extends CanvasLayer
var isPaused: bool
signal gamePaused
signal gameNotPaused
	

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if not isPaused:
			show()
			isPaused = true
			gamePaused.emit()
		else:
			hide()
			isPaused = false
			gameNotPaused.emit()
