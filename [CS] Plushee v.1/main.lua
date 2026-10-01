-- name: [CS] Plushee
-- description: Original Character from VOKSMOTH \n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/wiki/API-Documentation

    Use this if you're curious on how anything here works >v<
	(This is an edited version of the Template File by Squishy)
]]

local globalModName = "Plushee"

-- Stops mod from loading if Character Select isn't on
if not _G.charSelectExists then
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
    return 0
end

local E_PLUSHEE_MODEL = smlua_model_util_get_id("plushee_geo") -- Located in "actors"

local TEX_PLUSHEE_LIFE_ICON = get_texture_info("plushee_life_icon") -- Located in "textures"

-- All Located in "sound" Name them whatever you want. Remember to include the .ogg extension
local VOICETABLE_PLUSHEE = {

    --[CHAR_SOUND_OKEY_DOKEY] = 'StartLevel.ogg', -- Starting game
	[CHAR_SOUND_LETS_A_GO] = 'plushee_startlvl.ogg', -- Starting level
	[CHAR_SOUND_PUNCH_YAH] = 'plushee_effort_1.ogg', -- Punch 1
	[CHAR_SOUND_PUNCH_WAH] = 'plushee_effort_2.ogg', -- Punch 2
	[CHAR_SOUND_PUNCH_HOO] = {'plushee_kick_1.ogg', 'plushee_kick_2.ogg', 'plushee_kick_3.ogg', 'plushee_kick_4.ogg', 'plushee_kick_5.ogg', 'plushee_kick_6.ogg'}, -- Punch 3
	[CHAR_SOUND_YAH_WAH_HOO] = {'plushee_effort_1.ogg', 'plushee_effort_2.ogg', 'plushee_effort_7.ogg'}, -- First/Second jump sounds
	[CHAR_SOUND_HOOHOO] = {'plushee_gremlin_1.ogg', 'plushee_gremlin_2.ogg'}, -- Third jump sound
	[CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'plushee_laugh_1.ogg', 'plushee_excite_2.ogg'}, -- Triple jump sounds
	[CHAR_SOUND_UH] = 'plushee_gremlin_3.ogg', -- Wall bonk
	[CHAR_SOUND_UH2] = 'Silent.ogg', -- Landing after long jump
	[CHAR_SOUND_UH2_2] = 'Silent.ogg', -- Same sound as UH2; jumping onto ledge
	[CHAR_SOUND_HAHA] = {'plushee_triplej_land.ogg', 'plushee_triplej_land_2.ogg'}, -- Landing triple jump
	[CHAR_SOUND_YAHOO] = {'plushee_excite_1.ogg', 'plushee_excite_2.ogg', 'plushee_excite_3.ogg'}, -- Long jump
	[CHAR_SOUND_DOH] = 'plushee_wall_bonk.ogg', -- Long jump wall bonk
	[CHAR_SOUND_WHOA] = 'plushee_gremlin_1.ogg', -- Grabbing ledge
	[CHAR_SOUND_EEUH] = 'plushee_ledgegrab.ogg', -- Climbing over ledge
	[CHAR_SOUND_WAAAOOOW] = 'plushee_falling.ogg', -- Falling a long distance
	[CHAR_SOUND_TWIRL_BOUNCE] = 'plushee_excite_1.ogg', -- Bouncing off of a flower spring
	[CHAR_SOUND_GROUND_POUND_WAH] = 'plushee_gremlin_1.ogg', 
	[CHAR_SOUND_HRMM] = 'plushee_effort_4', -- Lifting something
	[CHAR_SOUND_HERE_WE_GO] = 'plushee_laugh_2.ogg', -- Star get
	[CHAR_SOUND_SO_LONGA_BOWSER] = 'plushee_solongbowser.ogg', -- Throwing Bowser

--DAMAGE
	[CHAR_SOUND_ATTACKED] = 'plushee_damage.ogg', -- Damaged
	[CHAR_SOUND_PANTING] = 'plushee_panting.ogg', -- Low health
	[CHAR_SOUND_ON_FIRE] = {'plushee_burn.ogg', 'plushee_damage_alternate.ogg'}, -- Burned

--SLEEP SOUNDS
	[CHAR_SOUND_IMA_TIRED] = 'plushee_tired.ogg', -- Mario feeling tired
	[CHAR_SOUND_YAWNING] = 'plushee_yawn.ogg', -- Mario yawning before he sits down to sleep
	[CHAR_SOUND_SNORING1] = 'Silent.ogg', -- Snore Inhale
	[CHAR_SOUND_SNORING2] = 'plushee_snore_exhale.ogg', -- Exhale
	[CHAR_SOUND_SNORING3] = 'plushee_mumble.ogg', -- Sleep talking / mumbling

--COUGHING (USED IN THE GAS MAZE)
	[CHAR_SOUND_COUGHING1] = 'plushee_gremlin_1.ogg', -- Cough take 1
	[CHAR_SOUND_COUGHING2] = 'Silent.ogg', -- Cough take 2
	[CHAR_SOUND_COUGHING3] = 'Silent.ogg', -- Cough take 3

--DEATH
	[CHAR_SOUND_DYING] = 'plushee_mumble.ogg', -- Dying from damage
	[CHAR_SOUND_DROWNING] = 'plushee_drown.ogg', -- Running out of air underwater
	[CHAR_SOUND_MAMA_MIA] = 'plushee_level_boot.ogg' -- Booted out of level
}

