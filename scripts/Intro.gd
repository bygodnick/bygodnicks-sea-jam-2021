extends ColorRect

var mainMenu = preload("res://scenes/mainMenu.tscn")

func _ready():
	$Music.play()
	yield(get_tree().create_timer(1.5), "timeout")
	$Anims.play("load")
	yield(get_tree().create_timer(2), "timeout")
	$Anims.play_backwards("load")
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene_to(mainMenu)
