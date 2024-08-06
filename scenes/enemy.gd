extends Area2D

@export var projectile_scene: PackedScene

@onready var timer = $Timer
@onready var ray_cast_2d = $RayCast2D

var is_shooting = false
var player


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta):
	ray_cast_2d.target_position = to_local(player.position)
	
	if is_shooting:
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
	is_shooting = true
	timer.start()


func _on_timer_timeout():
	is_shooting = false
