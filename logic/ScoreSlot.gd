extends Node2D

onready var _sprite = $Sprite

var is_active = false

const empty_score_texture = preload("res://assets/EmptyScoreSlot.png")
const full_score_texture = preload("res://assets/FullScoreSlot.png")

func set_active():
	is_active = true
	_sprite.texture = full_score_texture
