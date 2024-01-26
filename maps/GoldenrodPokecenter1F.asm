	object_const_def
	const GOLDENRODPOKECENTER1F_NURSE
	const GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST
	const GOLDENRODPOKECENTER1F_SUPER_NERD ; $04
	const GOLDENRODPOKECENTER1F_LASS2 ; $05
	const GOLDENRODPOKECENTER1F_YOUNGSTER
	const GOLDENRODPOKECENTER1F_TEACHER ; $07
	const GOLDENRODPOKECENTER1F_ROCKER ; $08
	const GOLDENRODPOKECENTER1F_GAMEBOY_KID
	const GOLDENRODPOKECENTER1F_GRAMPS ; $0A
	const GOLDENRODPOKECENTER1F_LASS
	const GOLDENRODPOKECENTER1F_POKEFAN_F

GoldenrodPokecenter1F_MapScripts:
	def_scene_scripts
	scene_script .Scene0, SCENE_GOLDENRODPOKECENTER1F_DEFAULT
	scene_script .Scene0, SCENE_GOLDENRODPOKECENTER1F_DEFAULT2

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .prepareMap

.Scene0: ; stuff to handle the player turning his gb off without saving after a trade
	setval BATTLETOWERACTION_10 ; 5671d checks if a trade was made
	special BattleTowerAction
	iffalse .noTrade ; $2967
	prioritysjump scenejmp01 ; $6F68 received pokemon from trade corner dialogue
	end

.noTrade
	setval BATTLETOWERACTION_EGGTICKET ; check if player received the odd egg or still has the egg ticket
	special BattleTowerAction ; 5672b
	iffalse .notReceivedOddEgg ; $3467 still has egg ticket
	prioritysjump scenejmp02 ; $B568 received odd egg dialogue
.notReceivedOddEgg
	end

.prepareMap
	special Mobile_DummyReturnFalse
	iftrue .mobile ; $5067
	moveobject GOLDENRODPOKECENTER1F_LASS2, 16, 9 ; this is 71 in jp crystal???
	moveobject GOLDENRODPOKECENTER1F_GRAMPS, 0, 7
	moveobject GOLDENRODPOKECENTER1F_SUPER_NERD, 8, 13
	moveobject GOLDENRODPOKECENTER1F_TEACHER, 27, 13
	moveobject GOLDENRODPOKECENTER1F_ROCKER, 21, 6
	return ; this is 8f in jp crystal
.mobile
	setevent EVENT_33F
	return

GoldenrodPokecenter1FNurseScript:
	setevent EVENT_WELCOMED_TO_POKECOM_CENTER
	jumpstd PokecenterNurseScript

GoldenrodPokecenter1FTradeCornerAttendantScript:
	special SetBitsForLinkTradeRequest
	opentext
	writetext GoldenrodPokecomCenterWelcomeToTradeCornerText ; $2d6a
	buttonsound ; 54 in jp crystal?
	checkitem EGG_TICKET ; 56762 in jp crystal
	iftrue PlayerHasEggTicket ; $7c68
	special Function11b879 ; check save file?
	ifequal $01, PokemonInTradeCorner ; $F667
	ifequal $02, LeftPokemonInTradeCornerRecently ; $6968
	readvar $01
	ifequal $01, .onlyHaveOnePokemon ; $CF67 ; 56772
	writetext GoldenrodPokecomCenterWeMustHoldYourMonText ; $726A
	yesorno
	iffalse PlayerCancelled ; $D567

	writetext GoldenrodPokecomCenterSaveBeforeTradeCornerText ; $756E
	yesorno
	iffalse PlayerCancelled ; $D567
	special TryQuickSave
	iffalse PlayerCancelled ; $D567
	writetext GoldenrodPokecomCenterWhichMonToTradeText ; $8F6E
	waitbutton ; 53 in jp crystal?
	special BillsGrandfather ; 56792
	ifequal $00, PlayerCancelled ; $D567
	ifequal $FD, CantAcceptEgg ; $EA67
	ifgreater $FB, PokemonAbnormal ; $F067
	special Function11ba38 ; check party pokemon fainted
	ifnotequal $00, CantTradeLastPokemon ; $E467
	writetext GoldenrodPokecomCenterWhatMonDoYouWantText ; $9E6A
	waitbutton
	special Function11ac3e
	ifequal $00, PlayerCancelled ; $D567
	ifequal $02, .tradePokemonNeverSeen ; $BB67
	writetext GoldenrodPokecomCenterWeWillTradeYourMonForMonText ; $B96A ; 567B5
	sjump  .tradePokemon ; $BE67
.tradePokemonNeverSeen
	writetext GoldenrodPokecomCenterWeWillTradeYourMonForNewText ; $1E6B
