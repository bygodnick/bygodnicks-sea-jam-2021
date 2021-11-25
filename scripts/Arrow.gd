extends Node2D

func _physics_process(delta):
	var v = Globals.trashInstance - global_position
	var angle = v.angle()
	var r = global_rotation
	global_rotation = lerp(r, angle, .02)
