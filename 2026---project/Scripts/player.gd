extends CharacterBody2D

var target = position

@export var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	if event.is_action_presed(&"Click"):
		target = get_global_mouse_position()
		
func _physics_process(delta: float) -> void:
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) >2:
		move_and_slide()
	
