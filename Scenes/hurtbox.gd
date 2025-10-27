class_name HurtBox
extends Area2D

@export var damage := 5
	
 
func _ready() -> void:
	connect("area_entered", _on_area_entered)
	

func _on_area_entered(hitbox: HitBox) -> void:
	print("area entered ", hitbox.name )
	if  hitbox == null:
		return
		
	print("owner ", owner)
	if owner.has_method('take_damage'):
		owner.take_damage(damage)
		
