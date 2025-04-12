# Information
A French translation of https://github.com/gb-mobile/pokecrystal-mobile-eng
This translation was performed via text dumps and a (somewhat) sophisticated find/replace script and some manual effort.

## Screenshots

![image](https://github.com/user-attachments/assets/bde26dd9-6e74-4ad6-8780-249b5925557a)
![image](https://github.com/user-attachments/assets/a8a720ae-8e46-41c0-8459-d311005a070b)
![image](https://github.com/user-attachments/assets/fa4b98d7-c56b-41ae-9d86-66a223dd8398)
![image](https://github.com/user-attachments/assets/db372ef0-f38e-4bf8-8b42-719c32603a43)
![image](https://github.com/user-attachments/assets/b7cc7848-d40c-429a-b55d-1051c558c48c)
![image](https://github.com/user-attachments/assets/c91d4ef5-897c-4ea8-801c-e7bb46cee588)
![image](https://github.com/user-attachments/assets/062b32b9-9cf3-4603-8cc1-c13064b4a101)
![image](https://github.com/user-attachments/assets/a8f55a27-1f6f-428a-b9f5-918e1d4e3347)
![image](https://github.com/user-attachments/assets/994e4f6f-6159-4b38-b46d-9481b73d3bb0)
![image](https://github.com/user-attachments/assets/15b63090-ef5d-4b0d-8e31-e363c8178fc5)
![image](https://github.com/user-attachments/assets/6aeca466-a593-4abe-ae32-4ce151e07b63)
![image](https://github.com/user-attachments/assets/06c0654b-bc3d-4232-9000-295dc5e694d2)
![image](https://github.com/user-attachments/assets/2abde9ae-f81a-4127-88ea-5ee12f8479bf)
![image](https://github.com/user-attachments/assets/7a66781d-de80-4fc9-a735-aed4cb8fba1a)
![image](https://github.com/user-attachments/assets/dba4da73-8a44-4b71-bb5d-b69d163a1275)




## Setup [![Build Status][ci-badge]][ci]

For more information, please see [INSTALL.md](INSTALL.md)

After setup has been completed, you can choose which version you wish to build.
To build a specific version, run this command inside the repository directory in cygwin64:

`make`


Other languages can be found here:

https://github.com/gb-mobile/pokecrystal-mobile-eng

https://github.com/gb-mobile/pokecrystal-mobile-ger

https://github.com/gb-mobile/pokecrystal-mobile-spa

https://github.com/gb-mobile/pokecrystal-mobile-ita

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
