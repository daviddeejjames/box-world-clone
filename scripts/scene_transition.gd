extends CanvasLayer

signal on_transistion_finished

const FADE_TO_COLOUR = "fade_to_colour"
const FADE_TO_NORMAL = "fade_to_normal"

@onready var block = $BlockColour
@onready var fade = $Fade

func _ready():
	block.visible = false
	fade.animation_finished.connect(_on_fade_animation_finished)
	
func _on_fade_animation_finished(anim_name):
	if anim_name == FADE_TO_COLOUR:
		on_transistion_finished.emit()
		fade.play(FADE_TO_NORMAL)
	elif anim_name == FADE_TO_NORMAL:
		block.visible = false

func transition():
	block.visible = true
	fade.play(FADE_TO_COLOUR)


