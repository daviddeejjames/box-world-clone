extends AudioStreamPlayer

@export var music_volume: int
@export var sfx_volume: int

func update_music_volume(value: int) -> void:
	var music_bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(music_bus, value)

func update_sfx_volume(value: int) -> void:
	var sfx_bus = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(sfx_bus, value)
