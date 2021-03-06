extends KinematicBody2D


var reversecon = 0
var reverse = false
var movement = Vector2()
var speed = 100

func _physics_process(delta):
	
	if reverse == false:
		movement.y += 1
	else:
		movement.y -= 1

	movement = movement.normalized()
	move_and_slide(movement*speed)


func _on_DetectionAndHitbox_body_entered(body):
	if "Player" in body.name:
		pass
	if ("Map" in body.name) or ("Edge" in body.name):
		reversecon += 1
		if reversecon %2 == 1:
			reverse = true 
		else:
			reverse = false
