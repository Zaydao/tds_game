extends CharacterBody2D

const speed = 200
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

var hp
var player: Node2D

func _ready():
	hp = Global.enemy1_health
	player = get_node("/root/world/player") as Node2D
	if player:
		makepath()
	else:
		print("Player node is not found at path: /root/world/player")

func take_damage():
	hp -= Global.bullet1_dm
	
	if hp <= 0:
		queue_free()

func _physics_process(_delta: float) -> void:
	if player:
		# Rotește dușmanul să se uite spre jucător
		look_at(player.global_position)

		# Calculează direcția către jucător și mișcă dușmanul în acea direcție
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
	else:
		print("Player node is not assigned.")

func makepath() -> void:
	if player:
		nav_agent.target_position = player.global_position
	else:
		print("Player node is not assigned.")

func _on_timer_timeout():
	makepath()
