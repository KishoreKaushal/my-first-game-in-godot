extends Control

onready var scene_tree := get_tree()
onready var pause_overlay : ColorRect = get_node("PauseOverlay")
onready var score_label : Label = get_node("ScoreLabel")
onready var pause_title : Label = get_node("PauseOverlay/Title")


var paused := false setget set_paused

func _ready() -> void:
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	update_interface()


func update_interface() -> void:
	score_label.text = "Score: %s" % PlayerData.score
	

func _on_PlayerData_player_died() -> void:
	pause_title.text = "You Died!"


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		scene_tree.set_input_as_handled()


func set_paused(value : bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
	
