extends Area2D

var direction = Vector2.RIGHT
var speed = 500

func _process(delta):
	translate(direction.normalized() * speed * delta)


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage()
		queue_free()
	
