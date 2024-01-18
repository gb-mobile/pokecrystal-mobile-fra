	object_const_def
	const DAYCARE_GRAMPS
	const DAYCARE_GRANNY

DayCare_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, DayCareEggCheckCallback

DayCareEggCheckCallback:
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue .PutDayCareManOutside
	clearevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	setevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	endcallback

.PutDayCareManOutside:
	setevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	clearevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	endcallback

DayCareManScript_Inside:
	faceplayer
	opentext
	special Mobile_DummyReturnFalse
	iffalse .AlreadyHaveOddEgg
	checkevent EVENT_GOT_ODD_EGG
	iftrue .AlreadyHaveOddEgg
	setval EGG_TICKET
	special UnusedFindItemInPCOrBag
	iftrue .AlreadyHaveOddEgg
	writetext Text_DayCareManTalksAboutEggTicket ; 7E2A
	promptbutton
	verbosegiveitem EGG_TICKET
	writetext DayCareText_ComeAgain ; 7EA3
	waitbutton
	closetext
	setevent EVENT_GOT_ODD_EGG
	end

.PartyFull:
	opentext
	writetext DayCareText_PartyFull
	waitbutton
	closetext
	end

.AlreadyHaveOddEgg:
	special DayCareMan
	waitbutton
	closetext
	end

DayCareLadyScript:
	faceplayer
	opentext
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue .HusbandWasLookingForYou
	special DayCareLady
	waitbutton
	closetext
	end

.HusbandWasLookingForYou:
	writetext Text_GrampsLookingForYou
	waitbutton
	closetext
	end

DayCareBookshelf:
	jumpstd DifficultBookshelfScript

Text_GrampsLookingForYou:
	text "Pépé te cherche."
	done

Text_DayCareManTalksAboutEggTicket: ; unreferenced
	text "Je suis le TYPE de"
	line "la PENSION."

	para "Il y a quelque"
	line "chose de nouveau"
	cont "à DOUBLONVILLE."

	para "Ca s'appelle le"
	line "COIN TROC!"
	
	para "On m'a donné un"
	line "TICKET OEUF"

	para "qui peut être"
	line "échangé contre un"

	para "OEUF BIZARRE."
	line "Mais vu qu'on gère"

	para "une pension, on en"
	line "a pas besoin."

	para "Tiens, t'as qu'à"
	line "le prendre."
	done

DayCareManText_GiveOddEgg:
	text "Je suis le TYPE de"
	line "la PENSION."

	para "Tu connais les"
	line "OEUFS?"

	para "J'élevais des"
	line "#MON avec ma"
	cont "femme..."

	para "Et puis on a trou-"
	line "vé un OEUF!"

	para "C'est pas trop"
	line "dingue, ça?"

	para "Bon. Tu le veux"
	line "cet OEUF?"
	cont "Tu peux le garder!"
	done

DayCareText_ComeAgain: ; unreferenced
	text "A bientôt."
	done

DayCareText_GotOddEgg:
	text "<PLAYER> reçoit"
	line "OEUF BIZARRE!"
	done

DayCareText_DescribeOddEgg:
	text "J'ai trouvé ça"
	line "en m'occupant du"

	para "#MON de"
	line "quelqu'un."

	para "Mais le dresseur"
	line "ne veut pas de"
	cont "l'OEUF..."
	done

DayCareText_PartyFull:
	text "Tu n'as plus de"
	line "place."
	done

DayCare_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  5, ROUTE_34, 3
	warp_event  0,  6, ROUTE_34, 4
	warp_event  2,  7, ROUTE_34, 5
	warp_event  3,  7, ROUTE_34, 5

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, DayCareBookshelf
	bg_event  1,  1, BGEVENT_READ, DayCareBookshelf

	def_object_events
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareManScript_Inside, EVENT_DAY_CARE_MAN_IN_DAY_CARE
	object_event  5,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, DayCareLadyScript, -1
