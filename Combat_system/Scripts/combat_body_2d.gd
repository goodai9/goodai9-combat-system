@icon("res://addons/Combat_system/Icons/combat_body_icon.png")

class_name CombatBody2D
extends CharacterBody2D

@export var Overide_Damage_Receiving: bool = false
@export var Damage_Receiver: DamageReceiver2D
@export var Starting_Health: int = 100
@export var Max_Health: int = 100

var current_health: int
signal damage_token(amount: int)

func _ready() -> void:
	Damage_Receiver.damage_received.connect(register_damage)
	current_health = Starting_Health

##handles the taking of damage, use take_damage() instead
func register_damage(damage: int, ignore_overide: bool = false) -> void:
	if ignore_overide:
		current_health = clampi(current_health - damage, 0, Max_Health)
		damage_token.emit(damage)
	else:
		if !Overide_Damage_Receiving and current_health > 0:
			current_health = clampi(current_health - damage, 0, Max_Health)
			damage_token.emit(damage)


func take_damage(damage: int) -> void:
	register_damage(damage, true)

func heal_damage(amount: int) -> void:
	current_health = clampi(current_health + amount, 0, Max_Health)
