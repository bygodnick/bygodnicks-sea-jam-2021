extends KinematicBody2D

func rotateToTarget(target, delta):
	var direction = (target.global_position - global_position)
	var angle = $Sprite.transform.x.angle_to(direction)
	$Sprite.rotate(sign(angle) * min(delta, abs(angle)))
	
func follow(target):
	global_position = target.global_position - Vector2(20,20)
