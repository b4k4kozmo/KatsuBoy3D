extends "res://Collectable.gd"

@onready var animation = $MeshInstance3D/woodsmansaxe/AnimationPlayer

func collect():
	animation.play("spin")
	await animation.animation_finished
	super.collect()
