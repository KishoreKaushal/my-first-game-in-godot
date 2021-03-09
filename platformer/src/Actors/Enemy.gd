extends "res://src/Actors/Actor.gd"

func _ready() -> void:
	# this will disable _physics_process() function until
	# the enemy comes in the scene
	set_physics_process(false)
	_velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity *= -1.0
	# only update y component because when enemy hit the wall 
	# move_and_slide zeros the x component 
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
