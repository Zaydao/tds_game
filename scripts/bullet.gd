extends Area2D

var direction = Vector2.RIGHT
var speed = 500

@export var particle_path : PackedScene

func _process(delta):
	translate(direction.normalized() * speed * delta)


func _on_body_entered(body):
	var particle = particle_path.instantiate()
	particle.position = global_position
	get_tree().current_scene.add_child(particle)
	particle.emitting = true
	
	
	queue_free()
	if body.is_in_group("enemy"):
		body.take_damage()
		queue_free()
	
