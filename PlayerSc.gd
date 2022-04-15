extends KinematicBody2D



export var MAX_SPEED = 200 
export var INITIAL_SPEED = 100 
export var ACCELERATION = 10 
export var FRICTION = 5
export var JUMP_FORCE = 190
export var GRAVITY = 10
export var JUMP_COUNT = 2

var curr_jump_counter = 0
var SCREEN_SIZE = null 
var velocity = Vector2(0,0)
var timer = 0.1

func _ready():
	SCREEN_SIZE = get_viewport_rect().size
	$Timer.start(0.1)
	$Timer.one_shot = true

func process_movement(delta):
	if is_on_floor():
		curr_jump_counter = 0
		velocity.y = 0
	else:
		velocity.y += GRAVITY
		
	if velocity.x > 0:
		velocity.x -= FRICTION
	elif velocity.x < 0:
		velocity.x += FRICTION
		
	if Input.is_action_pressed("move_right"):
		if $Sprite.flip_h:
			$Sprite.flip_h = false
		velocity.x += ACCELERATION
	if Input.is_action_pressed("move_left"):
		if !$Sprite.flip_h:
			$Sprite.flip_h = true
		velocity.x -= ACCELERATION
	if Input.is_action_pressed("jump"):
		if (is_on_floor() || curr_jump_counter < JUMP_COUNT) &&  !$Timer.time_left:
			#print("jumping",curr_jump_counter)
			$Timer.start(0.2)
			curr_jump_counter += 1
			velocity.y -= JUMP_FORCE*curr_jump_counter
	
		
		
		
	

			
		
	velocity.x = clamp(velocity.x,-MAX_SPEED,MAX_SPEED)
	#print(is_on_floor(),velocity)
	if velocity.y > 10:
		$AnimationPlayer.play("jump_down")
	elif velocity.y < 0:
		$AnimationPlayer.play("jump_up")
	elif Input.is_action_pressed("attack"):
		if $AnimationPlayer.assigned_animation != "attack1":
			$AnimationPlayer.play("attack1")
	elif abs(velocity.x) < 40:
		$AnimationPlayer.play("idle")
	elif velocity.x != 0:
		$AnimationPlayer.play("run")
	move_and_slide(velocity,Vector2(0,-1))
	
func _physics_process(delta):
	process_movement(delta)