.tradePokemon
	special TradeCornerHoldMon ; create data to send?
	ifequal $0A, PlayerCancelled ; $D567
	ifnotequal $00, MobileError ; $DB67
	writetext GoldenrodPokecomCenterYourMonHasBeenReceivedText ; $A86B
	waitbutton
	closetext
	end

.onlyHaveOnePokemon
	writetext GoldenrodPokecomCenterYouHaveOnlyOneMonText ; $D76B
	waitbutton
	closetext
	end

PlayerCancelled:
	writetext GoldenrodPokecomCenterWeHopeToSeeYouAgainText ; $0F6C
	waitbutton
	closetext
	end

MobileError:
	special BattleTowerMobileError
	writetext GoldenrodPokecomCenterTradeCanceledText ; $AA6E
	waitbutton
	closetext
	end

CantTradeLastPokemon:
	writetext GoldenrodPokecomCenterCantAcceptLastMonText ; $2C6C
	waitbutton
	closetext
	end

CantAcceptEgg:
	writetext GoldenrodPokecomCenterCantAcceptEggText ; $516C
	waitbutton
	closetext
	end

PokemonAbnormal:
	writetext GoldenrodPokecomCenterCantAcceptAbnormalMonText ; $6F6C
	waitbutton
	closetext
	end

PokemonInTradeCorner:
	writetext GoldenrodPokecomCenterSaveBeforeTradeCornerText ; $756E
	yesorno
	iffalse PlayerCancelled ; $D567
	special TryQuickSave
	iffalse PlayerCancelled ; $D567 ; 56800
	writetext GoldenrodPokecomCenterAlreadyHoldingMonText ; $896C
	buttonsound
	readvar $01
	ifequal $06, PartyFull ; $3868
	writetext GoldenrodPokecomCenterCheckingTheRoomsText ; $A56C
	special Function11b5e8 ; connect
	ifequal $0A, PlayerCancelled ; $D567
	ifnotequal $00, MobileError ; $DB67
	setval $0F
	special BattleTowerAction
	ifequal $00, NoTradePartnerFound ; $3E68 ; 56820
	ifequal $01, .receivePokemon ; $2B68
	sjump PokemonInTradeCornerForALongTime ; $5668

.receivePokemon
	writetext GoldenrodPokecomCenterTradePartnerHasBeenFoundText ; $C46C
	buttonsound
	special Function11b7e5 ; receive a pokemon animation?
	writetext GoldenrodPokecomCenterItsYourNewPartnerText ; $E66C
	waitbutton
	closetext
	end

PartyFull:
	writetext GoldenrodPokecomCenterYourPartyIsFullText ; $216D ; 56838
	waitbutton
	closetext
	end

NoTradePartnerFound:
	writetext GoldenrodPokecomCenterNoTradePartnerFoundText ; $576D ; 5683E
	yesorno
	iffalse ContinueHoldingPokemon ; $6368
	special Function11b920 ; something with mobile
	ifequal $0A, PlayerCancelled ; $D567
	ifnotequal $00, MobileError ; $DB67
	writetext GoldenrodPokecomCenterReturnedYourMonText ; $8A6D
	waitbutton
	closetext
	end

PokemonInTradeCornerForALongTime:
	writetext GoldenrodPokecomCenterYourMonIsLonelyText ; $9A6D ; 56856
	buttonsound
	special Function11b93b ; something with mobile
	writetext GoldenrodPokecenter1FWeHopeToSeeYouAgainText_2 ; $016E
	waitbutton
	closetext
	end

ContinueHoldingPokemon:
	writetext GoldenrodPokecomCenterContinueToHoldYourMonText ; $176E ; 56863
	waitbutton
	closetext
	end

LeftPokemonInTradeCornerRecently:
	writetext GoldenrodPokecomCenterRecentlyLeftYourMonText ; $306E ; 56869
	waitbutton
	closetext
	end

scenejmp01: ; ???
	setscene $01 ; 5686F
	refreshscreen
	writetext GoldenrodPokecomCenterTradePartnerHasBeenFoundText ; $C46C
	buttonsound
	writetext GoldenrodPokecomCenterItsYourNewPartnerText ; $E66C
	waitbutton
	closetext
	end

PlayerHasEggTicket:
	writetext GoldenrodPokecomCenterEggTicketText ; $CD6E ; 5687C
	waitbutton
	readvar $01
	ifequal $06, PartyFull ; $3868
	writetext GoldenrodPokecomCenterOddEggBriefingText ; $106F
	waitbutton
	writetext GoldenrodPokecomCenterSaveBeforeTradeCornerText ; $756E
	yesorno
	iffalse PlayerCancelled ; $D567
	special TryQuickSave
	iffalse PlayerCancelled ; $D567
	writetext GoldenrodPokecomCenterPleaseWaitAMomentText ; $CC6F
	special GiveOddEgg
	ifequal $0B, .eggTicketExchangeNotRunning ; $AF68
	ifequal $0A, PlayerCancelled ; $D567
	ifnotequal $00, MobileError ; $DB67
