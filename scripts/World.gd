extends Node2D

var spawnerLocation = Vector2()
var playerSpawn = Vector2()
var guideSpawn = Vector2()
var scene
var player
var guide

var spawners = [preload("res://scenes/SmallTrashSpawner.tscn"), 
preload("res://scenes/LargeTrashSpawner.tscn"), 
preload("res://scenes/MassiveTrashSpawner.tscn"),
preload("res://scenes/SmallTrashSpawner.tscn"),
preload("res://scenes/SmallTrashSpawner.tscn"),
preload("res://scenes/LargeTrashSpawner.tscn")]

var playerScene = preload("res://scenes/Player.tscn")
var guideScene = preload("res://scenes/Guide.tscn")
var junkShipScene = preload("res://scenes/JunkShip.tscn")

const playableArea = Vector2(300,180)
const minPlayableArea = Vector2(-300,-180)

func _ready():
	playerStartPosition()
	guideStartPosition()
	
func _process(delta):
	spawnerRandomization()
	guide.rotateToTarget(scene, delta)
	guide.follow(player)
	Globals.playerInstance = player.position

func spawnerRandomization():
	if Globals.trashMade == false:
		randomize()
		var x = randi() % spawners.size()
		spawnerLocation.x = rand_range(minPlayableArea.x, playableArea.x)
		spawnerLocation.y = rand_range(minPlayableArea.y, playableArea.y)
		
		scene = spawners[x].instance()
		scene.position = spawnerLocation
		add_child(scene)
		scene.z_index = 0
		Globals.trashMade = true
		
		print("Trash: " + str(scene.position))
	
func playerStartPosition():
	randomize()
	playerSpawn.x = rand_range(1,10)
	playerSpawn.y = rand_range(1,10)
	
	player = playerScene.instance()
	
	add_child(player)
	player.position = playerSpawn
	player.z_index = 1
	
	print("Player: " + str(playerSpawn))
	
func guideStartPosition():
	randomize()
	guideSpawn.x = rand_range(11,20)
	guideSpawn.y = rand_range(11,20)
	
	guide = guideScene.instance()
	
	add_child(guide)
	guide.position = guideSpawn
	guide.z_index = 1
	
func shipSpawner():
	randomize()
	var shipSpawn = Vector2.ZERO
	shipSpawn.x = rand_range(250,500)
	shipSpawn.y = rand_range(250,500)
	var junker = junkShipScene.instance()
	add_child(junker)
	junker.position = shipSpawn
	print(shipSpawn)
