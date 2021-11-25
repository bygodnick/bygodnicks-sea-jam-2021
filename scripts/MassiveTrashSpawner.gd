extends Node2D

const tire = preload("res://assets/trash/tire.png")
const nuke = preload("res://assets/trash/NuclearWaste.png")

var trash = ""
var points = 0

func _ready():
	randomizeSprite()
	$Anims.play("idle")
	
func randomizeSprite():
	randomize()
	var trashImages = [tire, nuke]
	trash = trashImages[randi() % trashImages.size()]
	$Trash/Sprite.texture = trash
	
func cleanedUp():
	$Anims.play("cleaned")
	yield(get_tree().create_timer(1), "timeout")
	randomizePoints()
	Globals.score += points
	Globals.materialsNum += 1
	
	queue_free()
	Globals.trashMade = false
	
func randomizePoints():
	randomize()
	var x = rand_range(1500000,2000000)
	points = int(x)
	
	if trash == nuke:
			Globals.energize += 1
	else:
			pass
	
	queue_free()
	Globals.trashMade = false

func _on_Trash_body_entered(body):
	cleanedUp()
	if body.has_method("beam"):
		body.beam()

func _on_Trash_body_exited(body):
	if body.has_method("reverseBeam"):
		body.reverseBeam()
