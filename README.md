# Information
A French translation of https://github.com/gb-mobile/pokecrystal-mobile-eng
This translation was performed via text dumps and a (somewhat) sophisticated find/replace script.
It is possible that some menus were missed by the find/replace script, and need translating manually.


## TO-DO

- Finalize the following strings:

GoldenrodPokecomCenterEggTicketText
GoldenrodPokecomCenterOddEggBriefingText
PokecomCenterAdminOfficeMobileScientist2Text
EZChatString_ExitPrompt
EZChatString_ExitConfirmation
EZChatString_MessageBattleStartSet
Text_ExitGymLeaderHonorRoll
Strings_8a483
_WantToRushThroughAMobileBattleText

- Hopefully update the Zip Code System.

## Setup [![Build Status][ci-badge]][ci]

For more information, please see [INSTALL.md](INSTALL.md)

After setup has been completed, you can choose which version you wish to build.
To build a specific version, run this command inside the repository directory in cygwin64:

`make`


Other languages are being worked on, but are not complete and still require a lot of polish.

## Using Mobile Adapter Features

To take advantage of the Mobile Adapter features, we currently recommend the GameBoy Emulator BGB:
https://bgb.bircd.org/

and libmobile-bgb:
https://github.com/REONTeam/libmobile-bgb/releases

Simply open BGB, right click the ‘screen’ and select `Link > Listen`, then accept the port it provides by clicking `OK`.
Once done, run the latest version of libmobile for your operating system (`mobile-windows.exe` or windows and `mobile-linux` for linux).
Now right click the ‘screen’ on BGB again and select `Load ROM…`, then choose the pokecrystal-mobile `.gbc` file you have built.

## Mobile Adapter Features

A full list of Mobile Adapter features for Pokémon Crystal can be found here:
https://github.com/gb-mobile/pokecrystal-mobile-en/wiki/Pok%C3%A9mon-Crystal-Mobile-Features

## Contributors

- Pret           : Initial disassembly
- Matze          : Mobile Restoration & Japanese Code Disassembly
- Engezerstorung : Mobile French Translation
- FrenchOrange   : Mobile French Translation
- Wit            : Mobile French Translation
- Damien         : Code
- DS             : GFX & Code
- Ryuzac         : Code & Japanese Translation
- qwilvove       : FR disassembly reference https://github.com/Guigui1993/pokecrystal-fr
- Guigui1993     : FR disassembly reference https://github.com/Guigui1993/pokecrystal-fr
- Zumilsawhat?   : Code (Large amounts of work on the EZ Chat system)
- REON Community : Support and Assistance

[ci]: https://github.com/pret/pokecrystal/actions
[ci-badge]: https://github.com/pret/pokecrystal/actions/workflows/main.yml/badge.svg
