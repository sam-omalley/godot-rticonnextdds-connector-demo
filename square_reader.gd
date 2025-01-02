extends Node2D

var dp: DomainParticipant = DomainParticipant.new()
var reader: ShapeReader = ShapeReader.new()

var all_squares: Dictionary = {}

@export var max_coord: Vector2 = Vector2(236, 266)

func _ready() -> void:
	dp.setup(1)
	reader.set_participant(dp)
	reader.subscribe("Square")

func _process(_delta: float) -> void:
	var squares: Array[Shape] = reader.get_data()
	for square in squares:
		all_squares[square.name] = {
			"name": square.name,
			"position": square.position,
			"size": square.size,
			"angle": square.angle
			}
		queue_redraw()
		
	
	var dead_squares: Array[String] = reader.get_dead_data()
	for square_name in dead_squares:
		all_squares.erase(square_name)
		queue_redraw()

func _draw() -> void:
	var viewport: Vector2 = get_viewport_rect().size
	var multiplier: Vector2 = viewport / max_coord
	
	for square in all_squares.values():
		print(square.position * multiplier)
		draw_set_transform(square.position * multiplier, square.angle)
		var size: Vector2 = Vector2.ONE * square.size
		var rect: Rect2 = Rect2(size * -1.0, size * 2)
		draw_rect(rect, get_color(square.name), true)
		draw_rect(rect, Color.BLACK, false, 2)


func get_color(s: String) -> Color:
	match s:
		"RED":
			return Color.RED
		"PURPLE":
			return Color.PURPLE
		"BLUE":
			return Color.BLUE
		"GREEN":
			return Color.GREEN
		"YELLOW":
			return Color.YELLOW
		"CYAN":
			return Color.CYAN
		"MAGENTA":
			return Color.MAGENTA
		"ORANGE":
			return Color.ORANGE
		_:
			print(s)
			return Color.BLACK
