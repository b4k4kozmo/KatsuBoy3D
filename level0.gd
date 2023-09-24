extends Node3D

enum {PLAY_STATE, DIALOGUE_STATE, PAUSE_STATE}

var gameState = PLAY_STATE

signal dialogueState




func _on_frogness_dialogue_signal():
	if gameState != DIALOGUE_STATE:
		gameState = DIALOGUE_STATE
		print_debug(DIALOGUE_STATE)
		dialogueState.emit()
