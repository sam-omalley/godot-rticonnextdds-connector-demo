extends Node2D

var dp: DomainParticipant = DomainParticipant.new()
var reader: ShapeReader = ShapeReader.new()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		dp.teardown()
		get_tree().quit()

func _ready() -> void:
	get_tree().set_auto_accept_quit(false)
	dp.setup(1)
	reader.set_participant(dp)
	reader.subscribe("Square")

func _process(delta: float) -> void:
	var squares: Array[Shape] = reader.read()
	for square in squares:
		print(square.name)
		print(square.position)
		print(square.size)
		print(square.angle)
