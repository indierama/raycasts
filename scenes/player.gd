extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed


func _physics_process(delta):
	get_input()
	update_animation()
	flip()
	move_and_slide()
	

func update_animation():
	if velocity.length() > 0.0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("default")


func flip():
	if velocity.x != 0:
		animated_sprite.flip_h = velocity.x < 0.0
		
	
