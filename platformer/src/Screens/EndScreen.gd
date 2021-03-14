extends Control

onready var label : Label = get_node("Label")

func _ready():
	label.text = "Your final score is %s.\nYou died %s times." % [PlayerData.score, PlayerData.deaths]
