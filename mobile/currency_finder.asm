; Input: DE = the memory address were the string should be written. Also, wPrefecture should be set to the prefecture of the user.
; Output: it edits the bytes pointed by DE.
WriteCurrencyName::
	call DetermineCurrencyName
	call CopyCurrencyString
	ret

; Input: none. wPrefecture should be set to the prefecture of the user.
; Output: HL = the address of the string to use for the currency.
DetermineCurrencyName:
	ld a, [wPrefecture] ; Loads the Prefectures index (starts at 0) selected by the player. The Prefectures list is stored into mobile_12.asm
	dec a ; Beware: it the value is 0, dec will underflow and default to the default value
	
	ld hl, String_Currency_Centime
	cp 23  ; Aargau
	ret z	
	cp 24  ; Appenzell Innerrhoden
	ret z	
	cp 25  ; Appenzell Ausserrhoden
	ret z	
	cp 26  ; Berne
	ret z	
	cp 27  ; Basel-Landschaft
	ret z	
	cp 28  ; Basel-Stadt
	ret z	
	cp 29  ; Fribourg
	ret z	
	cp 30  ; Genève
	ret z	
	cp 31  ; Glarus
	ret z	
	cp 32  ; Graubünden
	ret z	
	cp 33  ; Jura
	ret z	
	cp 34  ; Luzer
	ret z	
	cp 35  ; Neuchâtel
	ret z	
	cp 36  ; Nidwalden
	ret z	
	cp 37  ; Obwalden
	ret z	
	cp 38  ; Sankt Gallen
	ret z	
	cp 39  ; Schaffhausen
	ret z	
	cp 40  ; Solothurn
	ret z	
	cp 41  ; Schwyz
	ret z	
	cp 42  ; Thurgau
	ret z	
	cp 43  ; Ticino
	ret z	
	cp 44  ; Uri
	ret z	
	cp 45  ; Vaud
	ret z	
	cp 46  ; Valais
	ret z	
	cp 47  ; Zug
	ret z	
	cp 48  ; Zürich
	ret z	
	cp 49  ; Balzers
	ret z	
	cp 50  ; Eschen
	ret z	
	cp 51  ; Gamprin
	ret z	
	cp 52  ; Mauren
	ret z	
	cp 53  ; Planken
	ret z	
	cp 54  ; Ruggell
	ret z	
	cp 55  ; Schaan
	ret z	
	cp 56  ; Schellenberg
	ret z	
	cp 57  ; Triesen
	ret z	
	cp 58  ; Triesenberg
	ret z	
	cp 59  ; Vaduz
	ret z		
	

	ld hl, String_Currency_Cents ; Default case. Anything that uses Cents doesn't need to be added into this check list.
	ret

; Input: HL = the address to copy from.
; Output: DE = the address to copy into.
; Stops the copy when the EOL char is found ($50 or '@').
CopyCurrencyString: ; I know this is ugly, I copied and pasted this function from mobile_46.asm
.loop
	ld a, [hli]
	cp $50
	ret z
	ld [de], a
	inc de
	jr .loop



String_Currency_Cents: ; Note that this is unoptimized, as the string "Is this OK?@" is repeted.
	db   " cents";"えん"
	next "Est-ce correct?@";"かかります　よろしい　ですか？@"

String_Currency_Centime:
	db   " cent.";"えん"
	next "Est-ce correct?@";"かかります　よろしい　ですか？@"	