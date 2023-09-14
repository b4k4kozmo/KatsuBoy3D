extends CanvasLayer

@onready var inventory = $InventoryGui
@onready var pause = $PauseGui

func _ready():
	inventory.close()
	pause.close()

func _input(event):
	if event.is_action_pressed("toggle_inventory") and not pause.isOpen:
		if inventory.isOpen:
			inventory.close()
		else:
			inventory.open()
			
	if event.is_action_pressed("pause") and not inventory.isOpen:
		if pause.isOpen:
			pause.close()
		else:
			pause.open()
