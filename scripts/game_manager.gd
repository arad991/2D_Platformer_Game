extends Node

var score = 0
var player

#@onready var score_label: Label = $ScoreLabel
#@onready var hp_label: Label = $HpLabel
@onready var hp_label: Label = $"../CanvasLayer/HpLabel"
@onready var score_label: Label = $ScoreLabel
@export var hearts : Array[Node]
@onready var init_heart: TextureRect = $"../CanvasLayer/Hearts/HBoxContainer/Heart"
@onready var h_box_container: HBoxContainer = $"../CanvasLayer/Hearts/HBoxContainer"


func _ready():
	# Get a reference to the player node
	player = get_node("/root/Game/Player")
	if player == null:
		print("Player node not found")
		
	# Initialize hp to "player.hp" attribute
	#hearts = []
	for i in range(player.PLAYER_HP):
		# Create heart nodes and add them to the array
		var heart = init_heart.duplicate()
		h_box_container.add_child(heart)
		hearts.append(heart)
		
	update_hp()
	
func update_hp():
	#hp_label.text = "HP: " + str(player.current_hp)
	for h in player.PLAYER_HP:
		if h < player.current_hp:
			pass
			hearts[h].show()
		else:
			hearts[h].hide()
	
func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."
