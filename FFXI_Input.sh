#!/bin/bash

# Check if we're already piping input to FFXI
PIPE_ID=$(ps ax | grep FFXI_Input.py | grep python | grep -m 1 -Eo '[0-9]+' | head -1)

# Only start a new pipe if one doesn't already exist
if [ "$PIPE_ID" = "" ]
then
	echo "Starting input pipe..."
	# Get the current FFXI process id
	FFXI_PROCESS_ID=$(xdotool search --onlyvisible --class 'pol.exe' getwindowpid %@ | uniq | xargs -I{} xdotool search --all --pid {} --name 'Final Fantasy XI')

	# Start piping input to the FFXI process
	./FFXI_Input.py FFXI_PROCESS_ID
else
	echo "Input pipe already present: skipping."
fi
