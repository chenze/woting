tell application "System Events"
    if ((get name of the processes) does not contain "iTunes") then
        return {}
    end if
end tell
tell application "iTunes"
	set current_track to {} 
	if player state is playing then
		set the_name to the name of the current track
		set the_artist to the artist of the current track
		set the_album to the album of the current track
		set the_genre to the genre of the current track
		set the_played to the time of the current track
		set current_track to {the_name,the_artist,the_album,the_genre,the_played}
	end if
	return current_track
end tell
