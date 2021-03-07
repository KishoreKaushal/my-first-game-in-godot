extends KinematicBody2D

class_name Actor

# length unit: pixel, time unit: seconds
var velocity := Vector2.ZERO

# exporting allows us to change value through inspector 
export var max_velocity := Vector2(300, 1000)
export var gravity := 3000.0 

# virtual method function from Node class
# this function is called after every delta time `t` 
# (eg., after every frame) to sync the physics with frame
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta;
	velocity = move_and_slide(velocity)
