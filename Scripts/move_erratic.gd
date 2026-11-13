extends CharacterBody2D
class_name bugMove

enum states {MOVEIDLE, MOVERIGHT, MOVELEFT, MOVEDOWN, MOVEUP}
var current = states.MOVEIDLE
@export var speed = 500
var dir

func _ready():
	random_generation()
	print(dir)

func _physics_process(delta):
	match current:
		states.MOVEIDLE:
			move_idle()
		states.MOVERIGHT:
			move_right()
		states.MOVELEFT:
			move_left()
		states.MOVEDOWN:
			move_down()
		states.MOVEUP:
			move_up()
	
	move_and_slide() 

func random_generation():
	dir = randi() % 5
	random_direction()

func random_direction():
	match dir:
		0:
			current = states.MOVEIDLE
		1:
			current = states.MOVERIGHT
		2:
			current = states.MOVELEFT
		3:
			current = states.MOVEDOWN
		4:
			current = states.MOVEUP

func move_idle():
	velocity = Vector2.LEFT * 0
	$bugAnim.flip_h = false
	$bugAnim.play("idle")

func move_right():
	velocity = Vector2.RIGHT * speed
	$bugAnim.flip_h = false
	$bugAnim.play("idle")
	
	
func move_left():
	velocity = Vector2.LEFT * speed
	$bugAnim.flip_h = true
	$bugAnim.play("idle")

func move_down():
	velocity = Vector2.DOWN * speed
	$bugAnim.flip_h = true
	$bugAnim.play("idle")

func move_up():
	velocity = Vector2.UP * speed
	$bugAnim.flip_h = false
	$bugAnim.play("idle")


