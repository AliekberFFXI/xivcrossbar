#!/usr/bin/env python

import evdev
import struct
import os
import sys
import time
import subprocess

from evdev import ecodes

GAMEPAD_NAME = "Microsoft X-Box 360 pad"
TRIGGER_THRESHOLD = 70

FFXI_PROCESS_ID = sys.argv[1]

def getNamedProcess(name):
	try:
		return str(int(subprocess.check_output(["xdotool", "search", "--name", name])))
	except:
		return 1

def trySwitchWindow(name, nextWindowId):
	global FFXI_PROCESS_ID
	try:
		subprocess.run(["xdotool", "windowactivate", nextWindowId])
		FFXI_PROCESS_ID = nextWindowId
		return True
	except:
		print("Exception while trying to switch to ", name, " window.")
		return False


def switchCharacters():
	global FFXI_PROCESS_ID
	nextWindowId = getNamedProcess("Windower")
	if nextWindowId != 1 and nextWindowId != FFXI_PROCESS_ID:
		if trySwitchWindow("Windower", nextWindowId):
			return
	nextWindowId = getNamedProcess("PlayOnline Viewer")
	if nextWindowId != 1 and nextWindowId != FFXI_PROCESS_ID:
		if trySwitchWindow("PlayOnline Viewer", nextWindowId):
			return
	nextWindowId = getNamedProcess("Final Fantasy XI")
	if nextWindowId != 1 and nextWindowId != FFXI_PROCESS_ID:
		if trySwitchWindow("Final Fantasy XI", nextWindowId):
			return
	nextWindowId = getNamedProcess("YourCharacterNameHere")
	if nextWindowId != 1 and nextWindowId != FFXI_PROCESS_ID:
		if trySwitchWindow("YourCharacterNameHere", nextWindowId):
			return
	nextWindowId = getNamedProcess("Your2BoxCharacterNameHere")
	if nextWindowId != 1 and nextWindowId != FFXI_PROCESS_ID:
		if trySwitchWindow("Your2BoxCharacterNameHere", nextWindowId):
			return

devices = [evdev.InputDevice(path) for path in evdev.list_devices()]
for device in devices:
	if GAMEPAD_NAME in device.name:
		GAMEPAD_PATH = device.path

device = evdev.InputDevice(GAMEPAD_PATH)

isLeftTriggerDown = False
isRightTriggerDown = False
isStartDown = False
isCtrlDown = False
isDpadUpDown = False
isDpadDownDown = False
isDpadLeftDown = False
isDpadRightDown = False

southKey = "Return"
westKey = "KP_Subtract"
eastKey = "Escape"
northKey = "KP_Add"
dpadUpKey = "F1"
dpadRightKey = "F2"
dpadDownKey = "F3"
dpadLeftKey = "F4"
selectKey = "F9"
startKey = "F10"

def sendKeyDown(keycode):
	subprocess.call(["xdotool", "keydown", "--window", FFXI_PROCESS_ID, keycode])

def sendKeyUp(keycode):
	subprocess.call(["xdotool", "keyup", "--window", FFXI_PROCESS_ID, keycode])

