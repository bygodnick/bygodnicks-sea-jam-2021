extends ColorRect

var paused = false

func _input(event):
	if event.is_action_pressed("Pause"):
		if paused == false:
			paused = true
			get_tree().paused = !get_tree().paused
		else:
			get_tree().set_deferred("paused", false)
