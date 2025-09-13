-- Open iTerm2 in current Finder folder
tell application "Finder"
	try
		if (count of Finder windows) > 0 then
			set theFolder to (target of front window) as alias
		else
			set theFolder to (path to desktop folder) as alias
		end if
	on error
		set theFolder to (path to desktop folder) as alias
	end try
	set thePOSIXPath to POSIX path of theFolder
end tell

tell application "iTerm"
	activate
	try
		set newWindow to (create window with default profile)
	on error
		set newWindow to (create tab with default profile of current window)
	end try
	tell current session of newWindow
		-- Change directory silently without showing the cd command
		write text "cd " & quoted form of thePOSIXPath & " ; clear"
	end tell
end tell
