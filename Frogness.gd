extends CharacterBody3D
signal dialogueSignal

var dialogueOption = Dialogues.new()

func dialogue():
	$Frogness_anim/AnimationPlayer.play("TrashcanAction")
	print_debug("dialogue activated")
	dialogueOption.speech = str("HI I'M FROGNESS")
	dialogueSignal.emit()
	