.receivedOddEgg
	writetext GoldenrodPokecomCenterHereIsYourOddEggText ; $E66F
	waitbutton
	closetext
	end

.eggTicketExchangeNotRunning
	writetext GoldenrodPokecomCenterNoEggTicketServiceText ; $2270 ; 568AF
	waitbutton
	closetext
	end

scenejmp02: ; 568B5
	opentext
	sjump PlayerHasEggTicket.receivedOddEgg ; $A968

GoldenrodPokecenter1F_NewsMachineScript:
	special Mobile_DummyReturnFalse ; 568B9
	iftrue .mobileEnabled ; $C268
	jumptext GoldenrodPokecomCenterNewsMachineNotYetText ; $1F76
.mobileEnabled
	opentext
	writetext GoldenrodPokecomCenterNewsMachineText ; $4D70
	buttonsound
	setval $14 ; (get battle tower save file flags if save is yours?)
	special BattleTowerAction
	ifnotequal $00, .skipExplanation ; $D968
	setval $15  ; (set battle tower save file flags?)
	special BattleTowerAction
	writetext GoldenrodPokecomCenterNewsMachineExplanationText ; $6370
	waitbutton
.skipExplanation
	writetext GoldenrodPokecomCenterSaveBeforeNewsMachineText ; $C371
	yesorno
	iffalse .cancel ; $FF68
	special TryQuickSave
	iffalse .cancel ; $FF68
	setval $15 ; (set battle tower save file flags?)
	special BattleTowerAction
.showMenu
	writetext GoldenrodPokecomCenterWhatToDoText ; $5970
	setval $00
	special Menu_ChallengeExplanationCancel ; show news machine menu
	ifequal $01, .getNews 		  ; $0869
	ifequal $02, .showNews 		  ; $1D69
	ifequal $03, .showExplanation ; $0169
.cancel
	closetext
	end

.showExplanation
	writetext GoldenrodPokecomCenterNewsMachineExplanationText ; $6370 ; 56901
	waitbutton
	sjump .showMenu; $EB68

.getNews
	writetext GoldenrodPokecomCenterWouldYouLikeTheNewsText ; $3E71 ; 56908
	yesorno
	iffalse .showMenu;$EB68
	writetext GoldenrodPokecomCenterReadingTheLatestNewsText ; $5471
	special Function17d2b6 ; download news?
	ifequal $0A, .showMenu ; $EB68
	ifnotequal $00, .mobileError ; $3569
.showNews
	special Function17d2ce ; show news?
	iffalse .quitViewingNews ; $3269
	ifequal $01, .noOldNews ; $2E69
	writetext GoldenrodPokecomCenterCorruptedNewsDataText ; $8971
	waitbutton
	sjump .showMenu ; $EB68

.noOldNews
	writetext GoldenrodPokecomCenterNoOldNewsText ; $7971 ; 5692E
	waitbutton
.quitViewingNews
	sjump .showMenu ; $EB68

.mobileError
	special BattleTowerMobileError ; 56935
	closetext
	end

Unreferenced:
	writetext GoldenrodPokecomCenterMakingPreparationsText ; ??? $AA71 ; 5693A no jump to here?
	waitbutton
	closetext
	end

GoldenrodPokecenter1F_GSBallSceneLeft:
	setval $0B ; 56940 (load mobile event index)
	special BattleTowerAction
	iffalse GoldenrodPokecenter1F_GSBallSceneRight.nogsball ; $9769
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER ; 340
	iftrue GoldenrodPokecenter1F_GSBallSceneRight.nogsball ; $9769
	moveobject GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST, 12, 11
	sjump GoldenrodPokecenter1F_GSBallSceneRight.gsball ; 6769

GoldenrodPokecenter1F_GSBallSceneRight:
	setval $0B ; 56955 (load mobile event index)
	special BattleTowerAction
	iffalse .nogsball ; $9769
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER ; 340
	iftrue .nogsball ; $9769
	moveobject GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST, 13, 11

.gsball ; 56769
	disappear GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST
	appear GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST
	playmusic MUSIC_SHOW_ME_AROUND
	applymovement GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST, GoldenrodPokeCenter1FLinkReceptionistApproachPlayerMovement ; $0F6A
	turnobject PLAYER, UP
	opentext
	writetext GoldenrodPokeCenter1FLinkReceptionistPleaseAcceptGSBallText
	waitbutton
	verbosegiveitem GS_BALL
	setevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	setevent EVENT_CAN_GIVE_GS_BALL_TO_KURT
	writetext GoldenrodPokeCenter1FLinkReceptionistPleaseDoComeAgainText
	waitbutton
	closetext
	applymovement GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST, GoldenrodPokeCenter1FLinkReceptionistWalkBackMovement ; $196A
	special RestartMapMusic
	moveobject GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST, 16,  8
	disappear GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST
	appear GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST

