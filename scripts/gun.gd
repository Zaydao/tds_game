extends Node2D

var bullet_scene = preload("res://scenes/bullet.tscn")

var can_shoot = true


func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.direction = $Marker2D.global_position - global_position
	bullet.global_position = $Marker2D.global_position
	get_tree().get_root().add_child(bullet)
	$can_shoot.start()

func _physics_process(delta):
	
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
		can_shoot = false


func _on_can_shoot_timeout():
	can_shoot = true
	
