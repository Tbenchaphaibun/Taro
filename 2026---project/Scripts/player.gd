extends CharacterBody2D



@export var speed = 100
@export var pivot = Node2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
#Remember which ways the player last face, idle will know way to stand.
var last_direction ="front"
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


	
func _process(delta: float) -> void:
	var direction: Vector2 = Vector2(0.0,0.0)
	direction.x = Input.get_axis("ui_left","ui_right")
	direction.y = Input.get_axis("ui_up","ui_down")
	velocity = speed * direction.normalized()
	
	move_and_slide()
	update_animation(direction)
	
func update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		animated_sprite.play("idle-" + last_direction)
		return
	if abs(direction.x) > abs(direction.y):
		if direction.x < 0:
			last_direction ="left"
		else:
			last_direction ="right"
	elif direction.y < 0:
		last_direction = "back"
	else:
		last_direction = "front"
	animated_sprite.play("walk-" + last_direction)
