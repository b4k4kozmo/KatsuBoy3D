extends CharacterBody3D

@export var speed = 21
var run_speed = speed * 2
@export var jump_impulse = 33
@export var fall_acceleration = 50

var target_velocity = Vector3.ZERO


func _physics_process(delta):
	# create a locakl variable to store input direction
	var direction = Vector3.ZERO
	
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
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
		
	
	
	# Ground velocity
	if Input.is_action_pressed("run"):
		target_velocity.x = direction.x * run_speed
		target_velocity.z = direction.z * run_speed
	else:
		target_velocity.x = direction.x * speed
		target_velocity.z = direction.z * speed
	# Vertical velocity
	if not is_on_floor(): # if in the air fall to the floor (gravity)
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	# moving the character
	velocity = target_velocity
	move_and_slide()
	
	# jumping
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
