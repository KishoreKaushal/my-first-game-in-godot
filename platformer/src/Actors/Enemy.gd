extends "res://src/Actors/Actor.gd"

func _ready() -> void:
	# this will disable _physics_process() function until
	# the enemy comes in the scene
	set_physics_process(false)
	_velocity.x = -speed.x


func _on_StompDetector_body_entered(body: Node) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return # do nothing if player is below stomp area
	
	get_node("CollisionShape2D").disabled = true
	queue_free() 
	
	
	
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity *= -1.0
	# only update y component because when enemy hit the wall 
	# move_and_slide zeros the x component 
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

