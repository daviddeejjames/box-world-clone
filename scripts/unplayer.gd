extends CharacterBody2D

func flip_player_sprite_h(flip: bool) -> void:
	$Sprite.flip_h = flip

func play_default_animation() -> void:
	$Sprite.set_animation('default')
