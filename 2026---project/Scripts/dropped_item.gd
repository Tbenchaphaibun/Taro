extends Area2D


@export var item_name: String = "Wheat"

var player_nearby: Node2D = null
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = body
		


func _on_body_exited(body: Node2D) -> void:
	if body == player_nearby:
		player_nearby = null


func _unhandled_input(event: InputEvent) -> void:
	if player_nearby != null and event.is_action_pressed("pickup"):
		Inventory.add_item(item_name)
		queue_free()
