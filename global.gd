extends Node

#text system
enum languages {PORTUGUESE, ENGLISH}
var language_on
var text_system = "res://interface/text_system/text_system.json"
var buttons = "res://interface/text_system/buttons.json"

var player

var pop_label = preload("res://interface/pop_label.tscn")

#streams
var water_steps = preload("res://tileset/footstep_water_walk_01.wav")
var normal_steps = preload("res://player/footstep_wood_walk_01.wav")

