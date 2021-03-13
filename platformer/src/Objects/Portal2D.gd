tool
extends Area2D

onready var anim_payer : AnimationPlayer = $AnimationPlayer

export var next_scene : PackedScene


func _on_body_entered(body: Node) -> void:
	teleport()

func _get_configuration_warning() -> String:
	return "`next_scene` can't be empty" if not next_scene else ""

func teleport() -> void:
	anim_payer.play("fade_in")
	yield(anim_payer, "animation_finished")
	get_tree().change_scene_to(next_scene)	
