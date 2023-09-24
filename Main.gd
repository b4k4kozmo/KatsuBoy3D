extends Node

enum {PLAY_STATE, DIALOGUE_STATE, PAUSE_STATE}
var gameState = PLAY_STATE

func _on_inventory_gui_closed():
	get_tree().paused = false


func _on_inventory_gui_opened():
	get_tree().paused = true


func _on_pause_gui_closed():
	get_tree().paused = false


func _on_pause_gui_opened():
	get_tree().paused = true


func _on_dialogue_gui_closed():
	get_tree().paused = false
	gameState = PLAY_STATE

func _on_dialogue_gui_opened():
	get_tree().paused = true


func _on_level_0_dialogue_state():
	gameState = DIALOGUE_STATE
