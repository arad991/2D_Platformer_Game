extends Node2D

const SPEED = 60
const DAMAGE = 1
const KNOCKBACK_DISTANCE = 700

var direction = -1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager

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
