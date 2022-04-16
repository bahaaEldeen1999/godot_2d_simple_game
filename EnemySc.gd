extends KinematicBody2D


var health = 100
var player 
func _ready():
	get_parent().get_node("player").connect("hit_signal",self,"_on_hit_signal")
	player = get_parent().get_node("player")



func _on_hit_signal():
	print()
	if !$AnimationPlayer.assigned_animation == "hit" || !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("hit")

func _physics_process(delta):
	if player.position.x < position.x:
		if $Sprite.flip_h:
			$Sprite.flip_h = false
	else:
		if !$Sprite.flip_h:
			$Sprite.flip_h = true
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("idle")
	move_and_slide(Vector2.ZERO,Vector2(0,-1))
	

