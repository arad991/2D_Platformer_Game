extends CharacterBody2D

const SPEED = 100
const DAMAGE = 1
const JUMP_VELOCITY = 1500.0
const JUMP_DISTANCE = 20.0
const KNOCKBACK_DISTANCE = 700
var direction = -1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var jump_timer: Timer = $"Jump Timer"


func _ready():
	jump_timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
		
	#position.x += direction * SPEED * delta

	# Check for landing
	if velocity.y < 0 and not is_on_floor():
		velocity.y = 0
		
	#if ray_cast_right.is_colliding():
		#direction = -1
#
	#if ray_cast_left.is_colliding():
		#direction = 1

	move_and_slide()

func _on_killzone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		if y_delta > 13:
			queue_free()
			body.jump()
		else:
			body.get_hit(DAMAGE)
			if x_delta > 0:
				body.jump_side(KNOCKBACK_DISTANCE)
			else:
				body.jump_side(-KNOCKBACK_DISTANCE)
		game_manager.update_hp()
	else:
		print("I collided with: " + body.name)
	
func _on_jump_timer_timeout() -> void:
	if is_on_floor():
		velocity.y = -JUMP_VELOCITY
		# Reverse direction on each jump
		var x = randf()
		if x <= 0.5:
			direction *= -1
			if direction == -1:
				animated_sprite.flip_h = true
			else:
				animated_sprite.flip_h = false
				
