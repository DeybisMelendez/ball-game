extends Area2D

const RADIUS = 256
var scale_size = 0.04
var can_move = false
var pos

func _ready():
	connect("area_entered", self, "ball_entered")

func _input(event):
	if event is InputEventMouseMotion:
		if can_move:
			if pos == null:
				pos = event.get_position() - global_position
			else:
				global_position = event.get_position() - pos

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
