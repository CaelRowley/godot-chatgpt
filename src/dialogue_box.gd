extends Panel


@onready var game_manager := get_node("/root/Main/GameManager")
@onready var dialogue_text: RichTextLabel = $DialogueText
@onready var npc_icon: TextureRect = $NPCIcon
@onready var talk_input: TextEdit = $PlayerTalkInput
@onready var talk_button: Button = $TalkButton
@onready var leave_button: Button = $LeaveButton


func _ready():
	game_manager.on_player_talk.connect(_on_player_talk)
	game_manager.on_npc_talk.connect(_on_npc_talk)

	
func init_with_npc(npc):
	npc_icon.texture = npc.icon
	dialogue_text.text = ""
	talk_button.disabled = true
		

func _on_player_talk():
	talk_input.text = ""
	dialogue_text.text = "Hmm..."
	talk_button.disabled = true


func _on_npc_talk(message):
	dialogue_text.text = message
	talk_button.disabled = false


func _on_talk_button_pressed():
	game_manager.dialogue_request(talk_input.text)


func _on_leave_button_pressed():
	game_manager.exit_dialogue()

