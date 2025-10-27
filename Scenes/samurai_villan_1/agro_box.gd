class_name AgroBox
extends Area2D

@export var enemy_owner : RigidBody2D
 
func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_exited(player) -> void:
	if player.is_in_group("Player"):
		enemy_owner.is_player_in_agro_range = false


func _on_body_entered(player) -> void:
	if  player == null:
		return
		
	if player.is_in_group("Player"):
		enemy_owner.is_player_in_agro_range = true
