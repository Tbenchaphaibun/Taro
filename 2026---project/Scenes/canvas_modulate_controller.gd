extends CanvasModulate
#Color for day and night
@export var day_color: Color = Color(1.0, 1.0, 0.95)
@export var night_color: Color = Color(0.15, 0.15, 0.35)
#how many seconds the fade between day and night takes.
@export var fade_duration: float = 22.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color = day_color
	DayNightCycle.night_started.connect(_on_night_started)
	DayNightCycle.day_started.connect(_on_day_started)


func _on_night_started() ->void:
	var tween := create_tween()
	tween.tween_property(self, "color", night_color, fade_duration)

func _on_day_started() ->void:
	var tween := create_tween()
	tween.tween_property(self, "color", day_color, fade_duration)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
