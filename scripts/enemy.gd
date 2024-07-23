extends CharacterBody2D

const speed = 200
const rotation_speed = 8

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

var hp
var player: Node2D

func _ready():
	hp = Global.enemy1_health
	player = get_node("/root/world/player") as Node2D
	if player:
		makepath()

func take_damage():
	hp -= Global.bullet1_dm
	
	if hp <= 0:
		queue_free()

func _physics_process(_delta: float) -> void:
	if player:
		var target_position = nav_agent.get_next_path_position()
		var direction = (target_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		
		# Rotează inamicul spre direcția mișcării
		if velocity.length() > 0:
			var target_rotation = velocity.angle()
			rotation = lerp_angle(rotation, target_rotation, rotation_speed * _delta)
	else:
		print("Player node is not assigned.")

func makepath() -> void:
	if player:
		nav_agent.target_position = player.global_position
	else:
		print("Player node is not assigned.")

func _on_timer_timeout():
	makepath()
