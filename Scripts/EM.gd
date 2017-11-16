extends Node2D

var timer
var isTimeOut = true

var enemyNum = 0

var enemyScene

func _ready():
	timer = get_node("Timer")
	enemyScene = load("res://Scenes/Enemy.tscn")
	
	timer.connect("timeout", self, "on_Timer_Timeout")
	set_process(true)

func _process(delta):
	if isTimeOut:
		timer.wait_time = 5
		timer.start()
		isTimeOut = false
		
func on_Timer_Timeout():
	spawn_Enemy()
	
func spawn_Enemy():
	var rootNode = get_node("/root/Base")
	var enemy = enemyScene.instance()
	
	enemy.state = enemy.STATES.IDLE
	
	var randXPos = int(rand_range(-400, 400))
	var randYPos = int(rand_range(-400, 400))
	
	enemy.id = enemyNum
	enemy.position.x = randXPos
	enemy.position.y = randYPos
	
	rootNode.add_child(enemy)
	
	enemyNum += 1
	isTimeOut = true
