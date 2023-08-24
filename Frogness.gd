extends CharacterBody3D

func dialogue():
	$Frogness_anim/AnimationPlayer.play("TrashcanAction")
	print_debug("dialogue activated")
