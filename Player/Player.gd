extends CharacterBody3D

@export var speed = 21
var run_speed = speed * 2
@export var jump_impulse = 33
@export var fall_acceleration = 50
var playerPaused: bool = false
var playerJumping: bool = false
var playerAttacking: bool = false

var target_velocity = Vector3.ZERO
var currentNPC

func _physics_process(delta):
	if not playerPaused:
		# create a locakl variable to store input direction
		var direction = Vector3.ZERO
		# get camera direction
		var hRot =$CameraController.transform.basis.get_euler().y
		#ttack animation
		if Input.is_action_just_pressed("attack"):
			playerAttacking = true
			$Pivot/KatsuBoi_anim/AnimationPlayer.play("combat")
			await $Pivot/KatsuBoi_anim/AnimationPlayer.animation_finished
			playerAttacking = false
			
		# check for each move input and update the direction accordingly
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
			if playerJumping == false:
				$Pivot/KatsuBoi_anim/AnimationPlayer.play("walk")
				playerAttacking = false
		if direction == Vector3.ZERO:
			if playerJumping == false and playerAttacking == false:
				$Pivot/KatsuBoi_anim/AnimationPlayer.play("idle")
		
		
		# Ground velocity
		if Input.is_action_pressed("run"):
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
			if Input.is_action_just_pressed("interact"):
				currentNPC.dialogue()
		
		# moving the character
		velocity = target_velocity
		move_and_slide()
		
		# jumping
		if is_on_floor() and Input.is_action_just_pressed("jump"):
			
			target_velocity.y = jump_impulse
		if is_on_floor():
			playerJumping = false
		if playerAttacking == false:
			$Pivot/KatsuBoi_anim/Armature/Skeleton3D/BoneAttachment3D.hide()
		if playerAttacking:
			$Pivot/KatsuBoi_anim/Armature/Skeleton3D/BoneAttachment3D.show()
			


func _on_canvas_layer_game_paused():
	playerPaused = true


func _on_canvas_layer_game_not_paused():
	playerPaused = false



func _on_npc_detector_body_entered(body):
	currentNPC = body


func _on_npc_detector_body_exited(_body):
	currentNPC = null
