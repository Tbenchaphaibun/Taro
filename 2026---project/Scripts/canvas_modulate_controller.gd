extends CanvasModulate
#Color for day and night
@export var day_color: Color = Color(1.0, 1.0, 0.95)
@export var night_color: Color = Color(0.08, 0.08, 0.2)

func _process(delta: float) -> void:
	var t := DayNightCycle.time_of_day
	var brightness := sin(t *TAU)
	var blend := (brightness + 1.0) / 2.0
	color = night_color.lerp(day_color, blend)
