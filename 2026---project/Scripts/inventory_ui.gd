extends Control

@onready var label: Label = $Label

func _ready() -> void:
	print("InventoryUI ready!")
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		print("I pressed!")
		visible = not visible
		update_display()

func update_display() -> void:
	label.text = "Inventory:\n"
	for item_name in Inventory.items:
		label.text += item_name + ": " + str(Inventory.items[item_name]) + "\n"
