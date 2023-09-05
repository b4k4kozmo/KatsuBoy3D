extends Area3D
@export var dmg = 5
@export var knockBack = 150
@export var speed = 30
var direction = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	top_level = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	global_position -= transform.basis.z * speed * delta
	


func _on_body_entered(body):
	if body.is_in_group("mob") and body.is_in_group("defense"):
		body.onSight = true
		print_debug(body.health)
		print_debug(body)
		
	queue_free()



func _on_projectile_timer_timeout():
	queue_free()
