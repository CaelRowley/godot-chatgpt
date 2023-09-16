extends Node

const CONFIG_FILE := "res://config.cfg"

var api_key: String
var url := "https://api.openai.com/v1/chat/completions"
var temperature := 0.5
var max_tokens := 1024
var headers: Array[String]
var model := "gpt-3.5-turbo"
var messages := []
var request: HTTPRequest


func _ready():
	var config: ConfigFile = ConfigFile.new()
	config.load(CONFIG_FILE)
	api_key = config.get_value("Secrets", "OpenAIAPIKey")
	headers = ["Content-type: application/json", "Authorization: Bearer " + api_key]

	request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", _on_request_completed)

	dialogue_request("describe a cowboy in 10 words")


func dialogue_request(player_dialogue):
	messages.append({
		"role": "user",
		"content": player_dialogue
	})

	var body = JSON.stringify({
		"messages": messages,
		"temperature": temperature,
		"max_tokens": max_tokens,
		"model": model
	})

	var send_request = request.request(url, headers, HTTPClient.METHOD_POST, body)

	if send_request != OK:
		print("There was an error!")


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	var message = response["choices"][0]["message"]["content"]

	print(message)
