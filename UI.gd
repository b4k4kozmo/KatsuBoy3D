extends CanvasLayer

@onready var inventory = $InventoryGui
@onready var pause = $PauseGui
@onready var dialogue = $DialogueGui
@onready var main = $".."

func _ready():
	inventory.close()
	pause.close()
	dialogue.close()

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
	if main.gameState == 1:
		dialogue.open()
		print_debug(main.gameState)
		if event.is_action_pressed("interact"):
			dialogue.close()
			main.gameState = 0
			await get_tree().create_timer(0.1).timeout
			main.get_child(0,false).gameState = 0
			
			
