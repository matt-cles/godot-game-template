# This script is used by a singleton node called "Events".
# The intended use for this script is to be used as an event-bus,
# preventing the need for 'bubbling' events up and down the node tree.

extends Node

# The following warning-ignore-all comment will prevent the event-bus
# singleton from throwing UNUSED_SIGNAL warnings for the signals below.
# Since the intended use of this singleton is to connect and emit the
# Availible signals from other scripts, the signals listed in this function
# will never be called from this function, so each signal below would throw
# the UNUSED_SIGNAL warning.

#warning-ignore-all:unused_signal

# All availible events go here:
# Note: It is not a requirement to follow the syntax used for the pre-existing
# events, however, when a project gets large it can be hard to remember the
# signal usage, so it is recommended to include comments about the signals.

# A simple demo signal with no expected parameters
signal demo_signal
# Usage: events.emit_signal("demo_signal")

# A simple demo signal with expected parameters
signal demo_signal_with_parameters
# Usage: events.emit_signal("demo_signal", value:int, name:string)

