extends Area2D

const RADIUS = 256
const COLORS = [Color("#d32734"), Color("#da7d22"), Color("#e6da29"), #Endesga 8 Palette
		Color("#28c641"), Color("#2d93dd"), Color("#7b53ad")]
var scale_size = 0.02
var dir = Vector2(randf()*2-1, randf()*2-1)
var speed = randi()%200+100
var is_killed = false

func _ready():
	$CollisionShape2D.shape = CircleShape2D.new()
	$CollisionShape2D.shape.radius = RADIUS*scale_size
	$Sprite.scale = Vector2(scale_size, scale_size)
	$Sprite.modulate = COLORS[randi()% COLORS.size()]

func _physics_process(delta):
	global_position += dir * speed * delta
	var size = RADIUS*scale_size
	if global_position.x < -size:
		global_position.x = size+720
	elif global_position.x > size+720:
		global_position.x = -size
	if global_position.y < -size:
		global_position.y = size+1280
	elif global_position.y > size+1280:
		global_position.y = -size
