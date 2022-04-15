extends Area2D

export var MAX_SPEED = 200 
export var INITIAL_SPEED = 100 
export var ACCELERATION = 10 
export var FRICTION = 2
export var JUMP_FORCE = 20
export var GRAVITY = 10
var SCREEN_SIZE = null 
var velocity = Vector2(0,0)

func _ready():
	SCREEN_SIZE = get_viewport_rect().size

func process_movement(delta):
	if Input.is_action_pressed("move_right"):
		velocity.x += ACCELERATION
	elif Input.is_action_pressed("move_left"):
		 velocity.x -= ACCELERATION
	elif Input.is_action_pressed("jump"):
		velocity.y -= JUMP_FORCE
	
	else:
		if velocity.x > 0:
			velocity.x -= FRICTION
		elif velocity.x < 0:
			velocity.x += FRICTION
		if velocity.y < 200:
			velocity.y +=  GRAVITY
		else:
			velocity.y = 0
			
		
	velocity.x = clamp(velocity.x,-MAX_SPEED,MAX_SPEED)
	position += velocity*delta
	
func _process(delta):
	process_movement(delta)
