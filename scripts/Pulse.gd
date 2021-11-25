extends Area2D

export(int) var damage = 50

func _ready():
	$Anims.play("expand")

func hit(body):
	if body.has_method("getHit"):
		body.getHit(damage)
		yield(get_tree().create_timer(1.2), "timeout")
		queue_free()

func _on_Pulse_body_entered(body):
	hit(body)
