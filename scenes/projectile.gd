extends Area2D

@export var speed: float
var shoot_direction


func _process(delta):
	position += shoot_direction * speed * delta


func set_shoot_direction(dir):
	shoot_direction = dir


func _on_body_entered(body):
	queue_free()
