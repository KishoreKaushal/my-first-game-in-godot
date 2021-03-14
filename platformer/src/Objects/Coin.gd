extends Area2D

onready var anim_player : AnimationPlayer = get_node("AnimationPlayer")

export var score := 25


func picked() -> void:
	PlayerData.score += score
	anim_player.play("fade_out")


func _on_body_entered(body: Node) -> void:
	picked()
