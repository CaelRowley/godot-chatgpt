extends Panel


@onready var game_manager := get_node("/root/MAIN/GameManager")
@onready var dialogue_text: RichTextLabel = $DialogueText
@onready var npc_icon: TextureRect = $NPCIcon
@onready var talk_input: TextEdit = $PlayerTalkInput
@onready var talk_button: Button = $TalkButton
@onready var leave_button: Button = $LeaveButton


func _ready():
	pass # Replace with function body.
	
func init_with_npc(npc):
	dialogue_text.text = ""
	talk_button.disabled = true
		

func _on_player_talk():
	talk_input.text = ""
	dialogue_text.text = "Hmm..."
	talk_button.disabled = true


func _on_npc_talk(npc_dialogue):
	dialogue_text.text = npc_dialogue
	talk_button.disabled = false


func _on_leave_button_pressed():
	pass # Replace with function body.


func _on_talk_button_pressed():
	pass # Replace with function body.