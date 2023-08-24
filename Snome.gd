extends CharacterBody3D

var health = 10
signal hit()
var attackingBody = null
var tempDMG = 0

func _physics_process(_delta):
	
	if attackingBody != null:
		if attackingBody.is_in_group("weapon"):
			#temp damage takes damagenfrom current weapon and stores it
			#before the attacking body nuliifies
			tempDMG = attackingBody.dmg
			#wait for weapon to leave the 3D area before nullifying and taking damage
			await _on_area_3d_area_exited(null)
			health -= tempDMG
			print_debug(health)
	
	if health <= 0:
		die()
		

func die():
	queue_free()




func _on_area_3d_area_entered(area):
	attackingBody = area
	print_debug(area)


func _on_area_3d_area_exited(_area):
	attackingBody = null

