extends CharacterBody2D

@onready var jump_buffer = $JumpBuffer

const JUMP_VELOCITY = -400.0
var buffered_jump = false
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var no_jump = $noJump
@onready var animated_sprite_2d = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
		if Global.canMove:
			if Global.rightJump == []:
				if Input.is_action_just_pressed("up"):
					buffered_jump = true
					jump_buffer.start()
			else:
				if Input.is_action_just_pressed(Global.rightJump[0]):
					buffered_jump = true
					jump_buffer.start()

	else:
		animated_sprite_2d.play("default")
		animated_sprite_2d.flip_h = false
		if Global.canMove:
			if Global.rightJump == []:
				if Input.is_action_just_pressed("up") or buffered_jump == true:
					velocity.y = JUMP_VELOCITY
					animated_sprite_2d.play("up")
					audio_stream_player_2d.play()
					buffered_jump = false
			else:
				if Input.is_action_just_pressed(Global.rightJump[0]) or buffered_jump == true:
					if Global.rightJump[0] == "down":
						animated_sprite_2d.play("down")
					elif Global.rightJump[0] == "right":
						animated_sprite_2d.play("side")
					elif Global.rightJump[0] == "left":
						animated_sprite_2d.flip_h = true
						animated_sprite_2d.play("side")
					elif Global.rightJump[0] == "up":
						animated_sprite_2d.flip_h = true
						animated_sprite_2d.play("up")
					velocity.y = JUMP_VELOCITY
					audio_stream_player_2d.play()
					buffered_jump = false

	move_and_slide()


func _on_jump_buffer_timeout():
	buffered_jump = false
