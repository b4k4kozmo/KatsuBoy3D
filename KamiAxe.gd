extends "res://Collectable.gd"

@onready var animation = $MeshInstance3D/woodsmansaxe/AnimationPlayer

func collect(inventory: Inventory):
	animation.play("spin")
	await animation.animation_finished
	super(inventory)
