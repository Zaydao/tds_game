extends CharacterBody2D

var max_speed = 350
var accel = 1500
var friction = 900

var angle
var rotation_speed = 20

var input = Vector2.ZERO

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized()
	
func _physics_process(delta):
	player_movment(delta)
	
	#look_at(get_global_mouse_position())
	angle = (get_global_mouse_position() - global_position).angle()
	if angle:
		global_rotation = lerp_angle(global_rotation, angle, delta *rotation_speed)

func player_movment(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if  velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta )
		velocity = velocity.limit_length(max_speed)
	move_and_slide()
		
	
