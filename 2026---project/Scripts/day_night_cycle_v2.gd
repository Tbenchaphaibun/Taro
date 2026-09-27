extends Node

signal new_day(day_number)
signal night_started
signal day_started

@export var seconds_per_cycle: float = 300.0
@export var night_starts_at = 0.6
var current_day: int = 1
var is_night: bool = false
var time_of_day: float =0.0

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var seconds_since_start = Time.get_ticks_msec() / 1000.0
	#fmod = division remainder, it make the loop back to 0
	time_of_day = fmod(seconds_since_start, seconds_per_cycle) / seconds_per_cycle
	if  time_of_day >= night_starts_at and not is_night:
		is_night = true
		night_started.emit()
		print("Night has started. Day: ", current_day)
	elif time_of_day < night_starts_at and is_night:
		is_night = false
		current_day += 1
		day_started.emit()
		new_day.emit(current_day)
		print("New day started. Day: ", current_day)
	
	
