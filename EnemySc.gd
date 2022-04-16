extends KinematicBody2D


var health = 100
var speed = 50
var player 
var velocity = Vector2.ZERO
func _ready():
	get_parent().get_node("player").connect("hit_signal",self,"_on_hit_signal")
	player = get_parent().get_node("player")



func _on_hit_signal():
	if health <= 0:
		return
	
	health -= 10 
			
	if !$AnimationPlayer.assigned_animation == "hit" || !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("hit")

func _physics_process(delta):
	
	
	
	velocity = Vector2.ZERO
	if health <=0:
		if !$AnimationPlayer.assigned_animation == "death":
			$AnimationPlayer.play("death")
			$AnimationPlayer.playback_speed = 1
		elif $AnimationPlayer.assigned_animation == "death" && !$AnimationPlayer.is_playing():
			queue_free()
		return
	if player.position.x < position.x:
		if $Sprite.flip_h:
			$Sprite.flip_h = false
	elif player.position.x > position.x:
			if !$Sprite.flip_h:
				$Sprite.flip_h = true
					
	if abs(player.position.x-position.x) > 100:
		if player.position.x < position.x:
			velocity.x -= speed
		elif player.position.x > position.x:
			velocity.x += speed
	else:
		velocity.x = 0 
	
	if $AnimationPlayer.assigned_animation != "hit" || !$AnimationPlayer.is_playing():
		if velocity.x == 0:
			if $AnimationPlayer.assigned_animation != "idle":
				$AnimationPlayer.play("idle")
		else:
			if $AnimationPlayer.assigned_animation != "walk":
				$AnimationPlayer.play("walk")
	move_and_slide(velocity,Vector2(0,-1))
	

