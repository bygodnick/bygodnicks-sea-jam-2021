extends Node2D

const cig = preload("res://assets/trash/Cig.png")
const garbage = preload("res://assets/trash/Garbage.png")
const sodaCan = preload("res://assets/trash/SodaCan.png")

var points = 0

func _ready():
	randomizeSprite()
	$Anims.play("idle")
	
func randomizeSprite():
	randomize()
	var trashImages = [cig, garbage, sodaCan]
	var trash = trashImages[randi() % trashImages.size()]
	$Trash/Sprite.texture = trash
	
func cleanedUp():
	$Anims.play("cleaned")
	yield(get_tree().create_timer(1), "timeout")
	randomizePoints()
	Globals.score += points
	Globals.materialsNum += 1
	
	queue_free()
	Globals.trashMade = false
	
func getHit(damage: float):
	Globals.score += points
	queue_free()
	Globals.trashMade = false
	
func randomizePoints():
	randomize()
	var x = rand_range(30000,50000)
	points = int(x)

func _on_Trash_body_entered(body):
	cleanedUp()
	if body.has_method("beam"):
		body.beam()

func _on_Trash_body_exited(body):
	if body.has_method("reverseBeam"):
		body.reverseBeam()
