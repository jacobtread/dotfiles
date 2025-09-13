-- Open Zed editor in current Finder folder
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

-- Open Zed with the folder
do shell script "open -a Zed " & quoted form of thePOSIXPath
