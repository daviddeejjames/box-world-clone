extends PanelContainer

const FADE_IN = "fade_in"
@onready var fade = $FadeIn

func transition():
	fade.play(FADE_IN)
