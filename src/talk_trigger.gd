extends Area2D


@onready var game_manager = get_node("/root/Main/GameManager")
var current_npc


func _input(event):
	if event.is_action_pressed("ui_select") and !game_manager.is_dialogue_active():
		if current_npc != null:
			game_manager.enter_dialogue(current_npc)



func _on_body_exited(body:Node2D):
	if current_npc == body:
		current_npc = null
	game_manager.exit_dialogue()


func _on_body_entered(body:Node2D):
	if body.is_in_group("NPC"):
		current_npc = body
