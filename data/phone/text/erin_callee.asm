ErinAnswerPhoneText:
	text "Oui, c'est"
	line "@"
	text_ram wStringBuffer3
	text "...."

	para "Oh. <PLAY_G>!"
	line "Bonjour!"
	done

ErinAnswerPhoneDayText:
	text "Oui, c'est"
	line "@"
	text_ram wStringBuffer3
	text "...."

	para "Oh. <PLAY_G>!"
	line "Bonjour!"
	done

ErinAnswerPhoneNiteText:
	text "Yes, this is"
	line "@"
	text_ram wStringBuffer3
	text "...."

	para "Oh, hi, <PLAY_G>!"
	done

ErinGreetText:
	text "<PLAY_G>!"

	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	line "Bonjour!"
	done

ErinGreetDayText:
	text "<PLAY_G>!"

	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	line "Ca bosse dur?"
	done

ErinGreetNiteText:
	text "<PLAY_G>!"

	para "C'est @"
	text_ram wStringBuffer3
	text "!"
	line "T'es debout?"
	done

ErinGenericText:
	text "Tu entraînes bien"
	line "tes #MON?"

	para "Le @"
	text_ram wStringBuffer4
	text_start
	line "de @"
	text_ram wStringBuffer3
	text_start
	cont "est trop fort!"
	done
