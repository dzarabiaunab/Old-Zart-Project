extends CharacterBody2D


var SPEED
const WALK_SPEED = 200
const RUN_SPEED = 320
const JUMP_VELOCITY = -500.0
var current_dir = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Bullet managing
@export var bullet_scene: PackedScene
@export var bullet_manager: NodePath
var ammo = 15

# Animations
func player_animations():
	if Input.is_action_pressed("pl_left"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("idle")

	if Input.is_action_pressed("pl_right"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("idle")

func _update_direction(direction):
	if(direction == current_dir):
		return

# Processing every frame -> Unsure if REALLY framerate dependant
func _physics_process(delta):
	SPEED = WALK_SPEED
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle run.
	if Input.is_action_pressed("run"):
		SPEED = RUN_SPEED
	else:
		SPEED = WALK_SPEED
	
	# Get the input direction and handle the movement/aceleration.
	var direction = Input.get_axis("pl_left", "pl_right")
	if direction:
		velocity.x = direction * SPEED
		_update_direction(direction)
		current_dir = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	player_animations()
	move_and_slide()

# Shooting if button is pressed.
func _unhandled_input(event):
	if event.is_action_pressed("attack_range"):
		_shoot()

# Shooting function, calls bullet manager
func _shoot():
	if ammo <= 0:
		return
	ammo -= 1
	var new_bullet = bullet_scene.instantiate()
	new_bullet.initialize(position, current_dir)
	get_node(bullet_manager).add_bullet(new_bullet)
