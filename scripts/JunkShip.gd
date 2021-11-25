extends KinematicBody2D

export(int) var health = 1
export(float) var speed = 0
export(Vector2) var velocity = Vector2.ZERO

var explosion = [preload("res://assets/music/explosion1.wav"),
preload("res://assets/music/explosion2.wav")]

func _ready():
	$Anims.play("float")

func _physics_process(delta):
	if Globals.junkShipAlive == true:
		velocity = Vector2.ZERO
		velocity = position.direction_to(Globals.playerInstance) * speed
		move_and_slide(velocity)
	else:
		pass

func getHit(damage: float):
	health = health - damage
	if health <= 0:
		Globals.junkShipAlive = false
		Globals.score = Globals.score + 100000
		randomize()
		var x = randi() % explosion.size()
		$Sounds.stream = explosion[x]
		$Sounds.play()
		yield(get_tree().create_timer(0.8), "timeout")
		queue_free()

func _on_PlayerDetect_body_entered(body):
	pass #AOE attack
