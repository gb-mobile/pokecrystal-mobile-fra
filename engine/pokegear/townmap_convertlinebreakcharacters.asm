TownMap_ConvertLineBreakCharacters:
	ld hl, wStringBuffer1
	ld c, STRING_BUFFER_LENGTH - 1
.loop
	ld a, [hl]
	cp "@"
	jr z, .end
	cp "%"
	jr z, .hyphen_break
	cp "¯"
	jr z, .line_feed
	inc hl
	dec c
	jr .loop

.hyphen_break
	ld hl, wStringBuffer1
	ld e, STRING_BUFFER_LENGTH
	ld d, 0
	add hl, de
	ld d, h
	ld e, l
	dec hl

.string_shift_loop
	ld a, [hl]
	ld [de], a
	dec hl
	dec de

	dec c
	jr nz, .string_shift_loop

	ld [hl], "-"
	inc hl

.line_feed
	ld [hl], "<LF>"

.end
	ld de, wStringBuffer1
	hlcoord 9, 0
	call PlaceString
	ret