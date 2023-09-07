extends StaticBody3D

var health = 3
var invincible: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Stump/CollisionShape3D.disabled = true
	$CollisionShape3D.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if health < 1:
		$CollisionShape3D.disabled = true
		$Stump/CollisionShape3D.disabled = false
		$Tree.hide()


func _on_axe_collider_area_entered(area):
	if area.is_in_group("weapon") and not invincible:
		health -= 1
		invincible = true
		$ChopCooldown.start()


func _on_chop_cooldown_timeout():
	invincible = false
