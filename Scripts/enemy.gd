extends Area2D

var is_dead = false

const SPEED = 60
var direction = 2





func _process(delta: float) -> void:
	position.x += direction * SPEED * delta


func _on_hit_area_body_entered(body: Node2D) -> void:
	if is_dead:
		return
		
	if body.name == "Player":
		is_dead = true
		queue_free()
