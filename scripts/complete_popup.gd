extends PanelContainer

@onready var fade = $FadeIn
const FADE_IN = "fade_in"
const RESET = "RESET"

func transition():
	fade.play(FADE_IN)

func reset():
	fade.play(RESET)
