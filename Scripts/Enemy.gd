extends KinematicBody2D

var state
var stateChange
var id
var idleTimer
var isIdle

var idleMoveTimer
var isIdleMove

var dir = Vector2(0, 0)

export var SPEED = 65

enum STATES {
	IDLE,
	CHASE	
}

func _ready():
	isIdle = true
	isIdleMove = false
	
	idleTimer = get_node("IdleTimer")
	idleTimer.connect("timeout", self, "idle_Timeout")
	
	idleMoveTimer = get_node("IdleMoveTimer")
	idleMoveTimer.connect("timeout", self, "reset_Timer")
	
	get_tree().connect("idle_frame", self, "stateFunc")
	set_process(true)
	
func _process(delta):
	var playerNode = get_node("/root/Base/Player")
	var distX = abs(playerNode.position.x - position.x)
	var distY = abs(playerNode.position.y - position.y)
	var dist = round((distX + distY)/2)
	#print (str(dist) + " : " + str(id))
	
	if dist <= 100:
		state = STATES.CHASE		
	else:
		state = STATES.IDLE
			
	if isIdleMove:
		move_and_collide(dir * delta)
	
func stateFunc():
	match state:
		STATES.IDLE:
			var rand = int(rand_range(1, 5))
			if isIdle:
				idleTimer.wait_time = rand
				idleTimer.start()
				isIdle = false
		STATES.CHASE:
			pass
			
func idle_Timeout():
	var dirInt = int(rand_range(1,4))
	
	match dirInt:
		1:
			dir = Vector2(0, -SPEED)
		2:
			dir = Vector2(0, SPEED)
		3:
			dir = Vector2(-SPEED, 0)
		4:
			dir = Vector2(SPEED, 0)
	
	idleMoveTimer.wait_time = int(rand_range(1, 3))
	idleMoveTimer.start()
	isIdleMove = true
			
func reset_Timer():
	isIdleMove = false
	isIdle = true