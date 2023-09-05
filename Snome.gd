extends CharacterBody3D

var health = 10
signal hit()
var attackingBody = null
var tempDMG = 0
var tempKnockBack = 0
var direction
var fall_acceleration = 50
var atk = 1
var knockBack = 300
var onSight = false

@onready var mesh = $Pivot
@export var speed = 5

func _physics_process(delta):
	direction = Vector2.ZERO
	
	if not is_on_floor():
		velocity.y -= fall_acceleration * delta
	
	var player = get_node("../Player")
	if player.playerPaused == false:
		if player:
			direction = (player.position - position).normalized()
			if direction:
				mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(direction.x, direction.z) - rotation.y, delta * 10)
				velocity.x = direction.x * speed
				velocity.z = direction.z * speed
		if attackingBody != null:
			if attackingBody.is_in_group("weapon"):
				#temp damage takes damagenfrom current weapon and stores it
				#before the attacking body nuliifies
				tempDMG = attackingBody.dmg
				tempKnockBack = attackingBody.knockBack
				velocity.x = direction.x * -tempKnockBack
				velocity.z = direction.z * -tempKnockBack
				
				#wait for weapon to leave the 3D area before nullifying and taking damage
				await _on_area_3d_area_exited(null)
				health -= tempDMG
				
				print_debug(health)
			
			elif attackingBody.is_in_group("projectile"):
				tempKnockBack = attackingBody.knockBack
				velocity.x = direction.x * -tempKnockBack
				velocity.z = direction.z * -tempKnockBack
				health -= attackingBody.dmg
				onSight = true
				await attackingBody._on_body_entered(self)
				move_and_slide()
				
				
		if onSight == true:
			move_and_slide()
	
		if health <= 0:
			die()
		

func die():
	queue_free()




func _on_area_3d_area_entered(area):
	attackingBody = area
	print_debug(area)


func _on_area_3d_area_exited(_area):
	attackingBody = null



func _on_player_detector_body_entered(body):
	if body.is_in_group("player"):
		onSight = true


func _on_player_detector_body_exited(_body):
		onSight = false
