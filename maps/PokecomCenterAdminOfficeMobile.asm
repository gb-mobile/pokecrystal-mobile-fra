	object_const_def
	const POKECOMCENTERADMINOFFICEMOBILE_SCIENTIST1
	const POKECOMCENTERADMINOFFICEMOBILE_SCIENTIST2
	const POKECOMCENTERADMINOFFICEMOBILE_SCIENTIST3

PokecomCenterAdminOfficeMobile_MapScripts:
	def_scene_scripts

	def_callbacks

PokecomCenterAdminOfficeMobileScientist1Script:
	jumptextfaceplayer PokecomCenterAdminOfficeMobileScientist1Text

PokecomCenterAdminOfficeMobileScientist2Script:
	jumptextfaceplayer PokecomCenterAdminOfficeMobileScientist2Text

PokecomCenterAdminOfficeMobileScientist3Script:
	jumptextfaceplayer PokecomCenterAdminOfficeMobileScientist3Text

PokecomCenterAdminOfficeMobileComputer1:
	opentext
	writetext PokecomCenterAdminOfficeMobileComputer1Text
	waitbutton
.loop:
	reloadmappart
	loadmenu .Computer1MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .PokeComClub
	ifequal 2, .MobileCenter
	sjump .Quit

.PokeComClub:
	opentext
	writetext PokecomCenterAdminOfficeMobileComputer1Text_PokeComClub
	waitbutton
	sjump .loop

.MobileCenter:
	opentext
	writetext PokecomCenterAdminOfficeMobileComputer1Text_MobileCenter
	waitbutton
	sjump .loop

.Quit:
	closetext
	end

.Computer1MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 15, 8
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 3 ; items
	db "CLUB #COM@" ; # COM CLUB
	db "CENTRE MOBILE@" ; MOBILE CENTER
	db "ANNULER@" ; QUIT

PokecomCenterAdminOfficeMobileComputer2:
	opentext
	writetext PokecomCenterAdminOfficeMobileComputer2Text
	waitbutton
.loop:
	reloadmappart
	loadmenu .Computer2MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .UsePhone
	ifequal 2, .DontUsePhone
	sjump .Quit

.UsePhone:
	opentext
	writetext PokecomCenterAdminOfficeMobileComputer2Text_UsePhone
	waitbutton
	sjump .loop

.DontUsePhone:
	opentext
	writetext PokecomCenterAdminOfficeMobileComputer2Text_DontUsePhone
	waitbutton
	sjump .loop

.Quit:
	closetext
	end

.Computer2MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 15, 8
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 3 ; items
	db "MODE D'EMPLOI@" ; Use phone
	db "PROBLEMES@" ; Don't use phone
	db "ANNULER@" ; QUIT

PokecomCenterAdminOfficeMobileComputer3:
	jumptext PokecomCenterAdminOfficeMobileComputer3Text

PokecomCenterAdminOfficeMobileScientist1Text:
	text "Le CENTRE #COM"
	line "et CENTRE MOBILE"

	para "ont été construits"
	line "pour permettre aux"

	para "dresseurs de se"
	line "battre, échanger,"

	para "ou juste se lier"
	line "d'amitié avec de"
	cont "parfaits inconnus."
	done

PokecomCenterAdminOfficeMobileScientist2Text:
	text "Ta toute première"
	line "connexion mobile,"

	para "c'est comme faire"
	line "le grand saut!"

	para "Mon premier essai,"
	line "moi, il m'a laissé"
	cont "tout surexcité!"
	done

PokecomCenterAdminOfficeMobileScientist3Text:
	text "Cette facilité a"
	line "pu voir le jour"

	para "grâce aux avancées"
	line "de la technologie"
	cont "sans-fil."
	done

PokecomCenterAdminOfficeMobileComputer1Text:
	text "Adaptateurs mobile"
	line "et comment bien"

	para "s'en servir. Un"
	line "guide pratique…"
	done

PokecomCenterAdminOfficeMobileComputer1Text_PokeComClub:
	text "Un CLUB #COM se"
	line "trouve au premier"

	para "étage de tout les"
	line "CENTRES #MON."

	para "De là, vous pouvez"
	line "vous battre ou"

	para "échanger avec vos"
	line "amis qui vivent"

	para "loin de chez vous,"
	line "grâce à un"
	cont "ADAPTATEUR MOBILE."

	para "Une connexion avec"
	line "vos amis nécessite"

	para "que vous ayez tous"
	line "deux le même type"
	cont "d'ADAPTATEUR."
	done

PokecomCenterAdminOfficeMobileComputer1Text_MobileCenter:
	text "Pour utiliser le"
	line "COIN TROC ou les"
	
	para "INFOS #MON vous"
	line "devez contacter le"
	cont "CENTRE MOBILE."
	
	para "Une inscription au"
	line "CENTRE MOBILE est"
	
	para "nécessaire avant"
	line "de vous connecter."
	done

PokecomCenterAdminOfficeMobileComputer2Text:
	text "Comment utiliser"
	line "son téléphone. Un"
	cont "guide pratique…"
	done

PokecomCenterAdminOfficeMobileComputer2Text_UsePhone:
	text "Vérifiez que votre"
	line "téléphone et votre"

	para "ADAPTATEUR MOBILE"
	line "soient reliés"
	cont "correctement."

	para "Vérifiez que le"
	line "signal sans-fil du"
	
	para "téléphone soit"
	line "suffisant."

	para "Ne raccrochez pas"
	line "le téléphone lors"
	cont "d'une connexion."
	done

PokecomCenterAdminOfficeMobileComputer2Text_DontUsePhone:
	text "Si le serveur est"
	line "surchargé, il est"

	para "possible que vous"
	line "ne puissiez pas"
	cont "vous connecter."	

	para "Si cela arrive,"
	line "tenez de rappeler"
	cont "plus tard."	

	para "S'il vous est"
	line "impossible de vous"

	para "connecter, ou si"
	line "vous ne comprenez"

	para "pas les messages"
	line "d'erreur, relisez"
	
	para "la manuel, ou"
	line "appelez un centre"
	cont "de support."
	done

PokecomCenterAdminOfficeMobileComputer3Text:
	text "L'ADMINISTRATION a"
	line "reçu un e-mail!"
	cont "Voyons voir…"

	para "<……> <……> <……>"

	para "Chers employés du"
	line "CENTRE #COM…"

	para "Grâce à la magie"
	line "du sans-fil, les"

	para "dresseurs #MON"
	line "de notre belle"

	para "région peuvent"
	line "enfin communiquer"
	cont "entre eux."

	para "Avançons main dans"
	line "la main vers un"
	
	para "future où les"
	line "dresseurs de par"

	para "le monde pourront"
	line "parler entre eux!"

	para "<……> <……> <……>"
	done

PokecomCenterAdminOfficeMobile_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0, 31, GOLDENROD_POKECENTER_1F, 3
	warp_event  1, 31, GOLDENROD_POKECENTER_1F, 3

	def_coord_events

	def_bg_events
	bg_event  6, 26, BGEVENT_UP, PokecomCenterAdminOfficeMobileComputer1
	bg_event  6, 28, BGEVENT_UP, PokecomCenterAdminOfficeMobileComputer2
	bg_event  3, 26, BGEVENT_UP, PokecomCenterAdminOfficeMobileComputer3

	def_object_events
	object_event  4, 28, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PokecomCenterAdminOfficeMobileScientist1Script, -1
	object_event  7, 27, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PokecomCenterAdminOfficeMobileScientist2Script, -1
	object_event  7, 29, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PokecomCenterAdminOfficeMobileScientist3Script, -1
