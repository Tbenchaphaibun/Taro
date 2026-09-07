extends Node
#shows something it is happend
signal new_day(day_number)
signal night_started
signal day_started

@export var seconds_per_cycle: float = 10.0
@export var night_starts_at: float =0.6

var time_of_day: float = 0.0
var current_day: int = 1
var is_night: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_of_day += delta / seconds_per_cycle
	
	if time_of_day >= night_starts_at and not is_night:
		is_night = true
		night_started.emit()
		print("Night has started. Day: ", current_day)
	
	if time_of_day >= 1.0:
		time_of_day =0.0
		is_night = false
		current_day += 1
		day_started.emit()
		new_day.emit(current_day)
		print("New day started. Day: ", current_day)
