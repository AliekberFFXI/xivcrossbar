--[[    BSD License Disclaimer
        Copyright © 2022, Aliekber
        All rights reserved.

        Redistribution and use in source and binary forms, with or without
        modification, are permitted provided that the following conditions are met:

            * Redistributions of source code must retain the above copyright
              notice, this list of conditions and the following disclaimer.
            * Redistributions in binary form must reproduce the above copyright
              notice, this list of conditions and the following disclaimer in the
              documentation and/or other materials provided with the distribution.
            * Neither the name of xivcrossbar nor the
              names of its contributors may be used to endorse or promote products
              derived from this software without specific prior written permission.

        THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
        ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
        WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
        DISCLAIMED. IN NO EVENT SHALL ALIEKBER BE LIABLE FOR ANY
        DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
        (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
        LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
        ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
        (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
        SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

local gamepad_converter = {}

function gamepad_converter:setup(button_layout)
    self.button_layout = button_layout
end

local TRIGGERS_TO_CROSSBAR = {
    ['L'] = 1,
    ['LEFT'] = 1,
    ['LEFTTRIGGER'] = 1,
    ['R'] = 2,
    ['RIGHT'] = 2,
    ['RIGHTTRIGGER'] = 2,
    ['RL'] = 3,
    ['RIGHTLEFT'] = 3,
    ['RIGHTLEFTTRIGGER'] = 3,
    ['LR'] = 4,
    ['LEFTRIGHT'] = 4,
    ['LEFTRIGHTTRIGGER'] = 4,
    ['LL'] = 5,
    ['LEFTLEFT'] = 5,
    ['LEFTLEFTTRIGGER'] = 5,
    ['LR'] = 6,
    ['LEFTRIGHT'] = 6,
    ['LEFTRIGHTTRIGGER'] = 6
}

function gamepad_converter:convert_to_crossbar(triggers)
    local triggers_as_number = tonumber(triggers)
    if (triggers_as_number ~= nil) then
        return triggers_as_number
    end

    return TRIGGERS_TO_CROSSBAR[triggers:upper()]
end

local NINTENDO_BUTTON_TO_PLACEMENT = {
    ['A']               = 'CIRCLE',
    ['ABUTTON']         = 'CIRCLE',
    ['B']               = 'CROSS',
    ['BBUTTON']         = 'CROSS',
    ['X']               = 'TRIANGLE',
    ['XBUTTON']         = 'TRIANGLE',
    ['Y']               = 'SQUARE',
    ['YBUTTON']         = 'SQUARE',
    ['UP']              = 'DPADUP',
    ['UPBUTTON']        = 'DPADUP',
    ['DUP']             = 'DPADUP',
    ['DUPBUTTON']       = 'DPADUP',
    ['DPADUP']          = 'DPADUP',
    ['DPADUPBUTTON']    = 'DPADUP',
    ['DOWN']            = 'DPADDOWN',
    ['DOWNBUTTON']      = 'DPADDOWN',
    ['DDOWN']           = 'DPADDOWN',
    ['DDOWNBUTTON']     = 'DPADDOWN',
    ['DPADDOWN']        = 'DPADDOWN',
    ['DPADDOWNBUTTON']  = 'DPADDOWN',
    ['LEFT']            = 'DPADLEFT',
    ['LEFTBUTTON']      = 'DPADLEFT',
    ['DLEFT']           = 'DPADLEFT',
    ['DLEFTBUTTON']     = 'DPADLEFT',
    ['DPADLEFT']        = 'DPADLEFT',
    ['DPADLEFTBUTTON']  = 'DPADLEFT',
    ['RIGHT']           = 'DPADRIGHT',
    ['RIGHTBUTTON']     = 'DPADRIGHT',
    ['DRIGHT']          = 'DPADRIGHT',
    ['DRIGHTBUTTON']    = 'DPADRIGHT',
    ['DPADRIGHT']       = 'DPADRIGHT',
    ['DPADRIGHTBUTTON'] = 'DPADRIGHT'
}

local XBOX_BUTTON_TO_PLACEMENT = {
    ['A']               = 'CROSS',
    ['ABUTTON']         = 'CROSS',
    ['B']               = 'CIRCLE',
    ['BBUTTON']         = 'CIRCLE',
    ['X']               = 'SQUARE',
    ['XBUTTON']         = 'SQUARE',
    ['Y']               = 'TRIANGLE',
    ['YBUTTON']         = 'TRIANGLE',
    ['UP']              = 'DPADUP',
    ['UPBUTTON']        = 'DPADUP',
    ['DUP']             = 'DPADUP',
    ['DUPBUTTON']       = 'DPADUP',
    ['DPADUP']          = 'DPADUP',
    ['DPADUPBUTTON']    = 'DPADUP',
    ['DOWN']            = 'DPADDOWN',
    ['DOWNBUTTON']      = 'DPADDOWN',
    ['DDOWN']           = 'DPADDOWN',
    ['DDOWNBUTTON']     = 'DPADDOWN',
    ['DPADDOWN']        = 'DPADDOWN',
    ['DPADDOWNBUTTON']  = 'DPADDOWN',
    ['LEFT']            = 'DPADLEFT',
    ['LEFTBUTTON']      = 'DPADLEFT',
    ['DLEFT']           = 'DPADLEFT',
    ['DLEFTBUTTON']     = 'DPADLEFT',
    ['DPADLEFT']        = 'DPADLEFT',
    ['DPADLEFTBUTTON']  = 'DPADLEFT',
    ['RIGHT']           = 'DPADRIGHT',
    ['RIGHTBUTTON']     = 'DPADRIGHT',
    ['DRIGHT']          = 'DPADRIGHT',
    ['DRIGHTBUTTON']    = 'DPADRIGHT',
    ['DPADRIGHT']       = 'DPADRIGHT',
    ['DPADRIGHTBUTTON'] = 'DPADRIGHT'
}

local GAMECUBE_BUTTON_TO_PLACEMENT = {
    ['A']               = 'CROSS',
    ['ABUTTON']         = 'CROSS',
    ['B']               = 'SQUARE',
    ['BBUTTON']         = 'SQUARE',
    ['X']               = 'CIRCLE',
    ['XBUTTON']         = 'CIRCLE',
    ['Y']               = 'TRIANGLE',
    ['YBUTTON']         = 'TRIANGLE',
    ['UP']              = 'DPADUP',
    ['UPBUTTON']        = 'DPADUP',
    ['DUP']             = 'DPADUP',
    ['DUPBUTTON']       = 'DPADUP',
    ['DPADUP']          = 'DPADUP',
    ['DPADUPBUTTON']    = 'DPADUP',
    ['DOWN']            = 'DPADDOWN',
    ['DOWNBUTTON']      = 'DPADDOWN',
    ['DDOWN']           = 'DPADDOWN',
    ['DDOWNBUTTON']     = 'DPADDOWN',
    ['DPADDOWN']        = 'DPADDOWN',
    ['DPADDOWNBUTTON']  = 'DPADDOWN',
    ['LEFT']            = 'DPADLEFT',
    ['LEFTBUTTON']      = 'DPADLEFT',
    ['DLEFT']           = 'DPADLEFT',
    ['DLEFTBUTTON']     = 'DPADLEFT',
    ['DPADLEFT']        = 'DPADLEFT',
    ['DPADLEFTBUTTON']  = 'DPADLEFT',
    ['RIGHT']           = 'DPADRIGHT',
    ['RIGHTBUTTON']     = 'DPADRIGHT',
    ['DRIGHT']          = 'DPADRIGHT',
    ['DRIGHTBUTTON']    = 'DPADRIGHT',
    ['DPADRIGHT']       = 'DPADRIGHT',
    ['DPADRIGHTBUTTON'] = 'DPADRIGHT'
}

local PLAYSTATION_BUTTON_TO_PLACEMENT = {
    ['CROSS']           = 'CROSS',
    ['CROSSBUTTON']     = 'CROSS',
    ['SQUARE']          = 'SQUARE',
    ['SQUAREBUTTON']    = 'SQUARE',
    ['CIRCLE']          = 'CIRCLE',
    ['CIRCLEBUTTON']    = 'CIRCLE',
    ['TRIANGLE']        = 'TRIANGLE',
    ['TRIANGLEBUTTON']  = 'TRIANGLE',
    ['UP']              = 'DPADUP',
    ['UPBUTTON']        = 'DPADUP',
    ['DUP']             = 'DPADUP',
    ['DUPBUTTON']       = 'DPADUP',
    ['DPADUP']          = 'DPADUP',
    ['DPADUPBUTTON']    = 'DPADUP',
    ['DOWN']            = 'DPADDOWN',
    ['DOWNBUTTON']      = 'DPADDOWN',
    ['DDOWN']           = 'DPADDOWN',
    ['DDOWNBUTTON']     = 'DPADDOWN',
    ['DPADDOWN']        = 'DPADDOWN',
    ['DPADDOWNBUTTON']  = 'DPADDOWN',
    ['LEFT']            = 'DPADLEFT',
    ['LEFTBUTTON']      = 'DPADLEFT',
    ['DLEFT']           = 'DPADLEFT',
    ['DLEFTBUTTON']     = 'DPADLEFT',
    ['DPADLEFT']        = 'DPADLEFT',
    ['DPADLEFTBUTTON']  = 'DPADLEFT',
    ['RIGHT']           = 'DPADRIGHT',
    ['RIGHTBUTTON']     = 'DPADRIGHT',
    ['DRIGHT']          = 'DPADRIGHT',
    ['DRIGHTBUTTON']    = 'DPADRIGHT',
    ['DPADRIGHT']       = 'DPADRIGHT',
    ['DPADRIGHTBUTTON'] = 'DPADRIGHT'
}

local PLACEMENT_TO_SLOT = {
    ['CROSS']           = 6,
    ['SQUARE']          = 5,
    ['CIRCLE']          = 7,
    ['TRIANGLE']        = 8,
    ['DPADUP']          = 4,
    ['DPADDOWN']        = 2,
    ['DPADLEFT']        = 1,
    ['DPADRIGHT']       = 3
}

function gamepad_converter:convert_to_slot(button)
    local slot_as_number = tonumber(button)
    if (slot_as_number ~= nil) then
        return slot_as_number
    end

    local placement = nil
    if (self.button_layout == 'gamecube') then
        placement = GAMECUBE_BUTTON_TO_PLACEMENT[button:upper()]
    elseif (self.button_layout == 'playstation') then
        placement = PLAYSTATION_BUTTON_TO_PLACEMENT[button:upper()]
    elseif (self.button_layout == 'xbox') then
        placement = XBOX_BUTTON_TO_PLACEMENT[button:upper()]
    elseif (self.button_layout == 'nintendo') then
        placement = NINTENDO_BUTTON_TO_PLACEMENT[button:upper()]
    end

    if (placement == nil) then
        print('XIVCROSSBAR: Invalid arguments: ' .. button)
        return nil
    end

    return PLACEMENT_TO_SLOT[placement]
end

return gamepad_converter
