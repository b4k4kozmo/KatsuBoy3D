extends Node


func _on_inventory_gui_closed():
	get_tree().paused = false


func _on_inventory_gui_opened():
	get_tree().paused = true



func _on_pause_game_not_paused():
	get_tree().paused = false


func _on_pause_game_paused():
	get_tree().paused = true
