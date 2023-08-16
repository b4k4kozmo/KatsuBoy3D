extends Node3D

@export var sensitivity = 5
var maxZoom = 33
var minZoom = 2

func _ready():
	#makes mouse cursor dissapeer
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	global_position = $"..".global_position

func _input(event):
	if event is InputEventMouse:
		# xRot is clamped so we dont put the camera under the floor 
		var xRot = clamp(rotation.x - event.relative.y / 1000 * sensitivity, -.5, 0.25)
		# yRot is not clamped so we can rotate the camera 360 degrees
		var yRot = rotation.y - event.relative.x / 1000 * sensitivity
		# we do not want to rotate along the Z axis so we set x to 0
		rotation = Vector3(xRot, yRot, 0)
		#this is only needed to display mouse motion in the debug menu
		#print_debug(event)
		
	if event is InputEventMouseButton:
		if event.button_index == 5:
			if $SpringArm3D.spring_length < maxZoom:
				$SpringArm3D.spring_length += 0.1
		if event.button_index == 4:
			if $SpringArm3D.spring_length > minZoom:
				$SpringArm3D.spring_length -= 0.1
			
	# test input for track pad usint - and =
	if Input.is_action_pressed("zoom_out"):
		if $SpringArm3D.spring_length < maxZoom:
			$SpringArm3D.spring_length += 0.5
	if Input.is_action_pressed("zoom_in"):
		if $SpringArm3D.spring_length > minZoom:
			$SpringArm3D.spring_length -= 0.5
