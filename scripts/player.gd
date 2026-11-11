extends CharacterBody2D

@export var speed:float = 75.0;
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	update_animation(direction)
	
var last_direction
func update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		if last_direction == "right":
			anim.play("idle_right")
			return
		elif last_direction == "left":
			anim.play("idle_left")
			return
		elif last_direction == "back":
			anim.play("idle_back")
			return
		elif last_direction == "front":
			anim.play("idle_front")
			return
		else:
			anim.play("idle_front")
			return
		

	# Prioritize horizontal or vertical animation when moving diagonally
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim.play("walk_right")
			last_direction = "right"
		else:
			anim.play("walk_left")
			last_direction = "left"
	else:
		if direction.y > 0:
			anim.play("walk_front")
			last_direction = "front" # Moving down toward the camera
		else:
			anim.play("walk_back")
			last_direction = "back" # Moving up away from the camera
