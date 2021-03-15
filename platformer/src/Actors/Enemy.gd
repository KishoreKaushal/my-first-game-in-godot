extends "res://src/Actors/Actor.gd"

export var score := 100

onready var audio_player : AudioStreamPlayer = get_node("AudioStreamPlayer")
onready var collision_shape_2D : CollisionShape2D = get_node("CollisionShape2D")
onready var timer : Timer = get_node("Timer")


func _ready() -> void:
	# this will disable _physics_process() function until
	# the enemy comes in the scene
	set_physics_process(false)
	_velocity.x = -speed.x


func die() -> void:
	audio_player.play()
	PlayerData.score += score
	get_node("CollisionShape2D").disabled = true
	collision_shape_2D.set_deferred("disabled", true)
	timer.wait_time = 0.3
	timer.start()


func _on_Timer_timeout() -> void:
	queue_free() 


func _on_StompDetector_body_entered(body: Node) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return # do nothing if player is below stomp area
	die()


func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity *= -1.0
	# only update y component because when enemy hit the wall 
	# move_and_slide zeros the x component 
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

