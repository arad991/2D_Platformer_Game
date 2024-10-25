extends Node

var score = 0
var player

#@onready var score_label: Label = $ScoreLabel
#@onready var hp_label: Label = $HpLabel
@onready var hp_label: Label = $"../CanvasLayer/HpLabel"
@onready var score_label: Label = $ScoreLabel

func _ready():
	# Get a reference to the player node
	player = get_node("/root/Game/Player")
	if player == null:
		print("Player node not found")
		
	# Initialize hp to "player.hp" attribute
	update_hp()
	
func update_hp():
	hp_label.text = "HP: " + str(player.hp)
	
func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."
