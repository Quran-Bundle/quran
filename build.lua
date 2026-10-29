module = "quran"

sourcefiledir = "tex"
sourcefiles   = {"quran.sty", "quran-*.def"}
installfiles  = {"*.sty", "*.def"}

-- quran.sty needs ifxetex/biditools
checkengines = {"xetex"}
stdengine    = "xetex"
checkruns    = 1
