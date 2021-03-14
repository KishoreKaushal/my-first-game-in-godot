tool
extends Button

export(String, FILE) var next_scene_path := ""

onready var scene_tree := get_tree()

func _on_button_up() -> void:
	scene_tree.paused = false
	PlayerData.reset()
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning() -> String:
	return "next_scene_path not set" if next_scene_path == "" else ""
