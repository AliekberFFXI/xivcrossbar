local res = require 'resources'
local kebab_casify = require('libs/kebab_casify')
local files = require('files')
local ordered_pairs = require('libs/ordered_pairs')

-- SPELLS --

local SPELL_CATEGORY_LOOKUP = {
    ['BardSong'] = 'songs',
    ['BlackMagic'] = 'black magic',
    ['BlueMagic'] = 'blue magic',
    ['WhiteMagic'] = 'white magic',
    ['SummonerPact'] = 'summoning magic',
    ['Ninjutsu'] = 'ninjutsu',
    ['Geomancy'] = 'geomancy',
    ['Trust'] = 'trust',
}

local spells_by_name = {}

for id, spell in ipairs(res.spells) do
    local key = kebab_casify(spell.en)
    local skill = res.skills[spell.skill].en
    local recast_id = spell.recast_id
    local category = SPELL_CATEGORY_LOOKUP[spell.type]

    local default_icon = '/images/icons/spells/' .. (string.format("%05d", recast_id)) .. '.png'
    local custom_icon = kebab_casify(category) .. '/' ..  key .. '.png'

    spells_by_name[key] = string.format('["%s"] = { id = %d, en = "%s", res_key = "spells", type = "ma", skill = "%s", recast_id = %d, category = "%s", default_icon = "%s", custom_icon = "%s" }', key, id, spell.en, skill, recast_id, category, default_icon, custom_icon)
end

local spells_dot_lua = files.new('resources/crossbar_spells.lua', true)
if (not files.exists(spells_dot_lua)) then
    files.create(spells_dot_lua)
end

local content = '-- Automatically generated file: Crossbar Abilities\n\nreturn {\n'
for key, value in ordered_pairs(spells_by_name) do
    content = content .. '    ' .. value .. ',\n'
end
content = content .. '}\n'

files.write(spells_dot_lua, content, true)

-- JOB ABILITIES AND WEAPONSKILLS --

local JOB_ABILITY_CATEGORY_LOOKUP = {
    ['BloodPactRage'] = 'blood-pacts/rage',
    ['BloodPactWard'] = 'blood-pacts/ward',
    ['CorsairRoll'] = 'phantom-rolls',
    ['CorsairShot'] = 'quick-draw',
    ['Effusion'] = 'effusions',
    ['Flourish1'] = 'dances',
    ['Flourish2'] = 'dances',
    ['Flourish3'] = 'dances',
    ['Jig'] = 'dances',
    ['JobAbility'] = 'abilities',
    ['Ability'] = 'abilities',
    ['Monster'] = 'ready',
    ['Rune'] = 'rune-enchantments',
    ['Samba'] = 'dances',
    ['Scholar'] = 'stratagems',
    ['Step'] = 'dances',
    ['Waltz'] = 'dances',
    ['Ward'] = 'wards',
    ['PetCommand'] = 'pet-commands',
}

local JOB_ABILITY_TYPE_LOOKUP = {
    ['BloodPactRage'] = 'pet',
    ['BloodPactWard'] = 'pet',
    ['CorsairRoll'] = 'ja',
    ['CorsairShot'] = 'ja',
    ['Effusion'] = 'ja',
    ['Flourish1'] = 'ja',
    ['Flourish2'] = 'ja',
    ['Flourish3'] = 'ja',
    ['Jig'] = 'ja',
    ['JobAbility'] = 'ja',
    ['Ability'] = 'ja',
    ['Monster'] = 'ja',
    ['Rune'] = 'ja',
    ['Samba'] = 'ja',
    ['Scholar'] = 'ja',
    ['Step'] = 'ja',
    ['Waltz'] = 'ja',
    ['Ward'] = 'ja',
    ['PetCommand'] = 'pet',
}

