extends Node2D

const SPEED = 60
const DAMAGE = 1
const KNOCKBACK_DISTANCE = 700

var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var death_sound: AudioStreamPlayer2D = $"Death Sound"
@onready var collision_shape_2d: CollisionShape2D = $Killzone/CollisionShape2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += direction * SPEED * delta
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false


func _on_killzone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		if y_delta > 9:
			death_sound.play()
			body.jump()
			self.visible = false
			await get_tree().create_timer(0.3).timeout
			queue_free()

		else:
			body.get_hit(DAMAGE)
			if x_delta > 0:
				body.jump_side(KNOCKBACK_DISTANCE)
			else:
				body.jump_side(-KNOCKBACK_DISTANCE)
		game_manager.update_hp()
	else:
		print("I collided with: " + body.name)
