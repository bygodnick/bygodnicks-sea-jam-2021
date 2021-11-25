extends Node2D

export(int) var wanderingRange = 50
export(int) var timer = 5

onready var startPosition = global_position
onready var targetPosition = global_position

func _ready():
	$Timer.wait_time = timer

func updateTargetPosition():
	var targetVec = Vector2(rand_range(-wanderingRange, wanderingRange), rand_range(-wanderingRange,wanderingRange))
	targetPosition = startPosition + targetVec

func _on_Timer_timeout():
	updateTargetPosition()
