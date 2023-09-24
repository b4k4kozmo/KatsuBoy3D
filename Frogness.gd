extends CharacterBody3D
signal dialogueSignal
func dialogue():
	$Frogness_anim/AnimationPlayer.play("TrashcanAction")
	print_debug("dialogue activated")
	dialogueSignal.emit()
	
