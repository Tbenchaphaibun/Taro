extends Node2D

@onready var animated_sprite: AnimatedSprite2D =$AnimatedSprite2D

@export var crop_name: String = "Wheat"
@export var max_stage: int = 3
@export var seconds_per_growth: float = 10.0
@export var drop_item_scene: PackedScene

var growth_stage: int = 0 
var timer: float = 0.0
var is_ready: bool = false

func _ready() -> void:
	animated_sprite.animation = "grow"
	animated_sprite.frame = growth_stage
	add_to_group("crop")
	
func _process(delta: float) -> void:
	if growth_stage >= max_stage:
		is_ready = true
		return
		
	timer += delta
	if timer >= seconds_per_growth:
		timer = 0.0
		growth_stage += 1
		animated_sprite.frame = growth_stage

func harvest() -> void:
	var drop = drop_item_scene.instantiate()
	drop.global_position = global_position
	get_parent().add_child(drop)
	queue_free()
