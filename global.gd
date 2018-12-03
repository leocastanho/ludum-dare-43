extends Node

#text system
enum languages {PORTUGUESE, ENGLISH}
var language_on
var text_system = "res://interface/text_system/text_system.json"
var buttons = "res://interface/text_system/buttons.json"

var player
var player_scene = preload("res://player/Player.tscn")
var payer_spawn_position
var player_died = false
var passed_first_area_on_tuto = false

var pop_label = preload("res://interface/pop_label.tscn")

#streams paths
var water_steps = preload("res://tileset/footstep_water_walk_01.wav")
var normal_steps = preload("res://player/footstep_dirt_walk_run_01.wav")
var calling_monsters = preload("res://player/voices/voice_fun_character_cute_cartoon_06.wav")
var calling_key = preload("res://player/voices/voice_fun_character_cute_cartoon_18.wav")
var calling_door = preload("res://player/voices/voice_fun_character_cute_cartoon_20.wav")

#scenes paths
var main_menu = "res://main_menu/MainMenu.tscn"
var credits = "res://credits/Credits.tscn"
var tutorial = "res://levels/Tutorial.tscn"
var level1 = "res://levels/Level1.tscn"
var level2 = "res://levels/Level2.tscn"