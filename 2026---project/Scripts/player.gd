extends CharacterBody2D

const TERRAIN_SET = 0
const DIRT_TERRAIN = 1
const EMPTY_TILE = -1


@export var speed = 100
@export var pivot = Node2D
@export var farmland: TileMapLayer
@export var crop_scene: PackedScene
@export var grass_layer: TileMapLayer
@export var seed_scenes: Array[PackedScene] = []
@export var seed_names: Array[String] = []
@export var seed_icons: Array[Texture2D] = []
@export var seed_label: Label
@export var seed_icon: TextureRect

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
#Remember which ways the player last face, idle will know way to stand.
var last_direction ="front"
var current_seed: int = 0 

func _ready() -> void:
	add_to_group("player")
	update_seed_ui()

func _physics_process(_delta: float) -> void:
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

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		dig()
	if event.is_action_pressed("plant"):
		plant()
	if event.is_action_pressed("switch_seed"):
		switch_seed()
		
func dig() -> void:
	
	var tile_pos = farmland.local_to_map(global_position)
	if grass_layer != null and grass_layer.get_cell_source_id(tile_pos) == EMPTY_TILE:
		return
	farmland.set_cells_terrain_connect([tile_pos], TERRAIN_SET, DIRT_TERRAIN)
	
		
func plant() -> void:
	var tile_pos = farmland.local_to_map(global_position)
	
	if seed_scenes.is_empty():
		return
	
	if farmland.get_cell_source_id(tile_pos) == EMPTY_TILE:
		print("not on dirt")
		return
	
	for crop in get_tree().get_nodes_in_group("crop"):
		if farmland.local_to_map(crop.global_position) == tile_pos:
			if crop.is_ready:
				crop.harvest()
			return

	print("no crop here, planting new one")
	var world_pos = farmland.map_to_local(tile_pos)
	var new_crop = seed_scenes[current_seed].instantiate()
	new_crop.global_position = world_pos
	get_parent().add_child(new_crop)
	
#Moves to the next seed, and loop back to the first one
func switch_seed() -> void:
		if seed_scenes.is_empty():
			return
		current_seed = (current_seed + 1 ) % seed_scenes.size()
		update_seed_ui()
		
#Shows the chosen seed's and bag name on screen
func update_seed_ui() -> void:
	if seed_label == null or seed_icon == null:
		return
	if seed_names.is_empty() or seed_icons.is_empty():
		return
		
	seed_label.text = "Seed: " + seed_names[current_seed]
	seed_icon.texture = seed_icons[current_seed]
	
 