.nogsball
	end

GoldenrodPokecenter1FSuperNerdScript:
	special Mobile_DummyReturnFalse ; 56998
	iftrue .mobile ; $A169
	jumptextfaceplayer GoldenrodPokecenter1FMobileOffSuperNerdText  ; $E071

.mobile
	jumptextfaceplayer GoldenrodPokecenter1FMobileOnSuperNerdText ; $1E72

GoldenrodPokecenter1FLass2Script:
	special Mobile_DummyReturnFalse ; 569A4
	iftrue .mobile
	jumptextfaceplayer GoldenrodPokecenter1FMobileOffLassText ; $AD72

.mobile
	checkevent EVENT_33F
	iftrue .alreadyMoved ; $D369
	faceplayer
	opentext
	writetext GoldenrodPokecenter1FMobileOnLassText1 ; $EB72
	waitbutton
	closetext
	readvar $09
	ifequal $02, .talkedToFromRight ; $C769
	applymovement GOLDENRODPOKECENTER1F_LASS2, GoldenrodPokeCenter1FLass2WalkRightMovement ; $236A
	sjump .skip ; $CB69
.talkedToFromRight
	applymovement GOLDENRODPOKECENTER1F_LASS2, GoldenrodPokeCenter1FLassWalkRightAroundPlayerMovement ; $276A
.skip
	setevent EVENT_33F
	moveobject GOLDENRODPOKECENTER1F_LASS2, $12, $09
	end

.alreadyMoved
	jumptextfaceplayer GoldenrodPokecenter1FMobileOnLassText2 ; $2373

GoldenrodPokecenter1FYoungsterScript:
	special Mobile_DummyReturnFalse ; 569D6
	iftrue .mobile ; $DF69
	jumptextfaceplayer GoldenrodPokecenter1FMobileOffYoungsterText ; $5473

.mobile
	jumptextfaceplayer GoldenrodPokecenter1FMobileOnYoungsterText ; $1074

GoldenrodPokecenter1FTeacherScript:
	special Mobile_DummyReturnFalse ; 569E2
	iftrue .mobile ; $EB69
	jumptextfaceplayer GoldenrodPokecenter1FMobileOffTeacherText ; $8273

.mobile
	jumptextfaceplayer GoldenrodPokecenter1FMobileOnTeacherText ; $3274

GoldenrodPokecenter1FRockerScript:
	special Mobile_DummyReturnFalse ; 569EE
	iftrue .mobile ; $F769
	jumptextfaceplayer GoldenrodPokecenter1FMobileOffRockerText ; $D073

.mobile
	jumptextfaceplayer GoldenrodPokecenter1FMobileOnRockerText ; $5474

GoldenrodPokecenter1FGrampsScript:
	special Mobile_DummyReturnFalse ; 569FD
	iftrue .mobile ; $066A
	jumptextfaceplayer GoldenrodPokecenter1FMobileOffGrampsText ; $D674

.mobile
	jumptextfaceplayer GoldenrodPokecenter1FMobileOnGrampsText ; $1875

PokeComCenterInfoSign:
	jumptext GoldenrodPokecomCenterSignText

GoldenrodPokecenter1FGameboyKidScript:
	jumptextfaceplayer GoldenrodPokecenter1FGameboyKidText

GoldenrodPokecenter1FLassScript:
	jumptextfaceplayer GoldenrodPokecenter1FLassText

;GoldenrodPokecenter1FPokefanF:
;	faceplayer
;	opentext
;	writetext GoldenrodPokecenter1FPokefanFDoYouHaveEonMailText
;	waitbutton
;	writetext GoldenrodPokecenter1FAskGiveAwayAnEonMailText
;	yesorno
;	iffalse .NoEonMail
;	takeitem EON_MAIL
;	iffalse .NoEonMail
;	writetext GoldenrodPokecenter1FPlayerGaveAwayTheEonMailText
;	waitbutton
;	writetext GoldenrodPokecenter1FPokefanFThisIsForYouText
;	waitbutton
;	verbosegiveitem REVIVE
;	iffalse .NoRoom
;	writetext GoldenrodPokecenter1FPokefanFDaughterWillBeDelightedText
;	waitbutton
;	closetext
;	end
;
;.NoEonMail:
;	writetext GoldenrodPokecenter1FPokefanFTooBadText
;	waitbutton
;	closetext
;	end
;
;.NoRoom:
;	giveitem EON_MAIL
;	writetext GoldenrodPokecenter1FPokefanFAnotherTimeThenText
;	waitbutton
;	closetext
;	end

GoldenrodPokeCenter1FLinkReceptionistApproachPlayerMovement:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step_end

GoldenrodPokeCenter1FLinkReceptionistWalkBackMovement:
	step UP
	step UP
	step UP
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

