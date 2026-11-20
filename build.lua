module = "quran"

sourcefiledir = "tex"
sourcefiles   = {"quran.sty", "*.def", "*.lua"}
installfiles  = {"*.sty", "*.def", "*.lua"}

-- quran.sty needs ifxetex/biditools
checkengines = {"xetex"}
stdengine    = "xetex"
checkruns    = 1
