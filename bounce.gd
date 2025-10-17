extends AnimatedSprite2D
@export var speed: Vector2 = Vector2(300, 300)
var sprite_size: Vector2
var screen_size: Vector2
var bounce_sound: AudioStreamPlayer2D
func _ready():
	play()
	
	# screen size
	screen_size = get_viewport_rect().size
	
	# dimensions
	var tex = sprite_frames.get_frame_texture(animation, frame)
	var scale_val = min(384.0 / tex.get_width(), 216.0 / tex.get_height())
	scale = Vector2(scale_val, scale_val)
	
	# spritesize
	sprite_size = tex.get_size() * scale
	
	# center
	position = screen_size / 2
	
	# sound
	bounce_sound = $BounceSound

func _process(delta):
	position += speed * delta
	
	var half_size = sprite_size / 2 if centered else Vector2.ZERO
	var min_pos = half_size
	var max_pos = screen_size - half_size if centered else screen_size - sprite_size
	
	var bounced = false
	
	if position.x <= min_pos.x:
		position.x = min_pos.x
		speed.x = abs(speed.x)
		bounced = true
	elif position.x >= max_pos.x:
		position.x = max_pos.x
		speed.x = -abs(speed.x)
		bounced = true
	
	if position.y <= min_pos.y:
		position.y = min_pos.y
		speed.y = abs(speed.y)
		bounced = true
		
	elif position.y >= max_pos.y:
		position.y = max_pos.y
		speed.y = -abs(speed.y)
		bounced = true
		
	if bounced:
		bounce_sound.play()