GoldenrodPokeCenter1FLass2WalkRightMovement:
	slow_step RIGHT ; db $0B
	slow_step RIGHT ; db $0B
	turn_head UP    ; db $01
	step_end        ; db $47

GoldenrodPokeCenter1FLassWalkRightAroundPlayerMovement:
	slow_step DOWN  ; db $08
	slow_step RIGHT ; db $0B
	slow_step RIGHT ; db $0B
	slow_step UP    ; db $09
	turn_head UP    ; db $01
	step_end        ; db $47

GoldenrodPokecomCenterWelcomeToTradeCornerText:
	text "Bonjour! Bienvenue"
	line "au COIN TROC du"
	cont "CENTRE #COM."
	
	para "Içi, vous pouvez"
	line "faire des échanges"
	
	para "de #MON longue"
	line "distance."
	done

GoldenrodPokecomCenterWeMustHoldYourMonText:
	text "Pour faire un"
	line "échange, nous"
	cont "devons garder un"
	
	para "de vos #MON."
	line "Faire un échange?"
	done

GoldenrodPokecomCenterWhatMonDoYouWantText:
	text "Quel #MON"
	line "voulez-vous en"
	cont "échange?"
	done

GoldenrodPokecomCenterWeWillTradeYourMonForMonText:
	text "Bien, nous allons"
	line "essayer d'échanger"
	cont "votre"

	para "@"
	text_ram wStringBuffer3
	text " contre"
	line "@"
	text_ram wStringBuffer4
	text "."

	para "Pour cela, votre"
	line "#MON va rester"
	
	para "avec nous pendant"
	line "l'échange."

	para "Patientez un peu,"
	line "les préparations"
	cont "sont en cours."
	done

GoldenrodPokecomCenterWeWillTradeYourMonForNewText:
	text "Bien, nous allons"
	line "essayer d'échanger"
	cont "votre"

	para "@"
	text_ram wStringBuffer3
	text " contre un #MON"
	line "que vous n'avez"
	cont "jamais vu."

	para "Pour cela, votre"
	line "#MON va rester"
	
	para "avec nous pendant"
	line "l'échange."

	para "Patientez un peu,"
	line "les préparations"
	cont "sont en cours."
	done

GoldenrodPokecomCenterYourMonHasBeenReceivedText:
	text "Votre #MON a"
	line "bien été reçu."

	para "Trouver quelqu'un"
	line "qui veut échanger"

	para "avec vous peut"
	line "prendre du temps."

	para "Revenez plus tard"
	line "s'il vous plaît"
	done

GoldenrodPokecomCenterYouHaveOnlyOneMonText:
	text "Oh? Vous n'avez"
	line "qu'un seul #MON"
	cont "dans votre équipe."

	para "Revenez nous voir"
	line "quand vous aurez"
	cont "rajouté du monde"
	cont "à votre équipe."
	done

GoldenrodPokecomCenterWeHopeToSeeYouAgainText:
	text "Encore merci et"
	line "à bientôt!"
	done

GoldenrodPokecomCenterCommunicationErrorText: ; unreferenced
	text "Erreur de"
	line "communication..."
	done

GoldenrodPokecomCenterCantAcceptLastMonText:
	text "Si nous acceptons"
	line "ce #MON, votre"
	cont "équipe sera vide."
	done

GoldenrodPokecomCenterCantAcceptEggText:
	text "Désolé, mais nous"
	line "n'acceptons pas"
	cont "les OEUFs."
	done

GoldenrodPokecomCenterCantAcceptAbnormalMonText:
	text "Désolé, mais votre"
	line "#MON semble"
	cont "anormal."

	para "Nous ne pouvons"
	line "pas l'accepter."
	done

GoldenrodPokecomCenterAlreadyHoldingMonText:
	text "Oh? N'avons nous"
	line "pas déjà un de vos"
	cont "#MON avec nous?"
	done

GoldenrodPokecomCenterCheckingTheRoomsText:
	text "Nous vérifions que"
	line "tout aille bien."
	
	para "Attendre s.v.p."
	done

GoldenrodPokecomCenterTradePartnerHasBeenFoundText:
	text "Merci de votre"
	line "patience. Quelqu'un"
	
	para "veut faire un"
	line "échange avec vous."
	done

GoldenrodPokecomCenterItsYourNewPartnerText:
	text "Le voilà! Votre"
	line "nouveau compagnon!"

	para "Prenez soin de lui"
	line "et aimez-le de"
	cont "tout votre coeur."

	para "En espérant vous"
	line "revoir bientôt!"
	done

GoldenrodPokecomCenterYourPartyIsFullText:
	text "Mince alors! Votre"
	line "équipe est pleine!"

	para "Revenez nous voir"
	line "quand vous aurez"
	cont "fais de la place"
	cont "dans votre équipe."
	done

