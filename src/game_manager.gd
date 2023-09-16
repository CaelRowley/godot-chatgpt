extends Node

const CONFIG_FILE := "res://config.cfg"

var api_key := ""


func _ready():
	var config: ConfigFile = ConfigFile.new()
	config.load(CONFIG_FILE)
	api_key = config.get_value("Secrets", "OpenAIAPIKey")
