extends Node2D

const boot = preload("res://assets/trash/Boot.png")
const bag = preload("res://assets/trash/groceryBag.png")
const cup = preload("res://assets/trash/CoffeeCup.png")
const plate = preload("res://assets/trash/Plate.png")

var trash = ""
var points = 0

func _ready():
	randomizeSprite()
	$Anims.play("idle")
	
func randomizeSprite():
	randomize()
	var trashImages = [boot, bag, cup, plate]
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
	var x = rand_range(300000,500000)
	points = int(x)

func _on_Trash_body_entered(body):
	cleanedUp()
	if body.has_method("beam"):
		body.beam()

func _on_Trash_body_exited(body):
	if body.has_method("reverseBeam"):
		body.reverseBeam()
