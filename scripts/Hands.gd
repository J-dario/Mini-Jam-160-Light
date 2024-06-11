extends Node2D

var time = 0
var amp = 20.0
var freq = 2.5
var off = 0.0
var prevSinValue = 0.0

var isColliding = false
var line
var double = false
var lose = false

var scoreUpdated1 = 0
var scoreUpdated2 = 0
var rat1
@onready var rope = $Rope
@onready var speed_up = $"../SpeedUP"
@onready var spawner_1 = $"../Spawner1"
@onready var node_2d = $".."
@onready var losetimer = $losetimer
@onready var ropesfx = $ropesfx
@onready var whistle = $whistle
@onready var rat = $rat
@onready var speed = $speed

func _ready():
	Global.canMove = true
	Global.rightJump = []
	time = -3.14 / (2 * freq)
	line = Line2D.new()
	line.default_color = Color(1, 1, 1, 1)
	line.width = 6
	add_child(line)
	Engine.time_scale = 1
	
func _process(delta):
	var sineWave = sin(time * freq) * amp
	if lose:
		sineWave = 19.8
		
	else:	
		time += delta
	position.y = sineWave
	rope.curve.set_point_position(1, Vector2(0, sin(time * freq) * 150))
	
	line.clear_points()
	for point in rope.curve.get_baked_points():
		line.add_point(point)
	
	if sineWave < prevSinValue:
		line.z_index = 0
	else:
		line.z_index = 2
	prevSinValue = sineWave
	
	if sineWave > 15:
		ropesfx.play()
	
	if sineWave > 19.8 and isColliding == false:
		lose = true
		whistle.play()
		Global.canMove = false
		losetimer.start()
		
	if Global.score != 0 and Global.score % 5 == 0 and Global.score != scoreUpdated1:
		speed_up.get_node("AnimationPlayer").play("SpeedUP")
		speed.play()
		Engine.time_scale += 0.25
		scoreUpdated1 = Global.score
	
	if Global.score != 0 and Global.score % 4 == 0 and Global.score != scoreUpdated2:
		rat1 = Global.mouse1.instantiate()
		rat1.position = spawner_1.position
		rat.play()
		node_2d.add_child(rat1)
		scoreUpdated2 = Global.score
	
	
	#if Global.score == 10 and double == false:
		#var newRope = rope.duplicate()
		#add_child(newRope)
		#newRope.position = Vector2(position.x, position.y)
		#rope.curve.set_point_position(1, Vector2(0, sin(time * freq) * 150))
		#double = true
	
func _on_area_2d_body_entered(body):
	Global.score += 1
	if Global.rightJump != []:
		Global.rightJump.remove_at(0)
		print(Global.rightJump)
	isColliding = true

func _on_area_2d_body_exited(body):
	if Global.rightJump == []:
		if rat1 != null:
			rat1.get_node("AnimationPlayer").play("remove")
	isColliding = false


func _on_losetimer_timeout():
	Global.score = 0
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
