set windowWidth to 800
set windowHeight to 600
delay 0.1

set AppleScript's text item delimiters to "x"

set res to "1680x960"
# set res to text returned of (display dialog "Enter the width x height:" default answer ((windowWidth & windowHeight) as text))

# if res is "" then
#   display dialog "You need to enter a correct response"
#   return
# end if
set {windowWidth, windowHeight} to text items of res

set AppleScript's text item delimiters to ""

tell application "Safari"
	set screen_width to (do JavaScript "screen.availWidth" in document 1)
	set screen_height to (do JavaScript "screen.availHeight" in document 1)
end tell

tell application "System Events"
	set myFrontMost to name of first item of (processes whose frontmost is true)
end tell

tell application "Finder"
	set {desktopTop, desktopLeft, desktopRight, desktopBottom} to bounds of desktop
end tell

try
	tell application "System Events"
		tell process myFrontMost
			set {{w, h}} to size of drawer of window 1
		end tell
	end tell
on error
	set {w, h} to {0, 0}
end try

try
	get isToggle
on error
	set isToggle to 1
end try

tell application "System Events"
	tell process myFrontMost
		try
			set {{w, h}} to size of drawer of window 1
		on error
			set {w, h} to {0, 0}
		end try
		if isToggle is 0.5 then
			set isToggle to 1
			set position of window 1 to {(0), ((screen_height - windowHeight) / 2.0) - desktopTop}
			set size of window 1 to {1680, windowHeight}
		else if isToggle is 1 then
			set isToggle to 0.5
			set position of window 1 to {((screen_width - 1024) * isToggle), ((screen_height - windowHeight) / 2.0) - desktopTop}			
			set size of window 1 to {1024, windowHeight}
		end if
	end tell
end tell