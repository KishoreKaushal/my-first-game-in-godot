extends KinematicBody2D

class_name Actor

const FLOOR_NORMAL := Vector2.UP

# length unit: pixel, time unit: seconds
var velocity := Vector2.ZERO

# exporting allows us to change value through inspector 
export var speed := Vector2(300, 1000)
export var gravity := 30000.0 
