extends ColorRect

var play = preload("res://scenes/World.tscn")

func _ready():
	$Anims.play("hovercraft")

func _on_Play_pressed():
	get_tree().change_scene_to(play)