-- All Located in "actors"
local CAPTABLE_PLUSHEE = {
    normal = smlua_model_util_get_id("plushee_cap_geo"),

}

local PALETTE_PLUSHEE = {
    [PANTS]  = "23005F",
    [SHIRT]  = "5A64FF",
    [GLOVES] = "CFCFFF",
    [SHOES]  = "23005F",
    [HAIR]   = "5A64FF",
    [SKIN]   = "BEA0FF",
    [CAP]    = "A0A0FF",
	[EMBLEM] = "FF53AB"
}

local HM_PLUSHEE= {
    label = {
        left = get_texture_info("plush_hp_meter_left"),
        right = get_texture_info("plush_hp_meter_right"),
    },
    pie = {
        [1] = get_texture_info("plushee_hp1"),
        [2] = get_texture_info("plushee_hp2"),
        [3] = get_texture_info("plushee_hp3"),
        [4] = get_texture_info("plushee_hp4"),
        [5] = get_texture_info("plushee_hp5"),
        [6] = get_texture_info("plushee_hp6"),
        [7] = get_texture_info("plushee_hp7"),
        [8] = get_texture_info("plushee_hp8"),
    }
}

local CSloaded = false
local function on_character_select_load()
    CT_PLUSHEE = _G.charSelect.character_add("Plushee",
	{"The cute little Vampir Doll!", "Here to eat the nightmares away!", "[+ Bowser Moveset!]" }, 
	"VOKSMOTH", "5A64FF", E_PLUSHEE_MODEL, CT_PLUSHEE, TEX_PLUSHEE_LIFE_ICON)
 
    _G.charSelect.character_add_voice(E_PLUSHEE_MODEL, VOICETABLE_PLUSHEE)
    _G.charSelect.character_add_palette_preset(E_PLUSHEE_MODEL, PALETTE_PLUSHEE)
	_G.charSelect.character_add_caps(E_PLUSHEE_MODEL, CAPTABLE_PLUSHEE)
	_G.charSelect.character_add_health_meter(CT_PLUSHEE, HM_PLUSHEE)
	
    CSloaded = true
end

local function on_character_sound(m, sound)
    if not CSloaded then return end
    if _G.charSelect.character_get_voice(m) == VOICETABLE_PLUSHEE then return _G.charSelect.voice.sound(m, sound) end
end

local function on_character_snore(m)
    if not CSloaded then return end
    if _G.charSelect.character_get_voice(m) == VOICETABLE_PLUSHEE then return _G.charSelect.voice.snore(m) end
end



---- BOWSER MOVESET:

if _G.bowsMoveset then
    -- Retrieves the custom shell model for this character. Check template_shell.blend for how to set up a shell model properly.
    local E_PLUSHEE_SHELL = smlua_model_util_get_id("plushee_shell_geo")

    -- This is a bitfield of flags that decide which parts of the Bowser Moveset this character will have.
    -- Insert each flag you want to be set, separated by '|' symbols.
    local BOWS_FLAGS_PLUSHEE =
        _G.bowsMoveset.FLAG_CAN_USE_SHELL

    -- Flag Options: (sorry the ids are so long pshgkjdf)

    -- _G.bowsMoveset.FLAG_CAN_USE_SHELL
    --- Allows the character to use the shell slide ability.

    -- _G.bowsMoveset.FLAG_CAN_USE_FIREBALL
    --- Allows the character to use the fire breath ability.

    -- _G.bowsMoveset.FLAG_STYLE_ANIMS
    --- Enables Bowser-unique animations for the character.

    -- _G.bowsMoveset.FLAG_SIZE_ANIMS
    --- Adjusts the character's pose in certain animations to suit bowser's large size. (i.e. ledge grab)

    -- _G.bowsMoveset.FLAG_LARGE_HITBOX
    --- Gives the character a larger hitbox size. (37 -> 85 units radius)
    --- This does not affect the hitbox size for level collision, only collisions with objects.

    -- _G.bowsMoveset.FLAG_NO_CAPLESS
    --- The character does not visually lose their 'cap'. Will also use their 'capless' head state in some animations.
    --- Used by Bowser to allow his jaw to open when breathing fire, etc.

    -- _G.bowsMoveset.FLAG_HEAVY_STEPS
    --- Enables heavier landing sound effects for the character.

    -- _G.bowsMoveset.FLAG_ATTACKS
    --- Enables the alternate sliding punch.

    -- _G.bowsMoveset.FLAG_ALL
    --- Shorthand to set all flags.


    -- This function sets up your custom shell model. Feel free to remove this if you aren't using a shell model.
    -- parameters: [your character model], [your shell model], [custom shell sound]
    _G.bowsMoveset.character_add_shell_model(E_PLUSHEE_MODEL, E_PLUSHEE_SHELL, 'plushee_shell.ogg')
    -- This function sets up the flags for your character.
    -- parameters: [your character model], [your flag bitfield]
    _G.bowsMoveset.character_set_bows_flags(E_PLUSHEE_MODEL, BOWS_FLAGS_PLUSHEE)
end
----

hook_event(HOOK_ON_MODS_LOADED, on_character_select_load)
hook_event(HOOK_CHARACTER_SOUND, on_character_sound)
hook_event(HOOK_MARIO_UPDATE, on_character_snore)