GoldenrodPokecomCenterNoTradePartnerFoundText:
	text "C'est malheureux,"
	line "mais personne ne"

	para "semble intéressé"
	line "par votre #MON."

	para "Voulez-vous le"
	line "récupérer?"
	done

GoldenrodPokecomCenterReturnedYourMonText:
	text "Votre #MON vous"
	line "a été remis."
	done

GoldenrodPokecomCenterYourMonIsLonelyText:
	text "Malheureusement,"
	line "personne ne semble"

	para "vouloir échanger"
	line "avec vous."

	para "Votre #MON est"
	line "avec nous depuis"

	para "longtemps, et il"
	line "se sent très seul"
	cont "à cause de cela."

	para "Désolé, mais nous"
	line "ne pouvons que"
	cont "vous le rendre."
	done

GoldenrodPokecenter1FWeHopeToSeeYouAgainText_2:
	text "Encore merci et"
	line "à bientôt!"
	done

GoldenrodPokecomCenterContinueToHoldYourMonText:
	text "Votre #MON va"
	line "donc rester avec"
	cont "nous. D'accord?"
	done

GoldenrodPokecomCenterRecentlyLeftYourMonText:
	text "Oh? Vous nous avez"
	line "laissé votre #-"
	cont "MON que récemment."
	
	para "Revenez plus tard"
	line "s'il vous plaît."
	done

GoldenrodPokecomCenterSaveBeforeTradeCornerText:
	text "Votre session sera"
	line "SAUVEE avant la"
	
	para "connexion avec le"
	line "CENTRE."
	done

GoldenrodPokecomCenterWhichMonToTradeText:
	text "Quel #MON"
	line "échanger?"
	done

GoldenrodPokecomCenterTradeCanceledText:
	text "Je suis désolée,"
	line "mais l'échange doit"
	cont "être annulé."
	done

GoldenrodPokecomCenterEggTicketText:
	text "Oh!"

	para "Je vois que"
	line "vous avez sur vous"
	cont "un TICKET OEUF!"

	para "Grâce à ce ticket,"
	line "vous recevez un"

	para "#MON méga cool"
	line "avec lequel vous"
	
	para "pourrez vous taper"
	line "la méga frime."	
	done

GoldenrodPokecomCenterOddEggBriefingText:
	text "Laissez-moi tout"
	line "vous expliquer."

	para "Les échanges du"
	line "COIN TROC se font"

	para "entre dresseurs"
	line "qui ne se "
	cont "connaissent pas."

	para "Ainsi, trouver une"
	line "personne voulant"

	para "échanger avec vous"
	line "peut prendre un"
	cont "petit moment."

	para "L'OEUF BIZARRE,"
	line "quant à lui, est"

	para "offert à chaque"
	line "nouvel adhérent."

	para "Récupérez-le dès"
	line "maintenant en vous"
	cont "rendant au CENTRE!"
	done

GoldenrodPokecomCenterPleaseWaitAMomentText:
	text "Patientez une"
	line "seconde..."
	done

GoldenrodPokecomCenterHereIsYourOddEggText:
	text "Merci de votre"
	line "patience. Votre"

	para "OEUF BIZARRE a"
	line "bien été reçu."

	para "Le voici le voilà!"

	para "Donnez-lui tout"
	line "votre amour!"
	done

GoldenrodPokecomCenterNoEggTicketServiceText:
	text "Désolé, mais nous"
	
	para "n'acceptons pas"
	line "les TIQUETS OEUF"
	cont "pour l'instant."
	done

GoldenrodPokecomCenterNewsMachineText:
	text "C'est le TERMINAL"
	line "des INFOS #MON."
	done

GoldenrodPokecomCenterWhatToDoText:
	text "Que voulez-vous"
	line "faire?"
	done

GoldenrodPokecomCenterNewsMachineExplanationText:
	text "Les INFOS #MON"
	line "proviennent des"

	para "SAUVEGARDES des"
	line "dresseurs #MON."

	para "Lors de la lecture"
	line "des INFOS, votre"

	para "SAUVEGARDE pourra"
	line "être envoyée si"
	cont "vous le souhaitez."

	para "Votre SAUVEGARDE"
	line "contiendra le"

	para "récit de vos"
	line "aventures et votre"
	cont "profile mobile."

	para "Votre numéro de"
	line "mobile ne sera pas"
	cont "communiqué."

	para "Le contenu des"
	line "INFOS dépendra des"

	para "SAUVEGARDES que"
	line "vous et les autres"

	para "dresseurs #MON"
	line "enverrez."

	para "Vous pourriez même"
	line "passer aux INFOS!"
	done

GoldenrodPokecomCenterWouldYouLikeTheNewsText:
	text "Recevoir les "
	line "dernières INFOS?"
	done

GoldenrodPokecomCenterReadingTheLatestNewsText:
	text "Chargement des"
	line "dernières INFOS."
	cont "Attendez s.v.p."
	done

