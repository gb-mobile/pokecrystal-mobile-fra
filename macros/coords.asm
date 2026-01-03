; Coordinate macros

DEF hlcoord EQUS "coord hl,"
DEF bccoord EQUS "coord bc,"
DEF decoord EQUS "coord de,"

MACRO coord
; register, x, y[, origin]
	IF _NARG < 4
		ld \1, (\3) * SCREEN_WIDTH + (\2) + wTilemap
	ELSE
		ld \1, (\3) * SCREEN_WIDTH + (\2) + \4
	ENDC
ENDM

DEF hlbgcoord EQUS "bgcoord hl,"
DEF bcbgcoord EQUS "bgcoord bc,"
DEF debgcoord EQUS "bgcoord de,"

MACRO bgcoord
; register, x, y[, origin]
	IF _NARG < 4
		ld \1, (\3) * BG_MAP_WIDTH + (\2) + vBGMap0
	ELSE
		ld \1, (\3) * BG_MAP_WIDTH + (\2) + \4
	ENDC
ENDM

MACRO dwcoord
; x, y
	REPT _NARG / 2
		dw (\2) * SCREEN_WIDTH + (\1) + wTilemap
		shift 2
	ENDR
ENDM

MACRO ldcoord_a
; x, y[, origin]
	IF _NARG < 3
		ld [(\2) * SCREEN_WIDTH + (\1) + wTilemap], a
	ELSE
		ld [(\2) * SCREEN_WIDTH + (\1) + \3], a
	ENDC
ENDM

MACRO lda_coord
; x, y[, origin]
	IF _NARG < 3
		ld a, [(\2) * SCREEN_WIDTH + (\1) + wTilemap]
	ELSE
		ld a, [(\2) * SCREEN_WIDTH + (\1) + \3]
	ENDC
ENDM

MACRO menu_coords
; x1, y1, x2, y2
	db \2, \1 ; start coords
	db \4, \3 ; end coords
ENDM
