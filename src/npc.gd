extends CharacterBody2D

@export var icon: Texture
@export_multiline var physical_description: String
@export_multiline var location_description: String
@export_multiline var personality: String
@export_multiline var secret_knowledge: String

func _ready():
	$Sprite2D.texture = icon
