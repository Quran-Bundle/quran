%% Change Log
%% ver 2.42 ## March 12th, 2026
%% New option introduced, nobasmalah
%% ver 2.31 ## March 31st, 2025
%% Improved implementation of \qt@no to optimize space in Quran text.
%% ver 2.3 ## September 7th, 2024
%% Documentation update with quran-es release
%% ver 2.2 ## August 1st, 2023
%% Added support for old Anglicized names of Quran surahs
%% Retouchment of samples
%% ver 2.1 ## July 27st, 2023
%% Anglicized names of Quran surahs revised.
%% Fixes issue with droping \par in version 1.9.
%% ver 2.0 ## July 10th, 2023
%% In compliance with [Tanzil version 1.1](https://tanzil.net/updates/).
%% ver 1.9 ## June 28th, 2023
%% Use the `ornbraces` option and the \SetOrnamentalBraces command to customize the ornamental braces surrounding the Quran text.
%% ver 1.81 ## Feb. 2nd, 2021
%% Doc update for quran-bn
%% ver 1.8 ## Oct. 14th, 2020
%% uthmani option is replaced with uthmani-min and uthmani is now more decorated version of the Quran's text.
%% ver 1.63 ## March 14th, 2020
%% Removing pause marks with ⟨chunk range⟩ optional parameter
%% ver 1.62 ## March 12th, 2020
%% licence update from lppl1.3 to lppl1.3c
%% ver 1.61 ## March 9th, 2020
%% use current font in showitem instead of Amiri
%% ver 1.6 ## March 7th, 2020
%% support for getting any chunks of an Ayah with two extra optional arguments for \qurantext and \quranayah.
%% \Basmalah outputs basmalah without any surrounding whitespaces.
%% This feature has been suggested and supported financially by Atiyah Ahmad. May God bless him.
%% ver 1.51 ## May 4th, 2019
%% A typo in quran-transde.def.
%% ver 1.5 ## December 31th, 2018
%% some minor bugs in \ToggleBasmalah and \quransurah.
%% ver 1.42b ## November 29th, 2018
%% A typo in quran-transde.def.
%% ver 1.42a ## December 22nd, 2017
%% A typo in doc. Some of files were missed in the last update so the new version put them back.
%% ver 1.42 ## December 22nd, 2017
%% \quransurahX and \quranayahX macros also act case-insensitive with anglicized title of surahs. X is one of en, de, fa, and lt.
%% ver 1.41 ## December 22nd, 2017
%% in previous versions, \quransurah and \quranayah macros were case-sensitive in case of using surah names,
%% but by this version both macros are case-insensitive, i.e. there in no diffirences between Al-Fatihda, al-fatiha, al-Fatiha,
%% and the other possible combinations of lower-uppercase letters.
%% ver 1.4 ## October 28th, 2017
%% Persian, English, and Deutsch tranliteration added and ``fa", ``en", and ``de" version of macros defined for them.
%% for using this option, the `transfa`, `transen`, `transde` is defined. There is also a `trans` option that can get the
%% `'lt`, `en`, `de`, and `fa` as its value seperated by comma.
%% ver 1.3 ## October 22th, 2017
%% Transliteration support, now all macros have an ``lt" version for typesetting transliteration of the original macros.
%% ver 1.261 ## August 22th, 2017
%% typo in version number.
%% ver 1.26 ## August 22th, 2017
%% minor improvements, fixes a bug in using \quranayah[x][y] that in this case it hadn't enclosed in group + manual update.
%% ver 1.252 ## February 28th, 2017
%% minor improvements
%% ver 1.25 and 1.251## December 25th, 2016
%% manual update
%% ver 1.241 ## December 15th, 2016
%% some minor bugs in manual
%% ver 1.24 ## November 12th, 2016
%% manual update + waqf symbol wes missed the penultimate version of uthmani script.
%% ver 1.22 ## November 8th, 2016
%% just adding source of two pdf files to the installation.
%% ver 1.21 ## November 7th, 2016
%% some minor bugs in uploading to CTAN
%% ver 1.2  ## November 5th, 2016
%% Supports Uthmani script via uthmani option.
%% This option asked by one of the package's user.
%% ver 1.14  ## May 15th, 2016
%% Some improvements in help document.
%% ver 1.1  ## Apr 21st, 2016
%% \indexconvert macro converts a number between 1 to 6236 to its exact surah and ayah number in
%% the whole text of Quran.
%% ver 1.05  ## Feb 9th, 2016
%% \ChangeBasmalah and \ChangeAyahNumber are converted to \ToggleBasmalah and \ToggleAyahNumber respectively.
%% a minor bug in \quransurah* macro has fixed, this bug caused extra space in the text.
%% ver 1.0 ## Feb 5th, 2016
%% support for surahname as an argument in \quransurah and \quranayah macros.
%% ver 0.941 ## July 11th, 2015
%%  \qt@par moved to \qurantext from Ayat for minimizing sourcefile.
%% ver 0.94 ## July 11th, 2015
%%  \ChangeAyahNumber, \ChangeBasmalah can change the way ayah number and basmalah will appear.
%% a minor bug in extra white space around one ayah is solved now, it is founded by Masoud Yazdani.
%% ver 0.91 ## July 10th, 2015
%% default surah in \quransurah is now Al-Ikhlas
%% ver 0.9 ## July 7th, 2015
%% \quranhizb and \quranmanzil are provided now
%% ver 0.8 ## July 4th, 2015
%% \quranquarter and \quranruku are provided now
%% ver 0.72 ## July 2nd, 2015
%% \basmalah macro typeset basmalah
%% ver 0.71 ## July 2nd, 2015
%% in par mode after every basmalah a \par is set now
%% ver 0.7 ## Jun 30th, 2015
%% \quranpage command puts one or more pages of  Quran
%% ver 0.6 ## Jun 28th, 2015
%% \quranjuz command puts one or more  juzs of  Quran
%% ver 0.5 ## Jun 24, 2015
%% package renamed form qurantext to quran
%% \quranayah command can put a specific ayah/ayar from a surah.
%% ver 0.4
%% Sura's name add by \surahname command, it'll choose the arabic/latin name of  sura based on text direction.
%% ver 0.3
%% Ayat numbers added.
%% ver 0.2
%%  Stack overflow solved by a nonrecursive function
%% ver 0.1
%% initial commit

