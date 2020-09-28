local gamepad = {}

local face_buttons = {
  [59] = true,
  [60] = true,
  [65] = true,
  [66] = true,
  [67] = true,
  [68] = true
}

local dpad_button = {
  [61] = true,
  [62] = true,
  [63] = true,
  [64] = true
}

local minus = 59
local plus = 60
local dpad_up = 61
local dpad_right = 62
local dpad_down = 63
local dpad_left = 64
local button_a = 65
local button_b = 66
local button_x = 67
local button_y = 68
local left_trigger = 87
local right_trigger = 88

function gamepad.is_face_button_or_dpad(dik)
  return face_buttons[dik] ~= nil or dpad_button[dik] ~= nil
end

function gamepad.is_minus(dik)
  return dik == minus
end

function gamepad.is_plus(dik)
  return dik == plus
end

function gamepad.is_dpad_up(dik)
  return dik == dpad_up
end

function gamepad.is_dpad_right(dik)
  return dik == dpad_right
end

function gamepad.is_dpad_down(dik)
  return dik == dpad_down
end

function gamepad.is_dpad_left(dik)
  return dik == dpad_left
end

function gamepad.is_button_a(dik)
  return dik == button_a
end

function gamepad.is_button_b(dik)
  return dik == button_b
end

function gamepad.is_button_x(dik)
  return dik == button_x
end

function gamepad.is_button_y(dik)
  return dik == button_y
end

function gamepad.is_left_trigger(dik)
  return dik == left_trigger
end

function gamepad.is_right_trigger(dik)
  return dik == right_trigger
end

return gamepad