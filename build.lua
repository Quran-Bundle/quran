module = "quran"

sourcefiledir = "tex"
sourcefiles   = {"quran.sty", "*.def", "*.lua", "quran.png"}
installfiles  = {"*.sty", "*.def", "*.lua", "quran.png"}

-- quran.sty needs ifxetex/biditools
checkengines = {"xetex"}
stdengine    = "xetex"
checkruns    = 1