GoldenrodPokecomCenterNoOldNewsText:
	text "Aucunes vieilles"
	line "INFOS..."
	done

GoldenrodPokecomCenterCorruptedNewsDataText:
	text "Les données INFOS"
	line "sont corrompues."

	para "Téléchargez les"
	line "INFOS à nouveau"
	cont "s.v.p."
	done

GoldenrodPokecomCenterMakingPreparationsText:
	text "Des réglages sont"
	line "encore en cours."

	para "Revenez plus tard"
	line "s.v.p."
	done

GoldenrodPokecomCenterSaveBeforeNewsMachineText:
	text "Nous allons SAUVER"
	line "votre partie avant"
	
	para "de nous connecter"
	line "au TERMINAL INFOS."
	done

GoldenrodPokecenter1FMobileOffSuperNerdText:
	text "Ce CENTRE #MON"
	line "est immense! Ils"
	
	para "l'ont construit il"
	line "y a pas longtemps."
	
	para "J'ai jamais vu de"
	line "machines comme"
	cont "celles-ci."
	done

GoldenrodPokecenter1FMobileOnSuperNerdText:
	text "Je viens d'avoir"
	line "une super idée"
	cont "pour le COIN TROC!"

	para "Prends un ROUCOOL,"
	line "fais-lui tenir une"

	para "LETTRE, et ensuite"
	line "échange-le contre"
	cont "un autre!"

	para "Si tout le monde"
	line "faisait ça, les"

	para "LETTRES pourraient"
	line "être échangées de"
	cont "par le monde!"

	para "Avec ce système de"
	line "ROUCOOL VOYAGEURS,"

	para "je suis sûr de me"
	line "faire des amis!"
	done

GoldenrodPokecenter1FMobileOffLassText:
	text "Apparemment, tu"
	line "peut échanger tes"
	
	para "#MON avec des"
	line "inconnus par ici."
	
	para "Mais ils ont pas"
	line "encore fini avec"
	cont "leurs réglages."
	done

GoldenrodPokecenter1FMobileOnLassText1:
	text "Une fille que je"
	line "connais pas viens"

	para "de m'envoyer son"
	line "GRANIVOL."

	para "Quand tu fait un"
	line "échange, dit bien"
	
	para "quel #MON tu"
	line "veut en retour."
	done

GoldenrodPokecenter1FMobileOnLassText2:
	text "Le GRANIVOL qu'on"
	line "m'a échangé est"
	
	para "femelle, mais son"
	line "ancien dresseur l'a"
	cont "appelée MICHEL."

	para "Mon papa aussi il"
	line "s'appelle comme ça!"
	done

GoldenrodPokecenter1FMobileOffYoungsterText:
	text "Le TERMINAL INFOS?"
	
	para"Est-ce qu'il reçoit"
	line "ses infos sur un"
	cont "rayon plus large"
	cont "que la radio?"
	done

GoldenrodPokecenter1FMobileOffTeacherText:
	text "Le CENTRE #COM"
	line "peut se connecter"

	para "à tous les CENTRES"
	line "#MON sur le"
	cont "réseau sans-fil."

	para "Que d'opportunités"
	line "pour se faire de"
	cont "nouveaux amis!"
	done

GoldenrodPokecenter1FMobileOffRockerText:
	text "Les machine que"
	line "vous voyez ne sont"
	cont "pas encore prêtes."
	
	para "Mais bon, c'est"
	line "branché par ici,"

	para "il y a de quoi"
	line "taper la discute"
	cont "au moins."
	done

GoldenrodPokecenter1FMobileOnYoungsterText:
	text "Mon ami est passé"
	line "aux INFOS il y a"
	
	para "pas longtemps."
	line "Ca m'a surpris de"
	cont "le voir là-dedans!"
	done

GoldenrodPokecenter1FMobileOnTeacherText:
	text "Je stresse si je"
	line "regarde pas les"
	cont "dernières INFOS!"
	done

GoldenrodPokecenter1FMobileOnRockerText:
	text "Si je passe aux"
	line "INFOS, je serais"
	
	para "une célébrité, et"
	line "tout le monde"
	
	para "m'aimerait!"
	line "Euh... Comment on"
	
	para "fait pour passer"
	line "aux INFOS?"
	done

GoldenrodPokecenter1FGameboyKidText:
	text "Le COLISEE sert"
	line "à faire des com-"
	cont "bats en Link."

	para "Les records sont"
	line "affichés sur le"
	cont "mur. Perdre, c'est"
	cont "la honte!"
	done

GoldenrodPokecenter1FMobileOffGrampsText:
	text "Je suis venu dès"
	line "que j'ai appris que"

	para "le CENTRE #MON"
	line "de DOUBLONVILLE"
	cont "avait été rénové."

	para "Il est maintenant"
	line "à la pointe de la"

	para "technologie, du"
	line "jamais vu!"

	para "Malheureusement,"
	line "il n'est pas encore"
	cont "opérationnel."
	done

