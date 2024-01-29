extends Node

#-------------------------------------------------------------------------------
# VARIABLES
var last_pitch = 1.0 # Stores the last pitch so the same pitch doesn't play in a row
var location
var volume = -20.0

# PARAMETERS
var _dict = {
	"location" : location,
	"volume" : volume,
	"randomPitch" : {"pitch1": 0, "pitch2": 0}
}

#-------------------------------------------------------------------------------
# MUSIC AUDIO FILES
var musicloop = load("res://Audio/Music/Music.ogg")

# SFX AUDIO FILES
var laugh = load("res://Audio/Sounds/laugh.ogg")
var squelch = load("res://Audio/Sounds/squelch.ogg")
var yelp = load("res://Audio/Sounds/yelp.ogg")

#-------------------------------------------------------------------------------
# Calling this function triggers the appropriate musc file to be played.
func play_music(music, mVolume = -30):
	$music_player.stream = music
	$music_player.volume_db = mVolume
	$music_player.play()

# Calling this function stops all music.
func stop_music(_music):
	$music_player.stop()

#-------------------------------------------------------------------------------
# Calling this function triggers the appropriate audio clip to be played with any
# of the following specified parameters: 
#   clip = sfx variable name (the sound effect to be played)
#   location = global_transform.origin (the sfx position spatially)
#   randomPitch: true = randomise current sfx pitch, false = don't randomise pitch.
#   randomPitchRange1 = random pitch range FROM (replace with null if pitch = false)
#   randomPitchRange2 = random pitch range TO (replace with null if pitch = false)
func play_sfx(clip, params = null):
	var n = $sfx_player.get_child_count()
	
	for i in range(n):
		var child = $sfx_player.get_child(i)
		if !child.playing:
			child.volume_db = 0
			child.pitch_scale = 1.0 # Resets pitch of current child to default
			child.stream = clip # Sets the stream to the desired sfx clip
			child.volume_db = volume
			
			
			child.play() # Play sfx
			return

#-------------------------------------------------------------------------------
