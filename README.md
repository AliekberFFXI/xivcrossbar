Steps to get XIVCrossbar working:

1) Install Autohotkey (https://www.autohotkey.com/)

2) Run the Autohotkey script that corresponds to your controller type. You'll most likely need to run it as administrator, and you'll always need to have it running when using the crossbar, as it is what sends the button presses into Windower.
a) If you're using an Xbox controller of some kind, use ffxi_xinput.ahk
b) If you're using a DirectInput controller, use ffxi_directinput.ahk
c) If one of the scripts doesn't work, try the other
d) The default FFXI mapping for the four face buttons is:
    * Bottom face button (e.g. Cross on PS4) is Confirm
    * Left face button (e.g. Square on PS4) is Cancel
    * Right face button (e.g. Circle on PS4) is Active Window
    * Top face button (e.g. Triangle on PS4) is Main Menu
e) You can remap the face buttons however you like by modifying the ahk file that corresponds to your controller. Just search for the lines that say:
    * Gosub, SendMainMenuKey
    * Gosub, SendCancelKey
    * Gosub, SendConfirmKey
    * Gosub, SendActiveWindowKey
    And swap them with each other until it behaves the way you want. You'll have to reload the script each time you make changes.

3) Run FFXI Configuration tool and set up your gamepad to match ConfigureYourGamepadLikeThis.jpg. Green box = required to have set, Red box = required to leave blank, Yellow box = configure it the way you usually do.

4) Add the following to your Gearswap LUA for any jobs where you want to use the crossbar. If you already have these functions defined, simply add the "windower.send_command" line in each of them to the existing function.

    function user_setup()
        windower.send_command('lua load xivcrossbar')
    end

    function user_unload()
        windower.send_command('lua unload xivcrossbar')
    end

    function job_setup()
        windower.send_command('lua reload xivcrossbar')
    end

5) Minus button (Nintendo), Share button (PS4) or Back button (XBox) brings up the gamepad binding utility, and can also exit out of it.

6) Plus button (Nintendo), Options button (PS4) or Start button (XBox) brings up binding set selector as long as it is held down, and you can switch between different binding sets by using your dpad.

7) Enjoy!

NOTE: The crossbar unbinds any existing bindings for Ctrl+F1 through Ctrl+F12 because it uses those buttons as proxies for the gamepad. Any Alt, Shift, or neutral bindings to F1-F12 will be unaffected. Ctrl is used for the bindings rather than Alt because Alt has a tendency to get "stuck" when Alt-Tabbing in and out, and can lead to accidental ability use.

NOTE: in order to capture dpad inputs without affecting the underlying game, you will need to hold down at least one of the triggers for XIVCrossbar to be able to use its input. This should really only be noticeable when navigating the gamepad binding utility.
