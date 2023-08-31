extends CharacterBody3D


@export var speed = 21
@export var health = 12
var run_speed = speed * 2
@export var jump_impulse = 33
@export var fall_acceleration = 50
@export var Projectile : PackedScene

var mobKnockBack = 0
var currentEnemy


var playerPaused: bool = false
var playerJumping: bool = false
var playerAttacking: bool = false
var canMove: bool = true

var target_velocity = Vector3.ZERO
var direction
var currentNPC


func _physics_process(delta):
	#$Projectile.hide()
	#$Projectile/Shuriken/CollisionShape3D.disabled = true

	if not playerPaused:
		# create a local variable to store input direction
		direction = Vector3.ZERO
		# get camera direction
		var hRot =$CameraController.transform.basis.get_euler().y
		#ttack animation
		
		if Input.is_action_just_pressed("Throw"):
			throw()
			
			
			
			
			
			
		if Input.is_action_just_pressed("attack"):
			playerAttacking = true
			$Pivot/KatsuBoi_anim/AnimationPlayer.play("combat")
			#wait for animation to end before setting playerAttacking to false
			await $Pivot/KatsuBoi_anim/AnimationPlayer.animation_finished
			playerAttacking = false
			
		# check for each move input and update the direction accordingly
		if canMove == true:
			if Input.is_action_pressed("move_right"):
				direction.x += 1
			if Input.is_action_pressed("move_left"):
				direction.x -= 1
			
			# x and z are the ground plane in 3D
			if Input.is_action_pressed("move_back"):
				direction.z += 1
			if Input.is_action_pressed("move_forward"):
				direction.z -= 1
			
		if direction != Vector3.ZERO:
			# this line of code gets diretion relative to the camera direction
			
			direction = direction.rotated(Vector3.UP, hRot).normalized()
			$Pivot.look_at(position + direction, Vector3.UP)
			if playerJumping == false and playerAttacking == false:
				#set plzyerAtacking to false when walking
				$Pivot/KatsuBoi_anim/AnimationPlayer.play("walk")
				playerAttacking = false
		if direction == Vector3.ZERO:
			if playerJumping == false and playerAttacking == false:
				#play idle animation when not jumping or attacking
				$Pivot/KatsuBoi_anim/AnimationPlayer.play("idle")
		
		
		# Ground velocity
		if Input.is_action_pressed("run"):
			#if run is held increase walk speed
			target_velocity.x = direction.x * run_speed
			target_velocity.z = direction.z * run_speed
		else:
			target_velocity.x = direction.x * speed
			target_velocity.z = direction.z * speed
		# Vertical velocity
		if not is_on_floor(): # if in the air fall to the floor (gravity)
			playerJumping = true
			playerAttacking = false
			$Pivot/KatsuBoi_anim/AnimationPlayer.play("jump")
			target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
		if currentNPC != null:
			#interact with npcs to trigger their dialogue or action functions
			if Input.is_action_just_pressed("interact"):
				currentNPC.dialogue()
		
		
		
		
		# moving the character
		velocity = target_velocity
		
		if currentEnemy != null:
			takeDamage(currentEnemy)
			takeKnockBack(currentEnemy, mobKnockBack)
		
		move_and_slide()
		
		# jumping
		if is_on_floor() and Input.is_action_just_pressed("jump"):
			
			target_velocity.y = jump_impulse
		if is_on_floor():
			playerJumping = false
		
		# logic for hiding/showing weapon based on attacking state
		if playerAttacking == false:
			$Pivot/KatsuBoi_anim/Armature/Skeleton3D/BoneAttachment3D.hide()
			$Pivot/KatsuBoi_anim/Armature/Skeleton3D/BoneAttachment3D/Kamibokken3D/CollisionShape3D.disabled = true
			canMove = true
		if playerAttacking:
			$Pivot/KatsuBoi_anim/Armature/Skeleton3D/BoneAttachment3D.show()
			$Pivot/KatsuBoi_anim/Armature/Skeleton3D/BoneAttachment3D/Kamibokken3D/CollisionShape3D.disabled = false
			canMove = false
			
		if health <= 0:
			die()


func die():
	queue_free()

func _on_canvas_layer_game_paused():
	playerPaused = true


func _on_canvas_layer_game_not_paused():
	playerPaused = false



func _on_npc_detector_body_entered(body):
	#detects if you are in range with an npc
	#and sets currentNPC to NPC
	currentNPC = body
	print_debug(currentNPC)


func _on_npc_detector_body_exited(_body):
	#sets currentNPC to null
	currentNPC = null


func _on_mob_detector_body_entered(body):
	print_debug(body)
	print_debug(health)
	mobKnockBack = body.knockBack
	currentEnemy = body
	


func _on_mob_detector_body_exited(_body):
	currentEnemy = null
	mobKnockBack = 0
	
func takeKnockBack(enemy, knockBack):
	velocity.x = enemy.direction.x * knockBack
	velocity.z = enemy.direction.z * knockBack
	
	
func takeDamage(enemy):
	health -= enemy.atk
	print_debug(health)

	
func throw():
	var p = Projectile.instantiate() as Area3D
	
	p.transform = $Pivot/Projectile.global_transform
	owner.add_child(p)