for event in device.read_loop():
	if event.type == ecodes.EV_ABS:
		if event.code == ecodes.ABS_Z:
			if event.value < TRIGGER_THRESHOLD:
				if isLeftTriggerDown:
					isLeftTriggerDown = False
					sendKeyUp("F11")
			else:
				if not isLeftTriggerDown:
					isLeftTriggerDown = True
					if not isCtrlDown:
						isCtrlDown = True
						sendKeyDown("Control_L")
					sendKeyDown("F11")

		if event.code == ecodes.ABS_RZ:
			if event.value < TRIGGER_THRESHOLD:
				if isRightTriggerDown:
					isRightTriggerDown = False
					sendKeyUp("F12")
			else:
				if not isRightTriggerDown:
					isRightTriggerDown = True
					if not isCtrlDown:
						isCtrlDown = True
						sendKeyDown("Control_L")
					sendKeyDown("F12")

		if isCtrlDown and not (isLeftTriggerDown or isRightTriggerDown):
			isCtrlDown = False
			sendKeyUp("Control_L")

		if isLeftTriggerDown or isRightTriggerDown:
			southKey = "F5"
			westKey = "F6"
			eastKey = "F7"
			northKey = "F8"
		else:
			southKey = "Return"
			westKey = "KP_Subtract"
			eastKey = "Escape"
			northKey = "KP_Add"

		if isLeftTriggerDown or isRightTriggerDown or isStartDown:
			if event.code == ecodes.ABS_HAT0X:
				if event.value == 1:
					if not isDpadRightDown:
						sendKeyDown(dpadRightKey)
					isDpadRightDown = True
					isDpadLeftDown = False
					if isDpadLeftDown:
						sendKeyUp(dpadLeftKey)
					if isDpadUpDown:
						sendKeyUp(dpadUpKey)
					if isDpadLeftDown:
						sendKeyUp(dpadDownKey)
				elif event.value == -1:
					if not isDpadLeftDown:
						sendKeyDown(dpadLeftKey)
					isDpadLeftDown = True
					isDpadRightDown = False
					if isDpadRightDown:
						sendKeyUp(dpadRightKey)
					if isDpadUpDown:
						sendKeyUp(dpadUpKey)
					if isDpadDownDown:
						sendKeyUp(dpadDownKey)
				else:
					if isDpadRightDown:
						sendKeyUp(dpadRightKey)
					if isDpadLeftDown:
						sendKeyUp(dpadLeftKey)
					isDpadRightDown = False
					isDpadLeftDown = False

			if event.code == ecodes.ABS_HAT0Y:
				if event.value == 1:
					if not isDpadDownDown:
						sendKeyDown(dpadDownKey)
					isDpadDownDown = True
					isDpadUpDown = False
					if isDpadLeftDown:
						sendKeyUp(dpadLeftKey)
					if isDpadUpDown:
						sendKeyUp(dpadUpKey)
					if isDpadRightDown:
						sendKeyUp(dpadRightKey)
				elif event.value == -1:
					if not isDpadUpDown:
						sendKeyDown(dpadUpKey)
					isDpadUpDown = True
					isDpadDownDown = False
					if isDpadLeftDown:
						sendKeyUp(dpadLeftKey)
					if isDpadRightDown:
						sendKeyUp(dpadRightKey)
					if isDpadLeftDown:
						sendKeyUp(dpadDownKey)
				else:
					if isDpadDownDown:
						sendKeyUp(dpadDownKey)
					if isDpadUpDown:
						sendKeyUp(dpadUpKey)
					isDpadDownDown = False
					isDpadUpDown = False

	if event.type == ecodes.EV_KEY:
		# For some reason, BTN_NORTH and BTN_WEST are switched on Steam Decks
		if event.code == ecodes.BTN_NORTH:
			if event.value == 1:
				sendKeyDown(westKey)
			else:
				sendKeyUp(westKey)
		if event.code == ecodes.BTN_SOUTH:
			if event.value == 1:
				sendKeyDown(southKey)
			else:
				sendKeyUp(southKey)
		if event.code == ecodes.BTN_EAST:
			if event.value == 1:
				sendKeyDown(eastKey)
			else:
				sendKeyUp(eastKey)
		# For some reason, BTN_NORTH and BTN_WEST are switched on Steam Decks
		if event.code == ecodes.BTN_WEST:
			if event.value == 1:
				sendKeyDown(northKey)
			else:
				sendKeyUp(northKey)

		if event.code == ecodes.BTN_START:
			isStartDown = event.value == 1
			if event.value == 1:
				sendKeyDown("Control_L")
				sendKeyDown(startKey)
			else:
				sendKeyUp(startKey)
				sendKeyUp("Control_L")
		if event.code == ecodes.BTN_SELECT:
			if event.value == 1:
				sendKeyDown("Control_L")
				sendKeyDown(selectKey)
			else:
				sendKeyUp(selectKey)
				sendKeyUp("Control_L")

		# Swaps characters when hitting the right bumper (only necessary for 2boxers)
		if event.code == ecodes.BTN_TR and event.value == 1:
			sendKeyUp("Control_L")
			switchCharacters()
			sendKeyDown("Alt_L")
			sendKeyUp("Alt_L")
