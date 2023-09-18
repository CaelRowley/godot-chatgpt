extends Node

signal on_player_talk
signal on_npc_talk(message)

const CONFIG_FILE := "res://config.cfg"

var api_key: String
var url := "https://api.openai.com/v1/chat/completions"
var temperature := 0.5
var max_tokens := 1024
var headers: Array[String]
var model := "gpt-3.5-turbo"
var messages := []
var request: HTTPRequest

@onready var dialogue_box = get_node("/root/Main/CanvasLayer/DialogueBox")
var current_npc
@export_multiline var dialogue_rules: String


func _ready():
	var config: ConfigFile = ConfigFile.new()
	config.load(CONFIG_FILE)
	api_key = config.get_value("Secrets", "OpenAIAPIKey")
	headers = ["Content-type: application/json", "Authorization: Bearer " + api_key]

	request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", _on_request_completed)


func dialogue_request(player_dialogue):
	var prompt = player_dialogue

	if messages.size() == 0:
		var header_prompt = "Act as a " + current_npc.physical_description + " in a fantasy RPG. "
		header_prompt += "As a character, you are " + current_npc.personality + ". "
		header_prompt += "Your location is  " + current_npc.location_description + ". "
		header_prompt += "You have secret knowledge that you won't speak about unless asked by me: " + current_npc.secret_knowledge + ". "
		prompt = dialogue_rules + "\n" + header_prompt

	messages.append({"role": "user", "content": prompt})
	on_player_talk.emit()

	var body = JSON.stringify({"messages": messages, "temperature": temperature, "max_tokens": max_tokens, "model": model})

	var send_request = request.request(url, headers, HTTPClient.METHOD_POST, body)

	if send_request != OK:
		print("There was an error!")


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	var message = response["choices"][0]["message"]["content"]

	messages.append({
		"role": "system",
		"content": message
	})

	on_npc_talk.emit(message)


func enter_dialogue(npc):
	current_npc = npc
	messages = []
	dialogue_box.visible = true
	dialogue_box.init_with_npc(npc)
	dialogue_request("")


func exit_dialogue():
	current_npc = null
	messages = []
	dialogue_box.visible = false


func is_dialogue_active():
	return dialogue_box.visible


func _on_talk_button_pressed():
	pass # Replace with function body.
