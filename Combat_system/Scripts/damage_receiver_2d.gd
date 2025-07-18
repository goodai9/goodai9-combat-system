@icon("res://addons/Combat_system/Icons/damage_receiver_icon.png")

class_name DamageReceiver2D
extends Area2D

signal damage_received(Damage: int)

func _ready() -> void:
	self.area_entered.connect(take_damage)


func take_damage(area: Area2D) -> void:
	if area is DamageArea2D:
		var damage_area_zone: DamageArea2D = area
		damage_received.emit(damage_area_zone.Damage)
