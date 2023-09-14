extends Node


func _on_inventory_gui_closed():
	get_tree().paused = false


func _on_inventory_gui_opened():
	get_tree().paused = true


func _on_pause_gui_closed():
	get_tree().paused = false


func _on_pause_gui_opened():
	get_tree().paused = true
