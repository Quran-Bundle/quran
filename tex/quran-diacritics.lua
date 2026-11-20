-- quran-diacritics.lua: colour the diacritics (harakat) of Arabic text.
-- Part of the quran package; loaded by quran.sty under LuaLaTeX only.
--
-- Copyright (c) 2015-2026 Javad Razavian <javadr@gmail.com>
-- This work may be distributed and/or modified under the conditions of the
-- LaTeX Project Public License, either version 1.3c of this license or (at
-- your option) any later version.
--
-- Text typeset while \SetDiacriticColor is active carries the attribute
-- qt@diacolor, whose value is a luacolor colour id. After shaping, every glyph
-- the font marks as a mark (fatha, kasra, damma, sukun, shadda, tanwin, small
-- alef, ... and the font's own substituted mark glyphs) gets that id in
-- luacolor's attribute; luacolor writes the colour at shipout. Base letters are
-- not touched, so an outer \color still applies to them.

local GLYPH = node.id("glyph")
local HLIST = node.id("hlist")
local VLIST = node.id("vlist")

local has_attribute = node.has_attribute
local set_attribute = node.set_attribute
local traverse      = node.traverse

local dia   = luatexbase.attributes["qt@diacolor"]
local color = oberdiek.luacolor.getattribute()

local function paint(head)
  -- fonts.hashes.marks comes from luaotfload's font loader (undocumented, but
  -- stable for many years): marks[fontid][char] is true for mark glyphs.
  local marks = fonts.hashes.marks
  for n in traverse(head) do
    local id = n.id
    if id == GLYPH then
      local c = has_attribute(n, dia)
      if c then
        local m = marks[n.font]
        if m and m[n.char] then set_attribute(n, color, c) end
      end
    elseif id == HLIST or id == VLIST then
      paint(n.head)
    end
  end
  return head
end

local enabled = false

-- Called by \SetDiacriticColor. Registering lazily keeps documents that never
-- use the feature free of the callbacks, and makes sure ours run after
-- luaotfload's shaping in hpack_filter (fontspec is loaded by then).
local function enable()
  if enabled then return end
  enabled = true
  luatexbase.add_to_callback("post_linebreak_filter", paint, "quran.diacritics")
  luatexbase.add_to_callback("hpack_filter", paint, "quran.diacritics")
end

quran_diacritics = { enable = enable, paint = paint }
return quran_diacritics
