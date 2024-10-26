extends Node

@onready var pause_panel: Panel = %"Pause Panel"
@onready var pause_headline_label: Label = $"Pause Panel/Label"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var esc_pressed = Input.is_action_just_pressed("pause")
	if esc_pressed:
		get_tree().paused = true
		pause_panel.show()


func _on_resume_pressed() -> void:
	pause_panel.hide()
	get_tree().paused = false
	pause_headline_label.text = "WHY DID YOU STOP?"


func _on_main_menu_pressed() -> void:
	pause_headline_label.text = "THERE IS NO MAIN MENU"
