extends Area2D

const RADIUS = 256
var scale_size = 0.04
var can_move = false
var is_pressed = false
var pos

func _ready():
	connect("area_entered", self, "ball_entered")
	level_up(0) #reseteamos el shape en caso de multiples partidas

func _input(event):
	if event is InputEventMouse:
		if can_move:
			if is_pressed:
				if pos == null:
					pos = event.get_position() - global_position
				else:
					global_position = event.get_position() - pos

func _physics_process(delta):
	if Input.is_action_just_pressed("clic"):
		is_pressed = true
	elif Input.is_action_just_released("clic"):
		is_pressed = false
		pos = null
	var size = RADIUS*scale_size
	if global_position.x < 0:
		global_position.x = 0
	elif global_position.x > 720:
		global_position.x = 720
	if global_position.y < 0:
		global_position.y = 0
	elif global_position.y > 1280:
		global_position.y = 1280

func level_up(points):
	scale_size += points
	$CollisionShape2D.shape.radius = RADIUS*scale_size
	$Sprite.scale = Vector2(scale_size, scale_size)

func ball_entered(ball):
	if not ball.is_killed:
		if ball.scale_size < scale_size:
			level_up(0.001)
			ball.is_killed = true
			ball.queue_free()
			get_parent().instance_ball(true)
			$AudioStreamPlayer.play()
		else:
			get_parent().end()
