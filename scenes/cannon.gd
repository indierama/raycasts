extends Area2D

@export var rotation_speed: float
@export var projectile_scene: PackedScene

@onready var ray_cast_2d = $CannonSprite/RayCast2D
@onready var timer = $Timer
@onready var cannon_sprite = $CannonSprite

var can_shoot = true


func _process(delta):
	cannon_sprite.rotation_degrees += rotation_speed * delta


func _physics_process(delta):
	if not can_shoot:
		return
	
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		
		if collider.is_in_group("player"):
			shoot_projectile()


func shoot_projectile():
	var projectile_instance = projectile_scene.instantiate()
	get_parent().add_child(projectile_instance)
	projectile_instance.position = position
	var collision_point = ray_cast_2d.get_collision_point()
	var shoot_direction = (collision_point - position).normalized()
	projectile_instance.set_shoot_direction(shoot_direction)
	can_shoot = false
	timer.start()


func _on_timer_timeout():
	can_shoot = true
