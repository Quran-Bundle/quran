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

-- harfbuzz[fontid]: was the font loaded with Renderer=HarfBuzz? (cached per font)
local harfbuzz = setmetatable({}, { __index = function(t, fid)
  local fd = font.getfont(fid)
  local v = fd ~= nil and fd.hb ~= nil
  t[fid] = v
  return v
end })

local function is_mark(n)
  if harfbuzz[n.font] then
    -- HarfBuzz mode fills no mark table; there the marks (and the font's own
    -- substituted mark glyphs) are exactly the zero-advance glyphs.
    return n.width == 0
  end
  -- Node mode: fonts.hashes.marks comes from luaotfload's font loader
  -- (undocumented, but stable for many years); true for mark glyphs.
  local m = fonts.hashes.marks[n.font]
  return m and m[n.char]
end

local function paint(head)
  for n in traverse(head) do
    local id = n.id
    if id == GLYPH then
      local c = has_attribute(n, dia)
      if c and is_mark(n) then set_attribute(n, color, c) end
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
