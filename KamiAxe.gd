extends "res://Collectable.gd"

@onready var animation = $MeshInstance3D/woodsmansaxe/AnimationPlayer
@onready var collision = $CollisionShape3D

func collect(inventory: Inventory):
	collision.queue_free()
	animation.play("spin")
	await animation.animation_finished
	super(inventory)
