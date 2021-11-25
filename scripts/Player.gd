extends KinematicBody2D

var velocity = Vector2(0,0)

onready var healthAnims = get_node("Health/HealthAnims")
var pulseInstance = preload("res://scenes/Pulse.tscn")

var music = ['extraterrestrial1', 
'ocean1']
var laser = preload("res://assets/music/laser1.wav")
var explosion1 = preload("res://assets/music/explosion1.wav")

#Player states
var canMove = true

const speed = 100
const airResist = 325

func _ready():
	$Anims.play("alienIdle")
	if Globals.junkShipAlive == false:
		$Sound.stream = explosion1
		$Sound.play()
		Globals.junkShipAlive = true

func _process(delta):
	$Score.text = "Score: " + str(Globals.score)
	$Materials/LNum.text = str(Globals.materialsNum)
	

func _physics_process(delta):
	if canMove == true:
		if Input.is_action_pressed("Left"):
			velocity.x = -speed
			$State.text = "Left"
			$Anims.play("alienLeft")
		elif Input.is_action_pressed("Right"):
			velocity.x = +speed
			$State.text = "Right"
			$Anims.play("alienRight")
		elif Input.is_action_pressed("Up"):
			velocity.y = -speed
			$State.text = "Up"
		elif Input.is_action_pressed("Down"):
			velocity.y = +speed
			$State.text = "Down"
		else:
			velocity = velocity.move_toward(Vector2.ZERO, airResist * delta)
			$State.text = "Idle"
			$Anims.play("alienIdle")
	else:
		velocity = Vector2.ZERO
		$State.text = "Idle"
		$Anims.play("alienIdle")
		
	move_and_collide(velocity * delta)
	
func _unhandled_input(event):
	if Globals.materialsNum > 0:
		if event.is_action_pressed("Pulse"):
			Pulse()
	else:
		pass

func beam():
	canMove = false
	$Beam.visible = true
	
func reverseBeam():
	canMove = true
	$Beam.visible = false
	
func health():
	if Globals.health == 6:
		healthAnims.play("6")
	elif Globals.health == 5:
		healthAnims.play("5")
		
func Pulse():
	if Input.is_action_pressed("Pulse"):
		var pulse = pulseInstance.instance()
		$Sound.stream = laser
		$Sound.play()
		add_child(pulse)
		Globals.materialsNum -= 1
