extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const PLAYER_HP = 3
var current_hp = PLAYER_HP

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func jump():
	velocity.y = JUMP_VELOCITY
	
func jump_side(x):
	velocity.y = JUMP_VELOCITY /2
	velocity.x = x

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: 1, 0, -1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Play animations
	
	if current_hp <= 0:
			animated_sprite.animation = "death"
			
	elif animated_sprite.animation == "getting_hit" and animation_player.is_playing():
		pass # pass is intentional so the condition delays going back to idle state
		
	elif is_on_floor():
		if direction == 0:
			print("Playing idle")
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# decreases player hp by 1
func get_hit(damage):
	current_hp -= damage
	animated_sprite.animation = "getting_hit"
	animation_player.play("getting_hit")
	#animated_sprite.animation = "getting_hit"
	#animated_sprite.play("getting_hit")
	print("Playing getting_hit animation")
	
