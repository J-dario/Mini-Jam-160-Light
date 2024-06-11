extends Node2D

var actions = []
@onready var spawn_1 = $Sprite2D/Spawn1
@onready var spawn_2 = $Sprite2D/Spawn2
@onready var sprite_2d = $Sprite2D

func _ready():
	randomize()
	var pos1 = randi_range(1, 4)
	var pos2 = randi_range(1, 4)
	actions.append(pos1)
	actions.append(pos2)

	if pos1 == 1:
		var up = Global.up.instantiate()
		up.position = spawn_1.position
		up.scale = Vector2(1.8, 1.8)
		sprite_2d.add_child(up)
		Global.rightJump.append("up")
		
	elif pos1 == 2:
		var down = Global.down.instantiate()
		down.position = spawn_1.position
		down.scale = Vector2(1.8, 1.8)
		sprite_2d.add_child(down)
		Global.rightJump.append("down")
	elif pos1 == 3:
		var left = Global.left.instantiate()
		left.position = spawn_1.position
		left.scale = Vector2(1.8, 1.8)
		sprite_2d.add_child(left)
		Global.rightJump.append("left")
	elif pos1 == 4:
		var right = Global.right.instantiate()
		right.position = spawn_1.position
		right.scale = Vector2(1.8, 1.8)
		sprite_2d.add_child(right)
		Global.rightJump.append("right")
		
	if pos2 == 1:
		var up = Global.up.instantiate()
		up.position = spawn_2.position
		up.scale = Vector2(1.8, 1.8)
		sprite_2d.add_child(up)
		Global.rightJump.append("up")
	elif pos2 == 2:
		var down = Global.down.instantiate()
		down.position = spawn_2.position
		down.scale = Vector2(1.8, 1.8)
		sprite_2d.add_child(down)
		Global.rightJump.append("down")
	elif pos2 == 3:
		var left = Global.left.instantiate()
		left.position = spawn_2.position
		left.scale = Vector2(1.8, 1.8)
		sprite_2d.add_child(left)
		Global.rightJump.append("left")
	elif pos2 == 4:
		var right = Global.right.instantiate()
		right.position = spawn_2.position
		right.scale = Vector2(1.8, 1.8)
		sprite_2d.add_child(right)
		Global.rightJump.append("right")