GoldenrodPokecenter1FMobileOnGrampsText:
	text "Juste voir les"
	line "nouveaux choses"

	para "ici me fait sentir"
	line "plus jeune!"
	done

GoldenrodPokecenter1FLassText:
	text "Un #MON de"
	line "niveau élevé ne"
	cont "gagnera pas à tous"
	cont "les coups."

	para "Après tout, il y a"
	line "peut-être un type"
	cont "désavantagé."

	para "Je ne crois pas"
	line "qu'il y ait un"

	para "type de #MON"
	line "qui soit le plus"
	cont "résistant."
	done

GoldenrodPokeCenter1FLinkReceptionistPleaseAcceptGSBallText:
	text "<PLAYER>?"

	para "Félicitations!"

	para "En cadeau spécial,"
	line "une GS BALL vous a"
	cont "été envoyée!"

	para "C'est pour vous!"
	done

GoldenrodPokeCenter1FLinkReceptionistPleaseDoComeAgainText:
	text "A très bientôt!"
	done

GoldenrodPokecomCenterSignText:
	text "CENTRE #COM"
	line "A PROPOS DU RDC"

	para "Gauche:"
	line "ADMINISTRATION"

	para "Centre:"
	line "COIN TROC"

	para "Droite:"
	line "INFOS #MON"
	done

GoldenrodPokecomCenterNewsMachineNotYetText:
	text "C'est une machine"
	line "d'INFOS #MON!"

	para "Elle ne marche"
	line "pas maintenant…"
	done

GoldenrodPokecenter1FPokefanFDoYouHaveEonMailText:
	text "Ton SAC a l'air"
	line "siiiii lourd!"

	para "Oh! As-tu un truc"
	line "du nom de LETR"
	cont "EVOLI?"

	para "Ma fille en veut"
	line "une."

	para "Tu peux m'en"
	line "donner une?"
	done

GoldenrodPokecenter1FAskGiveAwayAnEonMailText:
	text "Donner LETR EVOLI?"
	done

GoldenrodPokecenter1FPokefanFThisIsForYouText:
	text "Oh, formidable!"
	line "Merci merci!"
	cont "Voilà pour toi!"
	done

GoldenrodPokecenter1FPokefanFDaughterWillBeDelightedText:
	text "Ma fille sera"
	line "ravie!"
	done

GoldenrodPokecenter1FPokefanFTooBadText:
	text "Oh? Tu n'en as"
	line "pas? Dommage."
	done

GoldenrodPokecenter1FPokefanFAnotherTimeThenText:
	text "Oh... Une autre"
	line "fois, alors."
	done

GoldenrodPokecenter1FPlayerGaveAwayTheEonMailText:
	text "<PLAYER> donne"
	line "la LETR EVOLI."
	done

GoldenrodPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6, 15, GOLDENROD_CITY, 15
	warp_event  7, 15, GOLDENROD_CITY, 15
	warp_event  0,  6, POKECOM_CENTER_ADMIN_OFFICE_MOBILE, 1
	warp_event  0, 15, POKECENTER_2F, 1

	def_coord_events
	coord_event  6, 15, SCENE_DEFAULT, GoldenrodPokecenter1F_GSBallSceneLeft
	coord_event  7, 15, SCENE_DEFAULT, GoldenrodPokecenter1F_GSBallSceneRight

	def_bg_events
	bg_event 24,  5, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript ; 57666
	bg_event 24,  6, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 24,  7, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 24,  9, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 24, 10, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 25, 11, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 26, 11, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 27, 11, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 28, 11, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 29,  5, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 29,  6, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 29,  7, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 29,  8, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 29,  9, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 29, 10, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event  2,  9, BGEVENT_READ, PokeComCenterInfoSign

	def_object_events
	object_event  7,  7, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FNurseScript, -1
	 ; 576C4
	object_event 16,  8, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FTradeCornerAttendantScript, -1
	 ; boy left of trade corner 576D1
	object_event 13,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_UP_DOWN, 16, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FSuperNerdScript, -1
	 ; girl in front of trade corner 576DE
	object_event 18,  9, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FLass2Script, -1
	 ; boy left of news machine 576EB
	object_event 23, 08, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FYoungsterScript, -1
	 ; girl right of news machine 576F8
	object_event 30, 09, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FTeacherScript, -1
	 ; boy right of news machine 57705
	object_event 30, 05, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FRockerScript, -1
	 ; 57712
	object_event 11, 12, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FGameboyKidScript, -1
	 ; old man 5771F
	object_event 19, 14, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FGrampsScript, -1
	 ; 5772C
	object_event  4, 11, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FLassScript, -1
	;object_event 15, 12, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FPokefanF, -1
