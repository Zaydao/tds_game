extends CharacterBody2D

const speed = 200
const rotation_speed = 8

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var attack_timer := $AttackTimer  # Asigură-te că ai un Timer pentru atac

var hp
var player: Node2D

var player_in_range = false
var can_attack = true

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
	if player and is_instance_valid(player) and player.is_inside_tree():
		var target_position = nav_agent.get_next_path_position()
		var direction = (target_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		
		# Rotează inamicul spre direcția mișcării
		if velocity.length() > 0:
			var target_rotation = velocity.angle()
			rotation = lerp_angle(rotation, target_rotation, rotation_speed * _delta)
	else:
		player = null  # Resetează referința pentru a preveni accesările ulterioare nevalide
		print("Player node is not assigned or has been removed.")

func makepath() -> void:
	if player and is_instance_valid(player) and player.is_inside_tree():
		nav_agent.target_position = player.global_position
	else:
		print("Player node is not assigned or has been removed.")


func _on_timer_timeout():
	makepath()


func _on_attack_timeout():
	attack()
	can_attack = true
		

func attack():
	if player_in_range and can_attack:
		player.take_damage()
		print("player take damage")
		$attack.start()
		can_attack = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		can_attack = true
		attack()
		

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		
