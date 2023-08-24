extends CharacterBody3D

var health = 10
signal hit()
var attackingBody = null

func _physics_process(_delta):
	
	if attackingBody != null:
		if attackingBody.is_in_group("weapon"):
			health -= 1
			print_debug(health)
	
	if health <= 0:
		die()
		

func die():
	queue_free()


func _on_area_3d_body_entered(body):
	attackingBody = body
	print_debug(body)
	


func _on_area_3d_body_exited(_body):
	attackingBody = null


func _on_area_3d_area_entered(area):
	attackingBody = area
	print_debug(area)
