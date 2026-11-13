extends Area2D

const SPEED = 15
var initialized = false # -> Needs to be called
var direction = 0

# Process Kill
func deleteInstance():
	queue_free()

func _process(delta):
	if not initialized:
		return
	
	position.x += direction * SPEED
	
func initialize(startPos: Vector2, move_dir: int):
	position = startPos
	direction = move_dir
	initialized = true


func on_collision(collider):
	if collider.is_in_group("entity"):
		collider.damage()
		deleteInstance()
