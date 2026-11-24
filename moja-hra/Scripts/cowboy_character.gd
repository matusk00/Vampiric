extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var movement_speed : float = 300
@export var bullet_speed : float = 10

var direction : Vector2
var bullet_instance = bullet.instance() 
var bullet = preload("res://Assets/Bullet.png")

# Gets the input direction 
func _physics_process(delta : float) -> void:
	direction.x = Input.get_axis("Left" , "Right")
	direction.y = Input.get_axis("Up" , "Down") 
	direction = direction.normalized() 
	
	# Flips the character when moving right or left
	if direction.x > 0:
		animated_sprite.flip_h = true
	elif direction.x < 0:
		animated_sprite.flip_h = false
	
	# Plays the animations
	if direction == Vector2(0,0):
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Running")
	
	# Moves the character in the direction 
	if direction:
		velocity = direction * movement_speed
	
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
	
	move_and_slide()
	
		# Gets input for shooting
	if Input.is_action_just_pressed("Shoot"):
		shoot()
	
func shoot():
	bullet_instance.position = get_global_position()
	get_tree().call_deferred("add_child",bullet_instance)
	
	
	
