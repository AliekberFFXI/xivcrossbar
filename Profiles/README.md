# DS4Windows Integration
	These are profiles to replace AutoHotKey with DS4Windows found at: https://github.com/Ryochan7/DS4Windows

# Setup
	1. Following the DS4Windows instructions, HidHide your physical controller
	2. In DS4Windows create a permanent XBOX360 controller in Output slot 1
	3. Import both the FFXI_DS4 and FFXI_DS4_ALT profiles for the controller type that you want to use 
	4. Assign the FFXI_DS4 profile to the physical controller
	5. Configure the game pad as described in the top-level Readme.md, with the exception being XInput must be enabled
	6. Edit the FFXI_DS4 profile and add a Special actoin 
		a. Name the special action 'FFXI_ALT_L'
		b. Select the action 'Load a Profile' and choose the profile FFXI_DS4_ALT
		c. Select 'Unload trigger on release'
		d. Select L2 as the trigger
		e. Click the save button under the checkbox
	7. Add another Special actoin 
		a. Name the special action 'FFXI_ALT_R'
		b. Select the action 'Load a Profile' and choose ALT profile FFXI_DS4_ALT
		c. Select 'Unload trigger on release'
		d. Select R2 as the trigger
		e. Click the save button under the checkbox
	8. Click save on the main profile
	
