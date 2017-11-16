extends KinematicBody2D

export var SPEED = 100

var velocity = Vector2()
var anim

func _ready():
	anim = get_node("AnimatedSprite")
	set_physics_process(true)
	
func _physics_process(delta):
	
	var up  = Input.is_action_pressed("ui_up")
	var down  = Input.is_action_pressed("ui_down")
	var left  = Input.is_action_pressed("ui_left")
	var right  = Input.is_action_pressed("ui_right")
	
	if up || down || left || right:
		if up:
			velocity.x = 0
			velocity.y = -SPEED 
			anim.play("walkUp")
		elif down:
			velocity.x = 0
			velocity.y = SPEED
			anim.play("walkDown")
		elif left:
			velocity.x = -SPEED
			velocity.y = 0
			anim.play("walkLeft_Right")
			anim.flip_h = false
		elif right:
			velocity.x = SPEED
			velocity.y = 0
			anim.play("walkLeft_Right")
			anim.flip_h = true
	else:
		velocity = Vector2(0, 0)
		anim.stop()
		anim.frame = 0
			
	move_and_collide(velocity * delta)
	
	
	