local SP_ABILITY_TO_JOB_ID_LOOKUP = {
    ['Mighty Strikes'] = 1,
    ['Hundred Fists'] = 2,
    ['Benediction'] = 3,
    ['Manafont'] = 4,
    ['Chainspell'] = 5,
    ['Perfect Dodge'] = 6,
    ['Invincible'] = 7,
    ['Blood Weapon'] = 8,
    ['Familiar'] = 9,
    ['Soul Voice'] = 10,
    ['Eagle Eye Shot'] = 11,
    ['Meikyo Shisui'] = 12,
    ['Mijin Gakure'] = 13,
    ['Spirit Surge'] = 14,
    ['Astral Flow'] = 15,
    ['Azure Lore'] = 16,
    ['Wild Card'] = 17,
    ['Overdrive'] = 18,
    ['Trance'] = 19,
    ['Tabula Rasa'] = 20,
    ['Bolster'] = 21,
    ['Elemental Sforzo'] = 22,
    ['Brazen Rush'] = 1,
    ['Inner Strength'] = 2,
    ['Asylum'] = 3,
    ['Subtle Sorcery'] = 4,
    ['Stymie'] = 5,
    ['Larceny'] = 6,
    ['Intervene'] = 7,
    ['Soul Enslavement'] = 8,
    ['Unleash'] = 9,
    ['Clarion Call'] = 10,
    ['Overkill'] = 11,
    ['Yaegasumi'] = 12,
    ['Mikage'] = 13,
    ['Fly High'] = 14,
    ['Astral Conduit'] = 15,
    ['Unbridled Wisdom'] = 16,
    ['Cutting Cards'] = 17,
    ['Heady Artifice'] = 18,
    ['Grand Pas'] = 19,
    ['Caper Emissarius'] = 20,
    ['Widened Compass'] = 21,
    ['Odyllic Subterfuge'] = 22,
}

local LV_1_SP_ABILITY_RECAST_ID = 0
local LV_96_SP_ABILITY_RECAST_ID = 254

local abilities_by_name = {}

for id, ability in pairs(res.job_abilities) do
    local key = kebab_casify(ability.en)
    local recast_id = ability.recast_id
    local ja_type = JOB_ABILITY_TYPE_LOOKUP[ability.type]
    local category = JOB_ABILITY_CATEGORY_LOOKUP[ability.type]

    local default_icon = nil
    if (ja_type ~= 'pet' and (recast_id == LV_1_SP_ABILITY_RECAST_ID or recast_id == LV_96_SP_ABILITY_RECAST_ID)) then
        default_icon = 'icons/abilities/' .. string.format("%05d", recast_id) .. '.' .. string.format("%02d", SP_ABILITY_TO_JOB_ID_LOOKUP[ability.en]) .. '.png'
    else    
        default_icon = 'icons/abilities/' .. string.format("%05d", recast_id) .. '.png'
    end
    local custom_icon = kebab_casify(category) .. '/' ..  key .. '.png'

    abilities_by_name[key] = string.format('["%s"] = { id = %d, en = "%s", res_key = "job_abilities", type = "%s", recast_id = %d, category = "%s", default_icon = "%s", custom_icon = "%s" }', key, id, ability.en, ja_type, recast_id, category, default_icon, custom_icon)
end

for id, ws in pairs(res.weapon_skills) do
    if (ws.skill ~= nil) then
        local key = kebab_casify(ws.en)
        local category = kebab_casify(res.skills[ws.skill].en)

        local custom_icon = kebab_casify(category) .. '/' ..  key .. '.png'
        local default_icon = '/images/icons/weapons/' .. category .. '.png'

        abilities_by_name[key] = string.format('["%s"] = { id = %d, en = "%s", res_key = "weapon_skills", type = "ws", category = "%s", default_icon = "%s", custom_icon = "%s" }', key, id, ws.en, category, default_icon, custom_icon)
    end
end

local abilities_dot_lua = files.new('resources/crossbar_abilities.lua', true)
if (not files.exists(abilities_dot_lua)) then
    files.create(abilities_dot_lua)
end

local content = '-- Automatically generated file: Crossbar Abilities\n\nreturn {\n'
for key, value in ordered_pairs(abilities_by_name) do
    content = content .. '    ' .. value .. ',\n'
end
content = content .. '}\n'

files.write(abilities_dot_lua, content, true)
