" Vim syntax file
<<<<<<< HEAD
" Language: OBSE Script (OBSEScript)
" Maintainer: Ulthar Seramis, Kat
" Latest Revision: 26, January 2021
" License: This is provided as-is 

=======
>>>>>>> origin/main
if exists("b:current_syntax")
  finish
endif

let b:current_syntax = 'obse'
" obscript is case insensitive
syntax case ignore

" Regex matched objects {{{
" these are matched with regex and thus must be set first
syn match obseNames '\w\+'
syn match obseVariable '\S\a\+' contained
syn match obseScriptNameRegion '\i\+' contained
syn match obseReference '\zs\w\+\>\ze\.'
" }}}

" Numbers {{{
syn match obseInt '\d\+'
syn match obseInt '[-+]\d\+'
syn match obseFloat '\d\+\.\d*' 
syn match obseFloat '[-+]\d\+\.\d*'
" }}}

" Operators {{{
syn match obseOperator "\v\*"
syn match obseOperator "\v\-"
syn match obseOperator "\v\+"
syn match obseOperator "\v\/"
syn match obseOperator "\v\^"
syn match obseOperator "\v\="
syn match obseOperator "\v\>"
syn match obseOperator "\v\<"
syn match obseOperator "\v\!"
syn match obseOperator "\v\&"
syn match obseOperator "\v\|"
" }}}

" Comments and strings {{{
setlocal commentstring=;%s
syn region obseComment start=";" end="$" keepend fold contains=obseToDo
syn region obseString start=/"/ end=/"/
syn keyword obseToDo contained TODO todo Todo ToDo FIXME fixme NOTE note
" }}}

" Statements {{{
syn keyword obseStatement set let nextgroup=obseVariable skipwhite
" the second part needs to be separate as to not mess up the next group
syn match obseStatementTwo "\<to\>" 
syn match obseStatementTwo ":="
" }}}

" Conditionals {{{
syn match obseCondition "If" 
syn match obseCondition "Eval"
syn match obseCondition "Return"
syn match obseCondition "EndIf"
syn match obseCondition "ElseIf"
syn match obseCondition "Else" 
" }}}

" Repeat loops {{{
syn match obseRepeat "Label" 
syn match obseRepeat "GoTo"
syn match obseRepeat "While"
syn match obseRepeat "Loop"
syn match obseRepeat "ForEach"
syn match obseRepeat "Break"
syn match obseRepeat "Continue"
" }}}

" Basic Types {{{
<<<<<<< HEAD
syn keyword obseTypes short long float ref reference array_var string_var int nextgroup=obseNames skipwhite
=======
syn keyword obseTypes array_var float int long ref reference short string_var nextgroup=obseNames skipwhite
>>>>>>> origin/main
syn keyword obseOtherKey Player player playerRef playerREF PlayerRef PlayerREF
syn keyword obseScriptName ScriptName scriptname Scriptname scn nextgroup=obseScriptNameRegion skipwhite
syn keyword obseBlock Begin End
" }}}

" Fold {{{
setlocal foldmethod=syntax
syn cluster obseNoFold contains=obseComment,obseString
syn region obseFoldIfContainer
      \ start="^\s*\<if\>"
      \ end="^\s*\<endif\>"
      \ keepend extend
      \ containedin=ALLBUT,@obseNoFold
      \ contains=ALLBUT,obseScriptName,obseScriptNameRegion
syn region obseFoldIf
      \ start="^\s*\<if\>"
      \ end="^\s*\<endif\>"
      \ fold
      \ keepend
      \ contained containedin=obseFoldIfContainer
      \ nextgroup=obseFoldElseIf,obseFoldElse
      \ contains=TOP,NONE
syn region obseFoldElseIf
      \ start="^\s*\<elseif\>"
      \ end="^\s*\<endif\>"
      \ fold
      \ keepend
      \ contained containedin=obseFoldIfContainer
      \ nextgroup=obseFoldElseIf,obseFoldElse
      \ contains=TOP
syn region obseFoldElse
      \ start="^\s*\<else\>"
      \ end="^\s*\<endif\>"
      \ fold
      \ keepend
      \ contained containedin=obseFoldIfContainer
      \ contains=TOP
syn region obseFoldWhile
      \ start="^\s*\<while\>"
      \ end="^\s*\<loop\>"
      \ fold
      \ keepend extend
      \ contains=TOP
      \ containedin=ALLBUT,@obseNoFold
" fold for loops
syn region obseFoldFor
      \ start="^\s*\<foreach\>"
      \ end="^\s*\<loop\>"
      \ fold
      \ keepend extend
      \ contains=TOP
      \ containedin=ALLBUT,@obseNoFold
      \ nextgroup=obseVariable
" }}}

" Skills and Attributes {{{
syn keyword skillAttribute
      \ Strength
      \ Willpower
      \ Speed
      \ Personality
      \ Intelligence
      \ Agility
      \ Endurance
      \ Luck
      \ Armorer
      \ Athletics
      \ Blade
      \ Block
      \ Blunt
      \ HandToHand
      \ HeavyArmor
      \ Alchemy
      \ Alteration
      \ Conjuration
      \ Destruction
      \ Illusion
      \ Mysticism
      \ Restoration
      \ Acrobatics
      \ LightArmor
      \ Marksman
      \ Mercantile
      \ Security
      \ Sneak
      \ Speechcraft
" }}}

<<<<<<< HEAD
" Block Type {{{
syn keyword obseBlockType
      \ GameMode
      \ LoadGame
      \ SaveGame
      \ PostLoadGame
      \ ExitGame
      \ ExitToMainMenu
      \ MenuMode
      \ QQQ
      \ OnNewGame
      \ OnActivate
=======
" Block Types {{{
syn keyword obseBlockType
      \ ExitGame
      \ ExitToMainMenu
      \ Function
      \ GameMode
      \ LoadGame
      \ MenuMode
      \ OnActivate
      \ OnActorDrop
>>>>>>> origin/main
      \ OnActorEquip
      \ OnActorUnequip
      \ OnAdd
      \ OnAlarm
      \ OnAlarmVictim
      \ OnAttack
      \ OnBlock
      \ OnBowAttack
      \ OnCreatePotion
      \ OnCreateSpell
      \ OnDeath
<<<<<<< HEAD
      \ OnDrinkPotion
      \ OnDrop
      \ OnDodge
      \ OnEatIngredient
      \ OnEnchant
      \ OnEquip
=======
      \ OnDodge
      \ OnDrinkPotion
      \ OnDrop
      \ OnEatIngredient
      \ OnEnchant
      \ OnEquip
      \ OnFallImpact
>>>>>>> origin/main
      \ OnHealthDamage
      \ OnHit
      \ OnHitWith
      \ OnKnockout
      \ OnLoad
<<<<<<< HEAD
      \ OnMagicEffectHit
      \ OnMapMarkerAdd
      \ OnMurder
      \ OnPackageChange
      \ OnPackageDone
      \ OnPackageStart
      \ OnRecoil
      \ OnRelease
      \ OnReset
      \ OnSell
      \ OnScriptedSkillUp
      \ OnScrollCast
      \ OnSkillUp
=======
      \ OnMagicApply
      \ OnMagicCast
      \ OnMagicEffectHit
      \ OnMapMarkerAdd
      \ OnMurder
      \ OnNewGame
      \ OnPackageChange
      \ OnPackageDone
      \ OnPackageStart
      \ OnQuestComplete
      \ OnRecoil
      \ OnRelease
      \ OnReset
      \ OnSaveIni
      \ OnScriptedSkillUp
      \ OnScrollCast
      \ OnSell
      \ OnSkillUp
      \ OnSoulTrap
>>>>>>> origin/main
      \ OnSpellCast
      \ OnStagger
      \ OnStartCombat
      \ OnTrigger
      \ OnTriggerActor
      \ OnTriggerMob
      \ OnUnequip
      \ OnVampireFeed
<<<<<<< HEAD
      \ ScriptEffectStart
      \ ScriptEffectFinish
      \ ScriptEffectUpdate
      \ Function
" }}}

" CS functions {{{
syn keyword csFunction
=======
      \ OnWaterDive
      \ OnWaterSurface
      \ PostLoadGame
      \ QQQ
      \ SaveGame
      \ ScriptEffectFinish
      \ ScriptEffectStart
      \ ScriptEffectUpdate
" }}}

" Functions {{{
syn keyword obseFunction
>>>>>>> origin/main
      \ Activate
      \ AddAchievement
      \ AddFlames
      \ AddItem
      \ AddScriptPackage
      \ AddSpell
      \ AddTopic
      \ AdvancePCLevel
      \ AdvancePCSkill
      \ Autosave
      \ CanHaveFlames
      \ CanPayCrimeGold
      \ Cast
      \ ClearOwnership
      \ CloseCurrentOblivionGate
      \ CloseOblivionGate
      \ CompleteQuest
      \ CreateFullActorCopy
      \ DeleteFullActorCopy
      \ Disable
      \ DisableLinkedPathPoints
      \ DisablePlayerControls
      \ Dispel
      \ DispelAllSpells
      \ Drop
      \ DropMe
      \ DuplicateAllItems
      \ DuplicateNPCStats
      \ Enable
      \ EnableFastTravel
      \ EnableLinkedPathPoints
      \ EnablePlayerControls
      \ EquipItem
      \ EssentialDeathReload
      \ EvaluatePackage	evp
      \ ForceActorValue
      \ ForceCloseOblivionGate
      \ ForceFlee
      \ ForceTakeCover
      \ ForceWeather
      \ GetActionRef
      \ GetActorValue
      \ GetAlarmed
      \ GetAmountSoldStolen
      \ GetAngle
      \ GetArmorRating
      \ GetArmorRatingUpperBody
      \ GetAttacked
      \ GetBarterGold
      \ GetBaseActorValue
      \ GetButtonPressed
      \ GetClassDefaultMatch
      \ GetClothingValue
      \ GetCombatTarget
      \ GetContainer
      \ GetCrime
      \ GetCrimeGold
      \ GetCrimeKnown
      \ GetCurrentAIPackage
      \ GetCurrentAIProcedure
      \ GetCurrentTime
      \ GetCurrentWeatherPercent
      \ GetDayOfWeek
      \ GetDead
      \ GetDeadCount
      \ GetDestroyed
      \ GetDetected
      \ GetDetectionLevel
      \ GetDisabled
      \ GetDisposition
      \ GetDistance
      \ GetDoorDefaultOpen
      \ GetEquipped
      \ GetFactionRank
      \ GetFactionRankDifference
      \ GetFactionReaction
      \ GetFatiquePercentage
      \ GetForceRun
      \ GetForceSneak
      \ GetFriendHit
      \ GetFurnitureMarkerID
      \ GetGameSetting
      \ GetGlobalValue
      \ GetGold
      \ GetHeadingAngle
      \ GetIdleDoneOnce
      \ GetIgnoreFriendlyHit
      \ GetInCell
      \ GetInCellParam
      \ GetInFaction
      \ GetInSameCell
<<<<<<< HEAD
      \ GetInvestmentGold
      \ GetInWorldspace
=======
      \ GetInWorldspace
      \ GetInvestmentGold
>>>>>>> origin/main
      \ GetIsAlerted
      \ GetIsClass
      \ GetIsClassDefault
      \ GetIsCreature
      \ GetIsCurrentPackage
      \ GetIsCurrentWeather
      \ GetIsGhost
      \ GetIsID
      \ GetIsPlayableRace
      \ GetIsPlayerBirthsign
      \ GetIsRace
      \ GetIsReference
      \ GetIsSex
      \ GetIsUsedItem
      \ GetIsUsedItemType
      \ GetItemCount
      \ GetKnockedState
<<<<<<< HEAD
      \ GetLevel
      \ GetLocked
      \ GetLockLevel
      \ GetLOS
=======
      \ GetLOS
      \ GetLevel
      \ GetLockLevel
      \ GetLocked
>>>>>>> origin/main
      \ GetMenuHasTrait
      \ GetName
      \ GetNoRumors
      \ GetOffersServicesNow
      \ GetOpenState
<<<<<<< HEAD
      \ GetPackageTarget
      \ GetParentRef
=======
>>>>>>> origin/main
      \ GetPCExpelled
      \ GetPCFactionAttack
      \ GetPCFactionMurder
      \ GetPCFactionSteal
      \ GetPCFactionSubmitAuthority
      \ GetPCFame
      \ GetPCInFaction
      \ GetPCInfamy
      \ GetPCIsClass
      \ GetPCIsRace
      \ GetPCIsSex
      \ GetPCMiscStat
      \ GetPCSleepHours
<<<<<<< HEAD
=======
      \ GetPackageTarget
      \ GetParentRef
>>>>>>> origin/main
      \ GetPersuasionNumber
      \ GetPlayerControlsDisabled
      \ GetPlayerHasLastRiddenHorse
      \ GetPlayerInSEWorld
      \ GetPos
      \ GetQuestRunning
      \ GetQuestVariable
      \ GetRandomPercent
      \ GetRestrained
      \ GetScale
      \ GetScriptedVariable
      \ GetSecondsPassed
      \ GetSelf
      \ GetShouldAttack
      \ GetSitting
      \ GetSleeping
      \ GetStage
      \ GetStageDone
      \ GetStartingAngle
      \ GetStartingPos
      \ GetTalkedToPC
      \ GetTalkedToPCParam
      \ GetTimeDead
      \ GetTotalPersuasionNumber
      \ GetTrespassWarningLevel
      \ GetUnconscious
      \ GetUsedItemActivate
      \ GetUsedItemLevel
      \ GetVampire
      \ GetWalkSpeed
      \ GetWeaponAnimType
      \ GetWeaponSkillType
      \ GetWindSpeed
      \ GoToJail
      \ HasFlames
      \ HasMagicEffect
      \ HasVampireFed
      \ IsActionRef
      \ IsActor
      \ IsActorAVictim
      \ IsActorDetected
      \ IsActorEvil
<<<<<<< HEAD
      \ IsActorsAIOff
      \ IsActorUsingATorch
=======
      \ IsActorUsingATorch
      \ IsActorsAIOff
>>>>>>> origin/main
      \ IsAnimPlayer
      \ IsCellOwner
      \ IsCloudy
      \ IsContinuingPackagePCNear
      \ IsCurrentFurnitureObj
      \ IsCurrentFurnitureRef
      \ IsEssential
      \ IsFacingUp
      \ IsGuard
      \ IsHorseStolen
      \ IsIdlePlaying
      \ IsInCombat
      \ IsInDangerousWater
      \ IsInInterior
      \ IsInMyOwnedCell
      \ IsLeftUp
      \ IsOwner
      \ IsPCAMurderer
      \ IsPCSleeping
      \ IsPlayerInJail
      \ IsPlayerMovingIntoNewSpace
      \ IsPlayersLastRiddenHorse
      \ IsPleasant
      \ IsRaining
      \ IsRidingHorse
      \ IsRunning
      \ IsShieldOut
      \ IsSneaking
      \ IsSnowing
      \ IsSpellTarget
      \ IsSwimming
      \ IsTalking
      \ IsTimePassing
      \ IsTorchOut
      \ IsTrespassing
      \ IsTurnArrest
      \ IsWaiting
      \ IsWeaponOut
      \ IsXBox
      \ IsYielding
      \ Kill
      \ KillAllActors
      \ Lock
      \ Look
      \ LoopGroup
      \ Message
      \ MessageBox
      \ ModActorValue
      \ ModAmountSoldStolen
      \ ModBarterGold
      \ ModCrimeGold
      \ ModDisposition
      \ ModFactionRank
      \ ModPCAttribute
      \ ModPCFame
      \ ModPCInfamy
      \ ModPCMiscStat
      \ ModPCSkill
      \ ModScale
      \ MoveTo
      \ MoveToMarker
      \ PayFine
      \ PayFineThief
      \ PickIdle
      \ PlaceItMe
      \ PlayBink
      \ PlayGroup
      \ PlayMagicEffectVisuals
      \ PlayMagicShaderVisuals
      \ PlaySound
      \ PlaySound3D
      \ PositionCell
      \ PositionWorld
      \ PreloadMagicEffect
      \ PurgeCellBuffer
      \ PushActorAway
      \ RefreshTopicList
      \ ReleaseWeatherOverride
      \ RemoveAllItems
      \ RemoveFlames
      \ RemoveItem
      \ RemoveMe
      \ RemoveScriptPackage
      \ RemoveSpell
      \ Reset3DState
      \ ResetFallDamageTimer
      \ ResetHealth
      \ ResetInterior
      \ Resurrect
      \ Rotate
      \ SameFaction
      \ SameFactionAsPC
      \ SameRace
      \ SameRaceAsPC
      \ SameSex
      \ SameSexAsPC
      \ Say
      \ SayTo
      \ ScriptEffectElapsedSeconds
      \ SelectPlayerSpell
      \ SendTrespassAlarm
      \ SetActorAlpha
      \ SetActorFullName
      \ SetActorRefraction
<<<<<<< HEAD
      \ SetActorsAI
      \ SetActorValue
=======
      \ SetActorValue
      \ SetActorsAI
>>>>>>> origin/main
      \ SetAlert
      \ SetAllReachable
      \ SetAllVisible
      \ SetAngle
      \ SetAtStart
      \ SetBarterGold
      \ SetCellFullName
      \ SetCellOwnership
      \ SetCellPublicFlag
      \ SetClass
      \ SetCombatStyle
      \ SetCrimeGold
      \ SetDestroyed
      \ SetDoorDefaultOpen
      \ SetEssential
      \ SetFactionRank
      \ SetFactionReaction
      \ SetForceRun
      \ SetForceSneak
      \ SetGhost
      \ SetIgnoreFriendlyHits
      \ SetInCharGen
      \ SetInvestmentGold
      \ SetItemValue
      \ SetLevel
      \ SetNoAvoidance
      \ SetNoRumors
      \ SetOpenState
      \ SetOwnership
<<<<<<< HEAD
      \ SetPackDuration
=======
>>>>>>> origin/main
      \ SetPCExpelled
      \ SetPCFactionAttack
      \ SetPCFactionMurder
      \ SetPCFactionSteal
      \ SetPCFactionSubmitAuthority
      \ SetPCFame
      \ SetPCInfamy
      \ SetPCSleepHours
<<<<<<< HEAD
      \ SetPlayerInSEWorld
      \ SetPlayerBirthsign
=======
      \ SetPackDuration
      \ SetPlayerBirthsign
      \ SetPlayerInSEWorld
>>>>>>> origin/main
      \ SetPos
      \ SetQuestObject
      \ SetRestrained
      \ SetRigidBloodMass
      \ SetScale
      \ SetScenelsComplex
      \ SetShowQuestItems
      \ SetSize
      \ SetStage
      \ SetUnconscious
      \ SetWeather
      \ ShowBirthsignMenu
      \ ShowClassMenu
      \ ShowDialogSubtitles
      \ ShowEnchantment
      \ ShowMap
      \ ShowRaceMenu
      \ ShowSpellMaking
      \ SkipAnim
      \ StartCombat
      \ StartConversation
      \ StartQuest
      \ StopCombat
      \ StopCombatAlarmOnActor
      \ StopLook
      \ StopMagicEffectVisuals
      \ StopMagicShaderVisuals
      \ StopQuest
      \ StopWaiting
      \ StreamMusic
      \ This
      \ ToggleActorsAU
      \ TrapUpdate
      \ TriggerHitShader
      \ UnequipItem
      \ Unlock
      \ VampireFeed
      \ Wait
      \ WakeUpPC
      \ WhichServiceMenu
      \ Yield
<<<<<<< HEAD
" }}}

" OBSE Functions {{{
syn keyword obseFunction
      \ Abs
      \ ACos
=======
      \ ACos
      \ AHammerKey
      \ ASin
      \ ATan
      \ ATan2
      \ Abs
>>>>>>> origin/main
      \ AddEffectItem
      \ AddEffectItemC
      \ AddFullEffectItem
      \ AddFullEffectItemC
      \ AddItemNS
      \ AddSpellNS
      \ AddToLeveledList
<<<<<<< HEAD
      \ AHammerKey
      \ AnimPathIncludes
      \ AppendToName
      \ ASin
      \ ATan
      \ ATan2
      \ CalcLeveledItem
      \ CanCorpseCheck
      \ Ceil
      \ Call
      \ ClearHotKey
      \ ClearLeveledList
=======
      \ AnimPathIncludes
      \ AppendToName
      \ AsciiToChar
      \ CalcLeveledItem
      \ Call
      \ CanCorpseCheck
      \ CanFastTravelFromWorld
      \ Ceil
      \ CharToAscii
      \ ClearHotKey
      \ ClearLeveledList
      \ ClearOwnership_T
      \ ClearPlayersLastRiddenHorse
>>>>>>> origin/main
      \ CloneForm
      \ CloseAllMenus
      \ CompareFemaleBipedPath
      \ CompareFemaleGroundPath
      \ CompareFemaleIconPath
      \ CompareIconPath
      \ CompareMaleBipedPath
      \ CompareMaleGroundPath
      \ CompareMaleIconPath
      \ CompareModelPath
      \ CompareName
      \ CompareNames
      \ CompareScripts
      \ Con_CAL
      \ Con_GetINISetting
      \ Con_HairTint
      \ Con_LoadGame
      \ Con_ModWaterShader
      \ Con_PlayerSpellBook
      \ Con_QuitGame
      \ Con_RefreshINI
      \ Con_RunMemoryPass
      \ Con_Save
      \ Con_SaveINI
      \ Con_SetCameraFOV
      \ Con_SetClipDist
      \ Con_SetFog
      \ Con_SetGameSetting
      \ Con_SetGamma
      \ Con_SetHDRParam
<<<<<<< HEAD
      \ Con_SetImageSpaceGlow
      \ Con_SetINISetting
=======
      \ Con_SetINISetting
      \ Con_SetImageSpaceGlow
>>>>>>> origin/main
      \ Con_SetSkyParam
      \ Con_SetTargetRefraction
      \ Con_SetTargetRefractionFire
      \ Con_SexChange
      \ Con_TCL
      \ Con_TFC
      \ Con_TGM
      \ Con_ToggleAI
      \ Con_ToggleCombatAI
      \ Con_ToggleDetection
      \ Con_ToggleMapMarkers
      \ Con_ToggleMenus
      \ Con_WaterDeepColor
      \ Con_WaterReflectionColor
      \ Con_WaterShallowColor
      \ CopyAllEffectItems
      \ CopyEyes
      \ CopyFemaleBipedPath
      \ CopyFemaleGroundPath
      \ CopyFemaleIconPath
      \ CopyHair
      \ CopyIconPath
      \ CopyMaleBipedPath
      \ CopyMaleGroundPath
      \ CopyMaleIconPath
      \ CopyModelPath
      \ CopyName
      \ CopyNthEffectItem
      \ Cos
      \ Cosh
      \ CreatureHasNoHead
      \ CreatureHasNoLeftArm
      \ CreatureHasNoMovement
      \ CreatureHasNoRightArm
      \ CreatureNoCombatInWater
      \ CreatureUsesWeaponAndShield
<<<<<<< HEAD
=======
      \ DebugPrint
>>>>>>> origin/main
      \ DisableControl
      \ DisableKey
      \ DisableMouse
      \ EnableControl
      \ EnableKey
      \ EnableMouse
      \ EquipItemNS
      \ EquipItemSilent
      \ Exp
      \ FactionHasSpecialCombat
      \ FileExists
      \ Floor
      \ Fmod
      \ GetActiveEffectCount
<<<<<<< HEAD
      \ GetActiveMenuFilter
      \ GetActiveMenuComponentID
      \ GetMessageBoxType
=======
      \ GetActiveMenuComponentID
      \ GetActiveMenuFilter
>>>>>>> origin/main
      \ GetActiveMenuMode
      \ GetActiveMenuObject
      \ GetActiveMenuRef
      \ GetActiveMenuSelection
<<<<<<< HEAD
      \ GetActiveUIComponentID
      \ GetActiveUIComponentFullName
      \ GetActiveUIComponentNAme
=======
      \ GetActiveUIComponentFullName
      \ GetActiveUIComponentID
      \ GetActiveUIComponentNAme
      \ GetActorBaseLevel
>>>>>>> origin/main
      \ GetActorLightAmount
      \ GetActorMaxLevel
      \ GetActorMinLevel
      \ GetActorSoulLevel
      \ GetActorValueC
      \ GetAltControl
      \ GetApparatusType
      \ GetArmorAR
      \ GetArmorType
      \ GetArrowProjectileBowEnchantment
      \ GetArrowProjectileEnchantment
      \ GetArrowProjectilePoison
      \ GetAttackDamage
      \ GetBaseObject
      \ GetBookCantBeTaken
      \ GetBookIsScroll
      \ GetBookSkillTaught
<<<<<<< HEAD
      \ GetCalcAllLevels
      \ GetCalcEachInCount
      \ GetCellMusicType
=======
      \ GetBoundingRadius
      \ GetCalcAllLevels
      \ GetCalcEachInCount
      \ GetCallingScript
      \ GetCellClimate
      \ GetCellLighting
      \ GetCellMusicType
      \ GetCellNorthRotation
      \ GetCellWaterType
>>>>>>> origin/main
      \ GetChanceNone
      \ GetClass
      \ GetClassAttribute
      \ GetClassSkill
      \ GetClassSpecialization
      \ GetClimateSunriseBegin
      \ GetClimateSunriseEnd
      \ GetClimateSunsetBegin
      \ GetClimateSunsetEnd
      \ GetClimateVolatility
      \ GetCloseSound
      \ GetContainerRespawns
      \ GetControl
      \ GetCreatureBaseScale
      \ GetCreatureCombatSkill
      \ GetCreatureFlies
      \ GetCreatureMagicSkill
      \ GetCreatureReach
      \ GetCreatureSoulLevel
      \ GetCreatureSound
      \ GetCreatureSoundBase
      \ GetCreatureStealthSkill
      \ GetCreatureSwims
      \ GetCreatureType
      \ GetCreatureWalks
      \ GetCrosshairRef
      \ GetCurrentCharge
      \ GetCurrentClimateID
      \ GetCurrentHealth
<<<<<<< HEAD
      \ GetCurrentSoulLevel
      \ GetCurrentWeatherID
      \ GetDebugSelection
=======
      \ GetCurrentPackageProcedure
      \ GetCurrentScript
      \ GetCurrentSoulLevel
      \ GetCurrentWeatherID
      \ GetDebugSelection
      \ GetEditorSize
      \ GetEnchMenuEnchItem
      \ GetEnchMenuSoulgem
>>>>>>> origin/main
      \ GetEnchantment
      \ GetEnchantmentCharge
      \ GetEnchantmentCost
      \ GetEnchantmentType
<<<<<<< HEAD
      \ GetEnchMenuEnchItem
      \ GetEnchMenuSoulgem
=======
>>>>>>> origin/main
      \ GetEquipmentSlot
      \ GetEquipmentSlotMask
      \ GetEquippedCurrentCharge
      \ GetEquippedCurrentHealth
      \ GetEquippedObject
<<<<<<< HEAD
      \ GetEquippedWeaponPoison
      \ GetEyes
      \ GetFallTimer
      \ GetFirstRef
      \ GetFPS
=======
      \ GetEquippedTorchTimeLeft
      \ GetEquippedWeaponPoison
      \ GetEyes
      \ GetFPS
      \ GetFallTimer
      \ GetFirstRef
>>>>>>> origin/main
      \ GetFullGoldValue
      \ GetGameLoaded
      \ GetGameRestarted
      \ GetGodMode
      \ GetGoldValue
      \ GetHair
      \ GetHairColor
<<<<<<< HEAD
      \ GetHorse
      \ GetHotKeyItem
      \ GetIgnoresResistance
      \ GetInventoryObject
      \ GetIngredient
      \ GetKeyPress
      \ GetLevItemByLevel
      \ GetLightRadius
      \ GetLinkedDoor
      \ GetLoopSound
      \ GetMagicEffectBarterFactor
      \ GetMagicEffectBaseCost
      \ GetMagicEffectCode
      \ GetMagicEffectChars
      \ GetMagicEffectCharsC
      \ MagicEffectCodeFromChars
      \ MagicEffectFromChars
      \ MagicEffectFromCode
      \ GetMagicEffectEnchantFactor
      \ GetMagicEffectOtherActorValue
      \ GetMagicEffectOtherActorValueC
      \ GetMagicEffectName
      \ GetMagicEffectNameC
      \ GetMagicEffectIcon
      \ GetMagicEffectIconC
      \ GetMagicEffectModel
      \ GetMagicEffectModelC
      \ SetMagicEffectName
      \ SetMagicEffectNameC
      \ SetMagicEffectIcon
      \ SetMagicEffectIconC
      \ SetMagicEffectModel
      \ SetMagicEffectModelC
      \ GetMagicEffectHitShader
      \ GetMagicEffectHitShaderC
      \ GetMagicEffectEnchantShader
      \ GetMagicEffectEnchantShaderC
      \ GetMagicEffectLight
      \ GetMagicEffectLightC
      \ GetMagicEffectCastingSound
      \ GetMagicEffectCastingSoundC
      \ GetMagicEffectBoltSound
      \ GetMagicEffectBoltSoundC
      \ GetMagicEffectHitSound
      \ GetMagicEffectHitSoundC
      \ GetMagicEffectAreaSound
      \ GetMagicEffectAreaSoundC
      \ SetMagicEffectCastingSound
      \ SetMagicEffectCastingSoundC
      \ SetMagicEffectBoltSound
      \ SetMagicEffectBoltSoundC
      \ SetMagicEffectHitSound
      \ SetMagicEffectHitSoundC
      \ SetMagicEffectAreaSound
      \ SetMagicEffectAreaSoundC
      \ SetMagicEffectLight
      \ SetMagicEffectLightC
      \ SetMagicEffectUsedObject
      \ SetMagicEffectUsedObjectC
      \ SetMagicEffectHitShader
      \ SetMagicEffectHitShaderC
      \ SetMagicEffectEnchantShader
      \ SetMagicEffectEnchantShaderC
      \ GetMagicEffectNumCounters
      \ GetMagicEffectNumCountersC
      \ GetMagicEffectResistValue
      \ GetMagicEffectResistValueC
      \ GetNthMagicEffectCounter
      \ GetNthMagicEffectCounterC
      \ SetMagicEffectIsHostile
      \ SetMagicEffectIsHostileC
      \ SetMagicEffectCanRecover
      \ SetMagicEffectCanRecoverC
      \ SetMagicEffectIsDetrimental
      \ SetMagicEffectIsDetrimentalC
      \ SetMagicEffectMagnitudePercent
      \ SetMagicEffectMagnitudePercentC
      \ SetMagicEffectOnSelfAllowed
      \ SetMagicEffectOnSelfAllowedC
      \ SetMagicEffectOnTouchAllowed
      \ SetMagicEffectOnTouchAllowedC
      \ SetMagicEffectOnTargetAllowed
      \ SetMagicEffectOnTargetAllowedC
      \ SetMagicEffectNoDuration
      \ SetMagicEffectNoDurationC
      \ SetMagicEffectNoMagnitude
      \ SetMagicEffectNoMagnitudeC
      \ SetMagicEffectNoArea
      \ SetMagicEffectNoAreaC
      \ SetMagicEffectFXPersists
      \ SetMagicEffectFXPersistsC
      \ SetMagicEffectForSpellmaking
      \ SetMagicEffectForSpellmakingC
      \ SetMagicEffectForEnchanting
      \ SetMagicEffectForEnchantingC
      \ SetMagicEffectNoIngredient
      \ SetMagicEffectNoIngredientC
      \ SetMagicEffectUsesWeapon
      \ SetMagicEffectUsesWeaponC
      \ SetMagicEffectUsesArmor
      \ SetMagicEffectUsesArmorC
      \ SetMagicEffectUsesCreature
      \ SetMagicEffectUsesCreatureC
      \ SetMagicEffectUsesSkill
      \ SetMagicEffectUsesSkillC
      \ SetMagicEffectUsesAttribute
      \ SetMagicEffectUsesAttributeC
      \ SetMagicEffectUsesActorValue
      \ SetMagicEffectUsesActorValueC
      \ SetMagicEffectNoHitEffect
      \ SetMagicEffectNoHitEffectC
      \ SetMagicEffectSchool
      \ SetMagicEffectSchoolC
      \ SetMagicEffectBaseCost
      \ SetMagicEffectBaseCostC
      \ SetMagicEffectResistValue
      \ SetMagicEffectResistValueC
      \ SetMagicEffectEnchantFactor
      \ SetMagicEffectEnchantFactorC
      \ SetMagicEffectBarterFactor
      \ SetMagicEffectBarterFactorC
      \ SetMagicEffectProjectileSpeed
      \ SetMagicEffectProjectileSpeedC
      \ SetMagicEffectOtherActorValue
      \ SetMagicEffectOtherActorValueC
      \ GetMagicEffectProjectileSpeed
=======
      \ GetHighActors
      \ GetHorse
      \ GetHotKeyItem
      \ GetIgnoresResistance
      \ GetIngredient
      \ GetInventoryObject
      \ GetKeyName
      \ GetKeyPress
      \ GetLevItemByLevel
      \ GetLightDuration
      \ GetLightRadius
      \ GetLinkedDoor
      \ GetLocalGravity
      \ GetLoopSound
      \ GetMagicEffectAreaSound
      \ GetMagicEffectAreaSoundC
      \ GetMagicEffectBarterFactor
      \ GetMagicEffectBaseCost
      \ GetMagicEffectBoltSound
      \ GetMagicEffectBoltSoundC
      \ GetMagicEffectCastingSound
      \ GetMagicEffectCastingSoundC
      \ GetMagicEffectChars
      \ GetMagicEffectCharsC
      \ GetMagicEffectCode
      \ GetMagicEffectEnchantFactor
      \ GetMagicEffectEnchantShader
      \ GetMagicEffectEnchantShaderC
      \ GetMagicEffectHitShader
      \ GetMagicEffectHitShaderC
      \ GetMagicEffectHitSound
      \ GetMagicEffectHitSoundC
      \ GetMagicEffectIcon
      \ GetMagicEffectIconC
      \ GetMagicEffectLight
      \ GetMagicEffectLightC
      \ GetMagicEffectModel
      \ GetMagicEffectModelC
      \ GetMagicEffectName
      \ GetMagicEffectNameC
      \ GetMagicEffectNumCounters
      \ GetMagicEffectNumCountersC
      \ GetMagicEffectOtherActorValue
      \ GetMagicEffectOtherActorValueC
      \ GetMagicEffectProjectileSpeed
      \ GetMagicEffectResistValue
      \ GetMagicEffectResistValueC
>>>>>>> origin/main
      \ GetMagicEffectSchool
      \ GetMagicEffectUsedObject
      \ GetMagicEffectUsedObjectC
      \ GetMagicItemEffectCount
      \ GetMagicItemType
      \ GetMagicProjectileSpell
<<<<<<< HEAD
      \ GetMerchantContainer
      \ GetModIndex
      \ GetMouseButtonPress
      \ GetNextRef
=======
      \ GetMapMarkers
      \ GetMerchantContainer
      \ GetMessageBoxType
      \ GetMiddleHighActors
      \ GetModIndex
      \ GetMouseButtonPress
      \ GetNextRef
      \ GetNthAcitveEffectMagnitude
      \ GetNthActiveEffectActorValue
>>>>>>> origin/main
      \ GetNthActiveEffectCaster
      \ GetNthActiveEffectCode
      \ GetNthActiveEffectData
      \ GetNthActiveEffectDuration
      \ GetNthActiveEffectMagicItem
      \ GetNthActiveEffectMagicItemIndex
<<<<<<< HEAD
      \ GetNthAcitveEffectMagnitude
      \ GetNthActiveEffectTimeElapsed
      \ GetNthChildRef
      \ GetNthDetectedActor
=======
      \ GetNthActiveEffectTimeElapsed
      \ GetNthChildRef
      \ GetNthDetectedActor
      \ GetNthEffectItem
>>>>>>> origin/main
      \ GetNthEffectItemActorValue
      \ GetNthEffectItemArea
      \ GetNthEffectItemCode
      \ GetNthEffectItemDuration
      \ GetNthEffectItemMagnitude
      \ GetNthEffectItemName
      \ GetNthEffectItemRange
      \ GetNthEffectItemScript
      \ GetNthEffectItemScriptName
      \ GetNthEffectItemScriptSchool
      \ GetNthEffectItemScriptVisualEffect
      \ GetNthFaction
      \ GetNthFollower
      \ GetNthLevItem
      \ GetNthLevItemCount
      \ GetNthLevItemLevel
<<<<<<< HEAD
=======
      \ GetNthMagicEffectCounter
      \ GetNthMagicEffectCounterC
>>>>>>> origin/main
      \ GetNthPackage
      \ GetNthPlayerSpell
      \ GetNthRaceBonusSkill
      \ GetNthRaceSpell
      \ GetNthSpell
      \ GetNumChildRefs
      \ GetNumDetectedActors
<<<<<<< HEAD
      \ GetNumericINISetting
=======
>>>>>>> origin/main
      \ GetNumFactions
      \ GetNumFollowers
      \ GetNumItems
      \ GetNumKeysPressed
      \ GetNumLevItems
      \ GetNumLoadedMods
      \ GetNumMouseButtonsPressed
      \ GetNumPackages
      \ GetNumRanks
      \ GetNumRefs
<<<<<<< HEAD
      \ GetObjectCharge
      \ GetObjectHealth
      \ GetObjectType
      \ GetOBSERevision
      \ GetOBSEVersion
=======
      \ GetNumericINISetting
      \ GetOBSERevision
      \ GetOBSEVersion
      \ GetObjectCharge
      \ GetObjectHealth
      \ GetObjectType
>>>>>>> origin/main
      \ GetOpenKey
      \ GetOpenSound
      \ GetOwner
      \ GetOwningFactionRank
<<<<<<< HEAD
=======
      \ GetPCAttributeBonus
      \ GetPCMajorSkillUps
>>>>>>> origin/main
      \ GetParentCell
      \ GetParentCellOwner
      \ GetParentCellOwningFactionRank
      \ GetParentCellWaterHeight
<<<<<<< HEAD
      \ GetPCAttributeBonus
      \ GetPCMajorSkillUps
      \ GetPlayerSkillUse
      \ GetPlayersLastActivatedLoadDoor
      \ GetPlayersLastRiddenHorse
      \ GetPlayerSpell
      \ GetPlayerBirthsign
      \ GetPlyerSpellCount
      \ GetPluginVersion
=======
      \ GetPathNodeLinkedRef
      \ GetPathNodePos
      \ GetPathNodesInRadius
      \ GetPathNodesInRect
      \ GetPlayerBirthsign
      \ GetPlayerSkillUse
      \ GetPlayerSpell
      \ GetPlayersLastActivatedLoadDoor
      \ GetPlayersLastRiddenHorse
      \ GetPluginVersion
      \ GetPlyerSpellCount
>>>>>>> origin/main
      \ GetProcessLevel
      \ GetProjectileSource
      \ GetProjectileType
      \ GetQuality
      \ GetRace
      \ GetRaceAttribute
      \ GetRaceAttributeC
      \ GetRaceSkillBonus
      \ GetRaceSkillBonusC
      \ GetRaceSpellCount
<<<<<<< HEAD
      \ GetRefCount
      \ GetRefVariable
=======
      \ GetRaceVoice
      \ GetRefCount
      \ GetRefVariable
      \ GetRequiredSkillExp
>>>>>>> origin/main
      \ GetRider
      \ GetScript
      \ GetScriptActiveEffectIndex
      \ GetServicesMask
<<<<<<< HEAD
=======
      \ GetSkillSpecialization
>>>>>>> origin/main
      \ GetSkillUseIncrement
      \ GetSoulGemCapacity
      \ GetSoulLevel
      \ GetSourceModIndex
      \ GetSpellCount
      \ GetSpellExplodesWithNoTarget
      \ GetSpellHostile
      \ GetSpellMagickaCost
      \ GetSpellMasteryLevel
      \ GetSpellSchool
<<<<<<< HEAD
      \ GetSpells
      \ GetSpellType
      \ GetTexturePath
      \ GetTeleportCell	
      \ GetTotalActiveEffectMagnitude
=======
      \ GetSpellType
      \ GetSpells
      \ GetTeleportCell	
      \ GetTerrainHeight
      \ GetTexturePath
      \ GetTimeLeft
>>>>>>> origin/main
      \ GetTotalAEAbilityMagnitude
      \ GetTotalAEAlchemyMagnitude
      \ GetTotalAEAllSpellsMagnitude
      \ GetTotalAEDiseaseMagnitude
      \ GetTotalAEEnchantmentMagnitude
      \ GetTotalAELesserPowerMagnitude
      \ GetTotalAENonAbilityMagnitude
      \ GetTotalAEPowerMagnitude
      \ GetTotalAESpellMagnitude
<<<<<<< HEAD
=======
      \ GetTotalActiveEffectMagnitude
>>>>>>> origin/main
      \ GetTotalPCAttributeBonus
      \ GetTrainerLevel
      \ GetTrainerSkill
      \ GetTravelHorse
      \ GetVariable
<<<<<<< HEAD
      \ GetWeaponReach
      \ GetWeaponSpeed
      \ GetWeaponType
      \ GetWeatherCloudSpeedLower
      \ GetWeahterCloudSpeedUpper
=======
      \ GetVelocity
      \ GetVerticalVelocity
      \ GetWeahterCloudSpeedUpper
      \ GetWeaponReach
      \ GetWeaponSpeed
      \ GetWeaponType
      \ GetWeatherCloudSpeedLower
>>>>>>> origin/main
      \ GetWeatherColor
      \ GetWeatherFogDayFar
      \ GetWeatherFogDayNear
      \ GetWeatherFogNightFar
      \ GetWeatherFogNightNear
      \ GetWeatherHDRValue
      \ GetWeatherLightningFrequency
      \ GetWeatherSunDamage
      \ GetWeatherSunGlare
      \ GetWeatherTransDelta
      \ GetWeatherWindSpeed
      \ GetWeight
      \ Goto
      \ HammerKey
      \ HasBeenPickedUp
<<<<<<< HEAD
=======
      \ HasEffectShader
>>>>>>> origin/main
      \ HasLowLevelProcessing
      \ HasModel
      \ HasName
      \ HasNoPersuasion
      \ HasSpell
      \ HasVariable
      \ HoldKey
      \ IncrementPlayerSkillUse
      \ IsActivatable
      \ IsActivator
      \ IsActorRespawning
      \ IsAlchemyItem
      \ IsAmmo
      \ IsAnimGroupPlaying
      \ IsApparatus
      \ IsArmor
      \ IsAttacking
<<<<<<< HEAD
=======
      \ IsAutomaticDoor
>>>>>>> origin/main
      \ IsBarterMenuActive
      \ IsBipedIconPathValid
      \ IsBipedModelPathValid
      \ IsBlocking
      \ IsBook
      \ IsCasting
<<<<<<< HEAD
=======
      \ IsCellPublic
>>>>>>> origin/main
      \ IsClassAttribute
      \ IsClassSkill
      \ IsClonedForm
      \ IsClothing
      \ IsContainer
      \ IsControlPressed
      \ IsCreature
      \ IsCreatureBiped
<<<<<<< HEAD
=======
      \ IsDigit
>>>>>>> origin/main
      \ IsDodging
      \ IsDoor
      \ IsFactionEvil
      \ IsFactionHidden
<<<<<<< HEAD
      \ IsFlying
      \ IsFlora
=======
      \ IsFlora
      \ IsFlying
>>>>>>> origin/main
      \ IsFood
      \ IsFormValid
      \ IsFurniture
      \ IsGlobalCollisionDisabled
      \ IsHarvested
<<<<<<< HEAD
      \ IsIconPathValid
      \ IsInAir
=======
      \ IsHiddenDoor
      \ IsIconPathValid
      \ IsInAir
      \ IsInOblivion
>>>>>>> origin/main
      \ IsIngredient
      \ IsJumping
      \ IsKey
      \ IsKeyPressed
      \ IsKeyPressed2
      \ IsKeyPressed3
<<<<<<< HEAD
=======
      \ IsLetter
>>>>>>> origin/main
      \ IsLight
      \ IsLightCarriable
      \ IsLoadDoor
      \ IsMagicEffectCanRecover
      \ IsMagicEffectCanRecoverC
      \ IsMagicEffectDetrimental
      \ IsMagicEffectDetrimentalC
      \ IsMagicEffectForEnchanting
      \ IsMagicEffectForEnchantingC
      \ IsMagicEffectForSpellmaking
      \ IsMagicEffectForSpellmakingC
      \ IsMagicEffectHostile
      \ IsMagicEffectMagnitudePercent
      \ IsMagicEffectMagnitudePercentC
      \ IsMagicEffectOnSelfAllowed
      \ IsMagicEffectOnSelfAllowedC
      \ IsMagicEffectOnTargetAllowed
      \ IsMagicEffectOnTargetAllowedC
      \ IsMagicEffectOnTouchAllowed
      \ IsMagicEffectOnTouchAllowedC
      \ IsMagicItemAutoCalc
<<<<<<< HEAD
      \ IsModelPathValid
      \ IsModLoaded
=======
      \ IsMinimalUseDoor
      \ IsModLoaded
      \ IsModelPathValid
>>>>>>> origin/main
      \ IsMovingBackward
      \ IsMovingForward
      \ IsMovingLeft
      \ IsMovingRight
<<<<<<< HEAD
      \ IsNthEffectItemScripted
      \ IsNthEffectItemScriptHostile
      \ IsOffLimits
      \ IsOnGround
      \ IsPCLevelOffset
=======
      \ IsNthActiveEffectApplied
      \ IsNthEffectItemScriptHostile
      \ IsNthEffectItemScripted
      \ IsOblivionInterior
      \ IsOblivionWorld
      \ IsOffLimits
      \ IsOnGround
      \ IsPCLevelOffset
      \ IsPathNodeDisabled
>>>>>>> origin/main
      \ IsPersistent
      \ IsPlayable
      \ IsPlayable2
      \ IsPluginInstalled
      \ IsPoison
      \ IsPowerAttacking
<<<<<<< HEAD
=======
      \ IsPrintable
      \ IsPunctuation
>>>>>>> origin/main
      \ IsQuestItem
      \ IsRaceBonusSkill
      \ IsRaceBonusSkillC
      \ IsRecoiling
<<<<<<< HEAD
      \ IsReference
      \ IsRefEssential
=======
      \ IsRefEssential
      \ IsReference
>>>>>>> origin/main
      \ IsScripted
      \ IsSigilStone
      \ IsSoulGem
      \ IsStaggered
      \ IsSummonable
      \ IsThirdPerson
      \ IsTurningLeft
      \ IsTurningRight
      \ IsUnderWater
<<<<<<< HEAD
=======
      \ IsUppercase
>>>>>>> origin/main
      \ IsWeapon
      \ Label
      \ LeftShift
      \ Log
      \ Log10
      \ LogicalAnd
      \ LogicalNot
      \ LogicalOr
      \ LogicalXor
<<<<<<< HEAD
      \ MagicEffectFXPersists
      \ MagicEffectFXPersistsC
=======
      \ MagicEffectCodeFromChars
      \ MagicEffectFXPersists
      \ MagicEffectFXPersistsC
      \ MagicEffectFromChars
      \ MagicEffectFromCode
>>>>>>> origin/main
      \ MagicEffectHasNoArea
      \ MagicEffectHasNoAreaC
      \ MagicEffectHasNoDuration
      \ MagicEffectHasNoDurationC
      \ MagicEffectHasNoHitEffect
      \ MagicEffectHasNoHitEffectC
      \ MagicEffectHasNoIngredient
      \ MagicEffectHasNoIngredientC
      \ MagicEffectHasNoMagnitude
      \ MagicEffectHasNoMagnitudeC
      \ MagicEffectUsesArmor
      \ MagicEffectUsesArmorC
      \ MagicEffectUsesAttribute
      \ MagicEffectUsesAttributeC
      \ MagicEffectUsesCreature
      \ MagicEffectUsesCreatureC
      \ MagicEffectUsesOtherActorValue
      \ MagicEffectUsesOtherActorValueC
      \ MagicEffectUsesSkill
      \ MagicEffectUsesSkillC
      \ MagicEffectUsesWeapon
      \ MagicEffectUsesWeaponC
      \ MagicItemHasEffect
      \ MagicItemHasEffectCode
      \ MagicItemHasEffectCount
      \ MagicItemHasEffectCountCode
      \ MagicItemHasEffectItemScript
      \ MenuHoldKey
      \ MenuReleaseKey
      \ MenuTapKey
      \ MessageBoxEx
      \ MessageEx
      \ ModActorValue2
      \ ModActorValueC
      \ ModArmorAR
      \ ModAttackDamage
      \ ModEnchantmentCharge
      \ ModEquippedCurrentCharge
      \ ModEquippedCurrentHealth
      \ ModFemaleBipedPath
      \ ModFemaleGroundPath
      \ ModFemaleIconPath
      \ ModGoldValue
      \ ModIconPath
      \ ModMaleBipedPath
      \ ModMaleGroundPath
      \ ModMaleIconPath
      \ ModModelPath
      \ ModName
      \ ModNthActiveEffectMagnitude
      \ ModNthEffectItemArea
      \ ModNthEffectItemDuration
      \ ModNthEffectItemMagnitude
      \ ModNthEffectItemScriptName
      \ ModObjectCharge
      \ ModObjectHealth
      \ ModQuality
      \ ModSpellMagickaCost
      \ ModWeaponReach
      \ ModWeaponSpeed
      \ ModWeight
      \ MoveMouseX
      \ MoveMouseY
      \ NameIncludes
<<<<<<< HEAD
=======
      \ NumToHex
>>>>>>> origin/main
      \ OffersApparatus
      \ OffersArmor
      \ OffersBooks
      \ OffersClothing
      \ OffersIngredients
      \ OffersLights
      \ OffersMagicItems
      \ OffersMiscItems
      \ OffersPotions
      \ OffersRecharging
      \ OffersRepair
      \ OffersServicesC
      \ OffersSpells
      \ OffersTraining
      \ OffersWeapons
      \ OnControlDown
      \ OnKeyDown
      \ ParentCellHasWater
<<<<<<< HEAD
      \ Pow
      \ PrintToConsole
      \ PrintActiveTileInfo
      \ DebugPrint
      \ SetDebugMode
      \ Print
      \ PrintC
=======
      \ PathEdgeExists
      \ PlayIdle
      \ Pow
      \ Print
      \ PrintActiveTileInfo
      \ PrintC
      \ PrintToConsole
>>>>>>> origin/main
      \ Rand
      \ RefreshControlMap
      \ RefreshCurrentClimate
      \ ReleaseKey
      \ RemoveAllEffectItems
      \ RemoveEnchantment
      \ RemoveEquippedWeaponPoison
      \ RemoveFromLeveledList
      \ RemoveItemNS
      \ RemoveLevItemByLevel
      \ RemoveMeIR
      \ RemoveNthEffectItem
      \ RemoveScript
      \ RemoveSpellNS
<<<<<<< HEAD
=======
      \ ResolveModIndex
>>>>>>> origin/main
      \ RestoreIP
      \ RightShift
      \ RunBatchScript
      \ SaveIP
      \ SetActorRespawns
      \ SetActorValueC
      \ SetApparatusType
      \ SetArmorAR
      \ SetArmorType
      \ SetAttackDamage
      \ SetBookCantBeTaken
      \ SetBookIsScroll
      \ SetBookSkillTaught
      \ SetButtonPressed
      \ SetCanCorpseCheck
<<<<<<< HEAD
=======
      \ SetCanFastTravelFromWorld
      \ SetCellBehavesAsExterior
      \ SetCellClimate
      \ SetCellHasWater
      \ SetCellIsPublic
      \ SetCellLighting
      \ SetCellWaterType
>>>>>>> origin/main
      \ SetClimateHasMassser
      \ SetClimateHasSecunda
      \ SetClimateMoonPhaseLength
      \ SetClimateSunsetBegin
      \ SetClimateSunsetEnd
      \ SetClimateVolatility
      \ SetCloseSound
      \ SetContainerRespawns
<<<<<<< HEAD
      \ SetCurrentSoulLevel
=======
      \ SetCreatureSkill
      \ SetCurrentSoulLevel
      \ SetDebugMode
>>>>>>> origin/main
      \ SetDetectionState
      \ SetDisableGlobalCollision
      \ SetEnchantment
      \ SetEnchantmentCharge
      \ SetEnchantmentCost
      \ SetEnchantmentType
      \ SetEquipmentSlot
      \ SetEquippedCurrentCharge
      \ SetEquippedCurrentHealth
      \ SetEquippedWeaponPoison
      \ SetEventHandler
      \ SetEyes
      \ SetFactionEvil
      \ SetFactionHidden
      \ SetFactionSpecialCombat
      \ SetFemaleBipedPath
      \ SetFemaleGroundPath
      \ SetFemaleIconPath
      \ SetGoldValue
<<<<<<< HEAD
=======
      \ SetGoldValue_T
>>>>>>> origin/main
      \ SetHair
      \ SetHarvested
      \ SetHasBeenPickedUp
      \ SetHotKeyItem
      \ SetIconPath
      \ SetIgnoresResistance
<<<<<<< HEAD
      \ SetIsFood
      \ SetIsPlayable
      \ SetLightRadius
      \ SetLoopSound
      \ SetLowLevelProcessing
=======
      \ SetInputText
      \ SetIsAutomaticDoor
      \ SetIsFood
      \ SetIsHiddenDoor
      \ SetIsMinimalUseDoor
      \ SetIsOblivionGate
      \ SetIsPlayable
      \ SetLightDuration
      \ SetLightRadius
      \ SetLocalGravity
      \ SetLocalGravityVector
      \ SetLoopSound
      \ SetLowLevelProcessing
      \ SetMagicEffectAreaSound
      \ SetMagicEffectAreaSoundC
      \ SetMagicEffectBarterFactor
      \ SetMagicEffectBarterFactorC
      \ SetMagicEffectBaseCost
      \ SetMagicEffectBaseCostC
      \ SetMagicEffectBoltSound
      \ SetMagicEffectBoltSoundC
      \ SetMagicEffectCanRecover
      \ SetMagicEffectCanRecoverC
      \ SetMagicEffectCastingSound
      \ SetMagicEffectCastingSoundC
      \ SetMagicEffectEnchantFactor
      \ SetMagicEffectEnchantFactorC
      \ SetMagicEffectEnchantShader
      \ SetMagicEffectEnchantShaderC
      \ SetMagicEffectFXPersists
      \ SetMagicEffectFXPersistsC
      \ SetMagicEffectForEnchanting
      \ SetMagicEffectForEnchantingC
      \ SetMagicEffectForSpellmaking
      \ SetMagicEffectForSpellmakingC
      \ SetMagicEffectHitShader
      \ SetMagicEffectHitShaderC
      \ SetMagicEffectHitSound
      \ SetMagicEffectHitSoundC
      \ SetMagicEffectIcon
      \ SetMagicEffectIconC
      \ SetMagicEffectIsDetrimental
      \ SetMagicEffectIsDetrimentalC
      \ SetMagicEffectIsHostile
      \ SetMagicEffectIsHostileC
      \ SetMagicEffectLight
      \ SetMagicEffectLightC
      \ SetMagicEffectMagnitudePercent
      \ SetMagicEffectMagnitudePercentC
      \ SetMagicEffectModel
      \ SetMagicEffectModelC
      \ SetMagicEffectName
      \ SetMagicEffectNameC
      \ SetMagicEffectNoArea
      \ SetMagicEffectNoAreaC
      \ SetMagicEffectNoDuration
      \ SetMagicEffectNoDurationC
      \ SetMagicEffectNoHitEffect
      \ SetMagicEffectNoHitEffectC
      \ SetMagicEffectNoIngredient
      \ SetMagicEffectNoIngredientC
      \ SetMagicEffectNoMagnitude
      \ SetMagicEffectNoMagnitudeC
      \ SetMagicEffectOnSelfAllowed
      \ SetMagicEffectOnSelfAllowedC
      \ SetMagicEffectOnTargetAllowed
      \ SetMagicEffectOnTargetAllowedC
      \ SetMagicEffectOnTouchAllowed
      \ SetMagicEffectOnTouchAllowedC
      \ SetMagicEffectOtherActorValue
      \ SetMagicEffectOtherActorValueC
      \ SetMagicEffectProjectileSpeed
      \ SetMagicEffectProjectileSpeedC
      \ SetMagicEffectResistValue
      \ SetMagicEffectResistValueC
      \ SetMagicEffectSchool
      \ SetMagicEffectSchoolC
      \ SetMagicEffectUsedObject
      \ SetMagicEffectUsedObjectC
      \ SetMagicEffectUsesActorValue
      \ SetMagicEffectUsesActorValueC
      \ SetMagicEffectUsesArmor
      \ SetMagicEffectUsesArmorC
      \ SetMagicEffectUsesAttribute
      \ SetMagicEffectUsesAttributeC
      \ SetMagicEffectUsesCreature
      \ SetMagicEffectUsesCreatureC
      \ SetMagicEffectUsesSkill
      \ SetMagicEffectUsesSkillC
      \ SetMagicEffectUsesWeapon
      \ SetMagicEffectUsesWeaponC
>>>>>>> origin/main
      \ SetMagicItemAutoCalc
      \ SetMaleBipedPath
      \ SetMaleGroundPath
      \ SetMaleIconPath
      \ SetMenuFloatValue
      \ SetMenuStringValue
      \ SetMerchantContainer
      \ SetMessageIcon
      \ SetMessageSound
      \ SetModelPath
      \ SetMouseSpeedX
      \ SetMouseSpeedY
      \ SetName
      \ SetNameEx
      \ SetNoPersuasion
      \ SetNthActiveEffectMagnitude
      \ SetNthEffectItemActorValue
      \ SetNthEffectItemArea
      \ SetNthEffectItemDuration
      \ SetNthEffectItemMagnitude
      \ SetNthEffectItemRange
      \ SetNthEffectItemScript
      \ SetNthEffectItemScriptHostile
      \ SetNthEffectItemScriptName
      \ SetNthEffectItemScriptSchool
      \ SetNthEffectItemScriptVisualEffect
      \ SetNthEffectItemScriptVisualEffectC
      \ SetNumericGameSetting
      \ SetNumericINISetting
      \ SetObjectCharge
      \ SetObjectHealth
      \ SetOffersApparatus
      \ SetOffersArmor
      \ SetOffersBooks
      \ SetOffersClothing
      \ SetOffersIngredients
      \ SetOffersLights
      \ SetOffersMagicItems
      \ SetOffersMiscItems
      \ SetOffersPotions
      \ SetOffersRecharging
      \ SetOffersRepair
      \ SetOffersServicesC
      \ SetOffersSpells
      \ SetOffersTraining
      \ SetOffersWeapons
      \ SetOpenKey
      \ SetOpenSound
<<<<<<< HEAD
      \ SetPCAMurderer
      \ SetPCLevelOffset
      \ SetPlayerProjectile
      \ SetQuality
      \ SetQuestItem
=======
      \ SetOwnership_T
      \ SetPCAMurderer
      \ SetPCLevelOffset
      \ SetPathNodeDisabled
      \ SetPlayerProjectile
      \ SetPlayersLastRiddenHorse
      \ SetPos_T
      \ SetQuality
      \ SetQuestItem
      \ SetRaceScale
      \ SetRaceWeight
>>>>>>> origin/main
      \ SetRefCount
      \ SetRefEssential
      \ SetScaleEx
      \ SetScript
<<<<<<< HEAD
=======
      \ SetSkillSpecialization
>>>>>>> origin/main
      \ SetSkillUseIncrement
      \ SetSoulGemCapacity
      \ SetSoulLevel
      \ SetSpellExplodesWithNoTarget
      \ SetSpellHostile
      \ SetSpellMagickaCost
      \ SetSpellMasteryLevel
      \ SetSpellType
      \ SetSummonable
<<<<<<< HEAD
      \ SetTrainerLevel
      \ SetTrainerSkill
      \ SetTravelHorse
=======
      \ SetTextInputControlHandler
      \ SetTextInputDefaultControlsDisabled
      \ SetTimeLeft
      \ SetTrainerLevel
      \ SetTrainerSkill
      \ SetTravelHorse
      \ SetVelocity
      \ SetVerticalVelocity
>>>>>>> origin/main
      \ SetWeaponReach
      \ SetWeaponSpeed
      \ SetWeaponType
      \ SetWeatherCloudSpeedLower
      \ SetWeatherCloudSpeedUpper
      \ SetWeatherColor
      \ SetWeatherFogDayFar
      \ SetWeatherFogDayNear
      \ SetWeatherFogNightFar
      \ SetWeatherFogNightNear
      \ SetWeatherHDRValue
      \ SetWeatherLightningFrequency
      \ SetWeatherSunDamage
      \ SetWeatherSunGlare
      \ SetWeatherTransDelta
      \ SetWeatherWindSpeed
      \ SetWeight
      \ Sin
      \ Sinh
      \ SquareRoot
      \ Tan
      \ Tanh
      \ TapControl
      \ TapKey
<<<<<<< HEAD
      \ ToggleCreatureModel
      \ UnequipItemNS
      \ UnequipItemSilent
      \ UnHammerKey
      \ ToggleSkillPerk
      \ GetCellNorthRotation
      \ GetActorBaseLevel
      \ SetGoldValue_T
      \ SetRaceScale
      \ SetRaceWeight
      \ GetLocalGravity
      \ SetLocalGravity
      \ SetLocalGravityVector
      \ GetVelocity
      \ SetVelocity
      \ GetVerticalVelocity
      \ SetIsOblivionGate
      \ IsAutomaticDoor
      \ SetIsAutomaticDoor
      \ IsHiddenDoor
      \ SetIsHiddenDoor
      \ IsMinimalUseDoor
      \ SetIsMinimalUseDoor
      \ GetEquippedTorchTimeLeft
      \ GetCellWaterType
      \ SetCellWaterType
      \ SetVerticalVelocity
      \ GetHighActors
      \ GetMiddleHighActors
      \ GetSkillSpecialization
      \ SetSkillSpecialization
      \ GetCurrentPackageProcedure
      \ GetCurrentScript
      \ GetCallingScript
      \ GetNthActiveEffectActorValue
      \ SetPlayersLastRiddenHorse
      \ ClearPlayersLastRiddenHorse
      \ EquipItemSilent
      \ UnequipItemSilent
      \ GetCellLighting
      \ SetCellLighting
      \ IsNthActiveEffectApplied
      \ GetMapMarkers
      \ PlayIdle
      \ IsPathNodeDisabled
      \ SetPathNodeDisabled
      \ GetPathNodePos
      \ PathEdgeExists
      \ GetCellClimate
      \ SetCellClimate
      \ SetCellBehavesAsExterior
      \ SetCellHasWater
      \ GetBoundingRadius
      \ GetEditorSize
      \ GetNthEffectItem
      \ GetPathNodeLinkedRef
      \ GetTerrainHeight
      \ IsCellPublic
      \ SetCellIsPublic
      \ ResolveModIndex
      \ SetPos_T
      \ SetOwnership_T
      \ ClearOwnership_T
      \ GetRequiredSkillExp
      \ HasEffectShader
      \ GetRaceVoice
      \ IsOblivionInterior
      \ IsOblivionWorld
      \ CanFastTravelFromWorld
      \ SetCanFastTravelFromWorld
      \ IsInOblivion
      \ GetLightDuration
      \ SetLightDuration
      \ GetTimeLeft
      \ SetTimeLeft
      \ SetCreatureSkill
      \ GetPathNodesInRadius
      \ GetPathNodesInRect
      \ SetInputText
      \ SetTextInputControlHandler
      \ SetTextInputDefaultControlsDisabled
" }}}

" Array Functions {{{
syn keyword obseArrayFunction
      \ ar_Construct
      \ ar_Size
=======
      \ ToLower
      \ ToNumber
      \ ToUpper
      \ ToggleCreatureModel
      \ ToggleSkillPerk
      \ UnHammerKey
      \ UnequipItemNS
      \ UnequipItemSilent
      \ ar_Append
      \ ar_BadNumericIndex
      \ ar_BadStringIndex
      \ ar_Construct
      \ ar_Copy
      \ ar_CustomSort
      \ ar_DeepCopy
>>>>>>> origin/main
      \ ar_Dump
      \ ar_DumpID
      \ ar_Erase
      \ ar_Find
<<<<<<< HEAD
      \ ar_Sort
      \ ar_SortAlpha
      \ ar_Copy
      \ ar_DeepCopy
      \ ar_First
      \ ar_Last
      \ ar_Next
      \ ar_Prev
      \ ar_BadNumericIndex
      \ ar_BadStringIndex
      \ ar_Keys
      \ ar_HasKeys
      \ ar_Null
      \ ar_List
      \ ar_Resize
      \ ar_Insert
      \ ar_InsertRange
      \ ar_Range
      \ ar_Map
      \ ar_Append
      \ ar_CustomSort
" }}}

" String Functions {{{
syn keyword obseStringFunction
      \ sv_Construct
      \ sv_Destruct
      \ sv_Length
      \ sv_Compare
      \ sv_Erase
      \ sv_ToNumeric
      \ sv_Find
      \ sv_Count
      \ sv_Replace
      \ sv_Insert
      \ sv_Split
      \ GetKeyName
      \ AsciiToChar
      \ NumToHex
      \ sv_Percentify
      \ IsDigit
      \ IsPunctuation
      \ IsUppercase
      \ IsPrintable
      \ IsLetter
      \ CharToAscii
      \ ToUpper
      \ ToLower
      \ ToNumber
" }}}

" Pluggy Functions {{{
syn keyword pluggyFunction
=======
      \ ar_First
      \ ar_HasKeys
      \ ar_Insert
      \ ar_InsertRange
      \ ar_Keys
      \ ar_Last
      \ ar_List
      \ ar_Map
      \ ar_Next
      \ ar_Null
      \ ar_Prev
      \ ar_Range
      \ ar_Resize
      \ ar_Size
      \ ar_Sort
      \ ar_SortAlpha
      \ sv_Compare
      \ sv_Construct
      \ sv_Count
      \ sv_Destruct
      \ sv_Erase
      \ sv_Find
      \ sv_Insert
      \ sv_Length
      \ sv_Percentify
      \ sv_Replace
      \ sv_Split
      \ sv_ToNumeric
>>>>>>> origin/main
      \ ArrayCmp
      \ ArrayCount
      \ ArrayEsp
      \ ArrayProtect
      \ ArraySize
      \ AutoSclHudS
      \ AutoSclHudT
      \ CopyArray
      \ CopyString
      \ CreateArray
      \ CreateEspBook
      \ CreateString
<<<<<<< HEAD
      \ csc
=======
>>>>>>> origin/main
      \ DelAllHudSs
      \ DelAllHudTs
      \ DelFile
      \ DelHudS
      \ DelHudT
      \ DestroyAllArrays
      \ DestroyAllStrings
      \ DestroyArray
      \ DestroyString
      \ EspToString
      \ FileToString
      \ FindFirstFile
      \ FindFloatInArray
      \ FindInArray
      \ FindNextFile
      \ FindRefInArray
      \ FirstInArray
      \ FixName
      \ FixNameEx
      \ FloatToString
      \ FmtString
      \ FromOBSEString
      \ FromTSFC
      \ GetEsp
      \ GetFileSize
      \ GetInArray
      \ GetRefEsp
      \ GetTypeInArray
      \ Halt
      \ HasFixedName
<<<<<<< HEAD
      \ HudS_Align
      \ HudSEsp
      \ HudsInfo
      \ HudS_L
      \ HudS_Opac
      \ HudSProtect
=======
      \ HudSEsp
      \ HudSProtect
      \ HudS_Align
      \ HudS_L
      \ HudS_Opac
>>>>>>> origin/main
      \ HudS_SclX
      \ HudS_SclY
      \ HudS_Show
      \ HudS_Tex
      \ HudS_X
      \ HudS_Y
<<<<<<< HEAD
      \ HudT_Align
      \ HudTEsp
      \ HudT_Font
      \ HudTInfo
      \ HudT_L
      \ HudT_Opac
      \ HudTProtect
=======
      \ HudTEsp
      \ HudTInfo
      \ HudTProtect
      \ HudT_Align
      \ HudT_Font
      \ HudT_L
      \ HudT_Opac
>>>>>>> origin/main
      \ HudT_SclX
      \ HudT_SclY
      \ HudT_Show
      \ HudT_Text
      \ HudT_X
      \ HudT_Y
<<<<<<< HEAD
=======
      \ HudsInfo
>>>>>>> origin/main
      \ IniDelKey
      \ IniGetNthSection
      \ IniKeyExists
      \ IniReadFloat
      \ IniReadInt
      \ IniReadRef
      \ IniReadString
      \ IniSectionsCount
      \ IniWriteFloat
      \ IniWriteInt
      \ IniWriteRef
      \ IniWriteString
      \ IntToHex
      \ IntToString
      \ IsHUDEnabled
      \ IsPluggyDataReset
      \ KillMenu
      \ LC
      \ LongToRef
      \ ModRefEsp
      \ NewHudS
      \ NewHudT
      \ PackArray
      \ PauseBox
      \ PlgySpcl
<<<<<<< HEAD
      \ rcsc
=======
>>>>>>> origin/main
      \ RefToLong
      \ RefToString
      \ RemInArray
      \ RenFile
      \ ResetName
      \ RunBatString
      \ SanString
      \ ScreenInfo
      \ SetFloatInArray
      \ SetHudT
      \ SetInArray
      \ SetRefInArray
      \ SetString
<<<<<<< HEAD
      \ StringCat
      \ StringCmp
      \ StringEsp
      \ StringGetName
      \ StringGetNameEx
      \ StringIns
      \ StringLen
      \ StringMsg
      \ StringMsgBox
      \ StringPos
      \ StringProtect
      \ StringRep
      \ StringSetName
      \ StringSetNameEx
      \ StringToFloat
      \ StringToInt
      \ StringToRef
      \ StringToTxtFile
      \ StrLC
      \ ToOBSEString
      \ ToTSFC
      \ UserFileExists
" }}}

" tfscFunction {{{
syn keyword tfscFunction
=======
>>>>>>> origin/main
      \ StrAddNewLine
      \ StrAppend
      \ StrAppendCharCode
      \ StrCat
      \ StrClear
      \ StrClearLast
      \ StrCompare
      \ StrCopy
      \ StrDel
      \ StrDeleteAll
      \ StrExpr
      \ StrGetFemaleBipedPath
      \ StrGetFemaleGroundPath
      \ StrGetFemaleIconPath
      \ StrGetMaleBipedPath
      \ StrGetMaleIconPath
      \ StrGetModelPath
      \ StrGetName
      \ StrGetNthEffectItemScriptName
      \ StrGetNthFactionRankName
      \ StrGetRandomName
      \ StrIDReplace
<<<<<<< HEAD
=======
      \ StrLC
>>>>>>> origin/main
      \ StrLength
      \ StrLoad
      \ StrMessageBox
      \ StrNew
      \ StrPrint
      \ StrReplace
      \ StrSave
      \ StrSet
      \ StrSetFemaleBipedPath
      \ StrSetFemaleGroundPath
      \ StrSetFemaleIconPath
      \ StrSetMaleBipedPath
      \ StrSetMaleIconPath
      \ StrSetModelPath
      \ StrSetName
      \ StrSetNthEffectItemScriptName
<<<<<<< HEAD
" }}}

" Blockhead Functions {{{
syn keyword blockheadFunction
=======
      \ StringCat
      \ StringCmp
      \ StringEsp
      \ StringGetName
      \ StringGetNameEx
      \ StringIns
      \ StringLen
      \ StringMsg
      \ StringMsgBox
      \ StringPos
      \ StringProtect
      \ StringRep
      \ StringSetName
      \ StringSetNameEx
      \ StringToFloat
      \ StringToInt
      \ StringToRef
      \ StringToTxtFile
      \ ToOBSEString
      \ ToTSFC
      \ UserFileExists
      \ csc
      \ rcsc
>>>>>>> origin/main
      \ GetBodyAssetOverride
      \ GetFaceGenAge
      \ GetHeadAssetOverride
      \ RefreshAnimData
      \ ResetAgeTextureOverride
      \ ResetBodyAssetOverride
      \ ResetHeadAssetOverride
      \ SetAgeTextureOverride
      \ SetBodyAssetOverride
      \ SetFaceGenAge
      \ SetHeadAssetOverride
      \ ToggleAnimOverride
<<<<<<< HEAD
" }}}

" switchNightEyeShaderFunction {{{
syn keyword switchNightEyeShaderFunction
      \ EnumNightEyeShader
      \ SetNightEyeShader
" }}}

" Oblivion Reloaded Functions {{{
syn keyword oblivionReloadedFunction
=======
      \ EnumNightEyeShader
      \ SetNightEyeShader
>>>>>>> origin/main
      \ ORGetCustomEffectValue
      \ ORGetEffectValue
      \ ORGetLocationName
      \ ORGetSections
      \ ORGetSetting
      \ ORGetSettings
<<<<<<< HEAD
      \ ORGetShaders
      \ ORGetShaderValue
=======
      \ ORGetShaderValue
      \ ORGetShaders
>>>>>>> origin/main
      \ ORLoadSettings
      \ ORPurgeResources
      \ ORSaveSettings
      \ ORScreenshot
      \ ORSetCustomEffectValue
      \ ORSetSetting
<<<<<<< HEAD
" }}}

" menuQue Functions {{{
syn keyword menuQueFunction
      \ GetAllSkills
      \ GetAVSkillMasteryLevelC
      \ GetAVSkillMasteryLevelF
=======
      \ GetAVSkillMasteryLevelC
      \ GetAVSkillMasteryLevelF
      \ GetAllSkills
>>>>>>> origin/main
      \ GetFontLoaded
      \ GetGenericButtonPressed
      \ GetLoadedFonts
      \ GetLocalMapSeen
      \ GetMenuEventType
      \ GetMenuFloatValue
      \ GetMenuStringValue
      \ GetMouseImage
      \ GetMousePos
      \ GetPlayerSkillAdvancesF
      \ GetPlayerSkillUseF
      \ GetRequiredSkillExpC
      \ GetRequiredSkillExpF
      \ GetSkillCode
      \ GetSkillForm
      \ GetSkillGoverningAttributeF
      \ GetSkillSpecializationC
      \ GetSkillSpecializationF
      \ GetSkillUseIncrementF
      \ GetTextEditBox
      \ GetTextEditString
      \ GetTrainingMenuCost
      \ GetTrainingMenuLevel
      \ GetTrainingMenuSkill
      \ GetWorldMapData
      \ GetWorldMapDoor
      \ IncrementPlayerSkillUseF
      \ InsertXML
      \ InsertXMLTemplate
      \ IsTextEditInUse
      \ Kyoma_Test
      \ ModPlayerSkillExpF
<<<<<<< HEAD
=======
      \ RemoveMenuEventHandler
      \ SetMenuEventHandler
      \ SetMouseImage
      \ SetPlayerSkillAdvancesF
      \ SetSkillGoverningAttributeF
      \ SetSkillSpecializationC
      \ SetSkillSpecializationF
      \ SetSkillUseIncrementF
      \ SetTextEditString
      \ SetTrainerSkillC
      \ SetWorldMapData
      \ ShowGenericMenu
      \ ShowLevelUpMenu
      \ ShowMagicPopupMenu
      \ ShowTextEditMenu
      \ ShowTrainingMenu
      \ TriggerPlayerSkillUseF
      \ UpdateLocalMap
>>>>>>> origin/main
      \ mqCreateMenuFloatValue
      \ mqCreateMenuStringValue
      \ mqGetActiveQuest
      \ mqGetActiveQuestTargets
      \ mqGetCompletedQuests
      \ mqGetCurrentQuests
      \ mqGetEnchMenuBaseItem
      \ mqGetHighlightedClass
      \ mqGetMapMarkers
      \ mqGetMenuActiveChildIndex
      \ mqGetMenuActiveFloatValue
      \ mqGetMenuActiveStringValue
      \ mqGetMenuChildCount
      \ mqGetMenuChildFloatValue
      \ mqGetMenuChildHasTrait
      \ mqGetMenuChildName
      \ mqGetMenuChildStringValue
      \ mqGetMenuGlobalFloatValue
      \ mqGetMenuGlobalStringValue
      \ mqGetQuestCompleted
      \ mqGetSelectedClass
      \ mqSetActiveQuest
      \ mqSetMenuActiveFloatValue
      \ mqSetMenuActiveStringValue
      \ mqSetMenuChildFloatValue
      \ mqSetMenuChildStringValue
<<<<<<< HEAD
      \ mqSetMenuGlobalStringValue
      \ mqSetMenuGlobalFloatValue
      \ mqSetMessageBoxSource
      \ mqUncompleteQuest
      \ RemoveMenuEventHandler
      \ SetMenuEventHandler
      \ SetMouseImage
      \ SetPlayerSkillAdvancesF
      \ SetSkillGoverningAttributeF
      \ SetSkillSpecializationC
      \ SetSkillSpecializationF
      \ SetSkillUseIncrementF
      \ SetTextEditString
      \ SetTrainerSkillC
      \ SetWorldMapData
      \ ShowGenericMenu
      \ ShowLevelUpMenu
      \ ShowMagicPopupMenu
      \ ShowTextEditMenu
      \ ShowTrainingMenu
=======
      \ mqSetMenuGlobalFloatValue
      \ mqSetMenuGlobalStringValue
      \ mqSetMessageBoxSource
      \ mqUncompleteQuest
>>>>>>> origin/main
      \ tile_FadeFloat
      \ tile_GetFloat
      \ tile_GetInfo
      \ tile_GetName
      \ tile_GetString
      \ tile_GetVar
      \ tile_HasTrait
      \ tile_SetFloat
      \ tile_SetString
<<<<<<< HEAD
      \ TriggerPlayerSkillUseF
      \ UpdateLocalMap
" }}}

" eaxFunction {{{
syn keyword eaxFunction
      \ CreateEAXeffect
      \ DeleteEAXeffect
      \ DisableEAX
      \ EAXcopyEffect
      \ EAXeffectExists
      \ EAXeffectsAreEqual
      \ EAXgetActiveEffect
      \ EAXnumEffects
      \ EAXpushEffect
      \ EAXpopEffect
      \ EAXremoveAllInstances
      \ EAXremoveFirstInstance
      \ EAXstackIsEmpty
      \ EAXstackSize
      \ EnableEAX
      \ GetEAXAirAbsorptionHF
      \ GetEAXDecayHFRatio
      \ GetEAXDecayTime
      \ GetEAXEnvironment
      \ GetEAXEnvironmentSize
      \ GetEAXEnvironmentDiffusion
      \ GetEAXReflections
      \ GetEAXReflectionsDelay
      \ GetEAXReverb
      \ GetEAXReverbDelay
      \ GetEAXRoom
      \ GetEAXRoomHF
      \ GetEAXRoomRolloffFactor
      \ InitializeEAX
      \ IsEAXEnabled
      \ IsEAXInitialized
      \ SetEAXAirAbsorptionHF
      \ SetEAXallProperties
      \ SetEAXDecayTime
      \ SetEAXDecayHFRatio
      \ SetEAXEnvironment
      \ SetEAXEnvironmentSize
      \ SetEAXEnvironmentDiffusion
      \ SetEAXReflections
      \ SetEAXReflectionsDelay
      \ SetEAXReverb
      \ SetEAXReverbDelay
      \ SetEAXRoom
      \ SetEAXRoomHF
      \ SetEAXRoomRolloffFactor
" }}}

" networkPipeFunction {{{
syn keyword networkPipeFunction
      \ NetworkPipe_CreateClient
      \ NetworkPipe_GetData
      \ NetworkPipe_IsNewGame
      \ NetworkPipe_KillClient
      \ NetworkPipe_Receive
      \ NetworkPipe_SetData
      \ NetworkPipe_Send
      \ NetworkPipe_StartService
      \ NetworkPipe_StopService
" }}}

" nifseFunction {{{
syn keyword nifseFunction
      \ BSFurnitureMarkerGetPositionRefs
      \ BSFurnitureMarkerSetPositionRefs
      \ GetNifTypeIndex
      \ NiAlphaPropertyGetBlendState
      \ NiAlphaPropertyGetDestinationBlendFunction
      \ NiAlphaPropertyGetSourceBlendFunction
      \ NiAlphaPropertyGetTestFunction
      \ NiAlphaPropertyGetTestState
      \ NiAlphaPropertyGetTestThreshold
      \ NiAlphaPropertyGetTriangleSortMode
      \ NiAlphaPropertySetBlendState
      \ NiAlphaPropertySetDestinationBlendFunction
      \ NiAlphaPropertySetSourceBlendFunction
      \ NiAlphaPropertySetTestFunction
      \ NiAlphaPropertySetTestState
      \ NiAlphaPropertySetTestThreshold
      \ NiAlphaPropertySetTriangleSortMode
=======
      \ BSFurnitureMarkerGetPositionRefs
      \ BSFurnitureMarkerSetPositionRefs
      \ GetNifTypeIndex
>>>>>>> origin/main
      \ NiAVObjectAddProperty
      \ NiAVObjectClearCollisionObject
      \ NiAVObjectCopyCollisionObject
      \ NiAVObjectDeleteProperty
      \ NiAVObjectGetCollisionMode
      \ NiAVObjectGetCollisionObject
      \ NiAVObjectGetLocalRotation
      \ NiAVObjectGetLocalScale
      \ NiAVObjectGetLocalTransform
      \ NiAVObjectGetLocalTranslation
      \ NiAVObjectGetNumProperties
      \ NiAVObjectGetProperties
      \ NiAVObjectGetPropertyByType
      \ NiAVObjectSetCollisionMode
      \ NiAVObjectSetLocalRotation
      \ NiAVObjectSetLocalScale
      \ NiAVObjectSetLocalTransform
      \ NiAVObjectSetLocalTranslation
<<<<<<< HEAD
=======
      \ NiAlphaPropertyGetBlendState
      \ NiAlphaPropertyGetDestinationBlendFunction
      \ NiAlphaPropertyGetSourceBlendFunction
      \ NiAlphaPropertyGetTestFunction
      \ NiAlphaPropertyGetTestState
      \ NiAlphaPropertyGetTestThreshold
      \ NiAlphaPropertyGetTriangleSortMode
      \ NiAlphaPropertySetBlendState
      \ NiAlphaPropertySetDestinationBlendFunction
      \ NiAlphaPropertySetSourceBlendFunction
      \ NiAlphaPropertySetTestFunction
      \ NiAlphaPropertySetTestState
      \ NiAlphaPropertySetTestThreshold
      \ NiAlphaPropertySetTriangleSortMode
>>>>>>> origin/main
      \ NiExtraDataGetArray
      \ NiExtraDataGetName
      \ NiExtraDataGetNumber
      \ NiExtraDataGetString
      \ NiExtraDataSetArray
      \ NiExtraDataSetName
      \ NiExtraDataSetNumber
      \ NiExtraDataSetString
<<<<<<< HEAD
      \ NifClose
      \ NifGetAltGrip
      \ NifGetBackShield
      \ NifGetNumBlocks
      \ NifGetOffHand
      \ NifGetOriginalPath
      \ NifGetPath
      \ NifOpen
      \ NifWriteToDisk
=======
>>>>>>> origin/main
      \ NiMaterialPropertyGetAmbientColor
      \ NiMaterialPropertyGetDiffuseColor
      \ NiMaterialPropertyGetEmissiveColor
      \ NiMaterialPropertyGetGlossiness
      \ NiMaterialPropertyGetSpecularColor
      \ NiMaterialPropertyGetTransparency
      \ NiMaterialPropertySetAmbientColor
      \ NiMaterialPropertySetDiffuseColor
      \ NiMaterialPropertySetEmissiveColor
      \ NiMaterialPropertySetGlossiness
      \ NiMaterialPropertySetSpecularColor
      \ NiMaterialPropertySetTransparency
      \ NiNodeAddChild
      \ NiNodeCopyChild
      \ NiNodeDeleteChild
      \ NiNodeGetChildByName
      \ NiNodeGetChildren
      \ NiNodeGetNumChildren
      \ NiObjectGetType
      \ NiObjectGetTypeName
      \ NiObjectNETAddExtraData
      \ NiObjectNETDeleteExtraData
      \ NiObjectNETGetExtraData
      \ NiObjectNETGetExtraDataByName
      \ NiObjectNETGetName
      \ NiObjectNETGetNumExtraData
      \ NiObjectNETSetName
      \ NiObjectTypeDerivesFrom
      \ NiSourceTextureGetFile
      \ NiSourceTextureIsExternal
      \ NiSourceTextureSetExternalTexture
      \ NiStencilPropertyGetFaceDrawMode
      \ NiStencilPropertyGetFailAction
      \ NiStencilPropertyGetPassAction
      \ NiStencilPropertyGetStencilFunction
      \ NiStencilPropertyGetStencilMask
      \ NiStencilPropertyGetStencilRef
      \ NiStencilPropertyGetStencilState
      \ NiStencilPropertyGetZFailAction
      \ NiStencilPropertySetFaceDrawMode
      \ NiStencilPropertySetFailAction
      \ NiStencilPropertySetPassAction
      \ NiStencilPropertySetStencilFunction
      \ NiStencilPropertySetStencilMask
      \ NiStencilPropertySetStencilRef
      \ NiStencilPropertySetStencilState
      \ NiStencilPropertySetZFailAction
      \ NiTexturingPropertyAddTextureSource
      \ NiTexturingPropertyDeleteTextureSource
      \ NiTexturingPropertyGetTextureCenterOffset
      \ NiTexturingPropertyGetTextureClampMode
      \ NiTexturingPropertyGetTextureCount
      \ NiTexturingPropertyGetTextureFilterMode
      \ NiTexturingPropertyGetTextureRotation
      \ NiTexturingPropertyGetTextureSource
      \ NiTexturingPropertyGetTextureTiling
      \ NiTexturingPropertyGetTextureTranslation
      \ NiTexturingPropertyGetTextureUVSet
      \ NiTexturingPropertyHasTexture
      \ NiTexturingPropertySetTextureCenterOffset
      \ NiTexturingPropertySetTextureClampMode
      \ NiTexturingPropertySetTextureCount
      \ NiTexturingPropertySetTextureFilterMode
      \ NiTexturingPropertySetTextureHasTransform
      \ NiTexturingPropertySetTextureRotation
      \ NiTexturingPropertySetTextureTiling
      \ NiTexturingPropertySetTextureTranslation
      \ NiTexturingPropertySetTextureUVSet
      \ NiTexturingPropertyTextureHasTransform
      \ NiVertexColorPropertyGetLightingMode
      \ NiVertexColorPropertyGetVertexMode
      \ NiVertexColorPropertySetLightingMode
      \ NiVertexColorPropertySetVertexMode
<<<<<<< HEAD
" }}}

" reidFunction {{{
syn keyword reidFunction
      \ GetRuntimeEditorID
" }}}

" runtimeDebuggerFunction {{{
syn keyword runtimeDebuggerFunction
      \ DebugBreak
      \ ToggleDebugBreaking
" }}}

" addActorValuesFunction {{{
syn keyword addActorValuesFunction
=======
      \ NifClose
      \ NifGetAltGrip
      \ NifGetBackShield
      \ NifGetNumBlocks
      \ NifGetOffHand
      \ NifGetOriginalPath
      \ NifGetPath
      \ NifOpen
      \ NifWriteToDisk
      \ DebugBreak
      \ GetRuntimeEditorID
      \ ToggleDebugBreaking
>>>>>>> origin/main
      \ DumpActorValueC
      \ DumpActorValueF
      \ GetActorValueBaseCalcC
      \ GetActorValueBaseCalcF
      \ GetActorValueCurrentC
      \ GetActorValueCurrentF
      \ GetActorValueMaxC
      \ GetActorValueMaxF
      \ GetActorValueModC
      \ GetActorValueModF
      \ ModActorValueModC
      \ ModActorValueModF
      \ SetActorValueModC
      \ SetActorValueModF
<<<<<<< HEAD
" }}}

" memoryDumperFunction {{{
syn keyword memoryDumperFunction
=======
>>>>>>> origin/main
      \ SetDumpAddr
      \ SetDumpType
      \ SetFadeAmount
      \ SetObjectAddr
      \ ShowMemoryDump
<<<<<<< HEAD
" }}}

" algoholFunction {{{
syn keyword algoholFunction
      \ QFromAxisAngle
      \ QFromEuler
      \ QInterpolate
      \ QMultQuat
      \ QMultVector3
      \ QNormalize
      \ QToEuler
      \ V3Crossproduct
      \ V3Length
      \ V3Normalize
" }}}

" soundCommandsFunction {{{
syn keyword soundCommandsFunction
      \ FadeMusic
      \ GetEffectsVolume
      \ GetFootVolume
      \ GetMasterVolume
      \ GetMusicVolume
      \ GetVoiceVolume
      \ PlayMusicFile
      \ SetEffectsVolume
      \ SetFootVolume
      \ SetMasterVolume
      \ SetMusicVolume
      \ SetVoiceVolume
" }}}

" emcFunction {{{
syn keyword emcFunction
      \ emcAddPathToPlaylist
      \ emcCreatePlaylist
      \ emcGetAllPlaylists
      \ emcGetAfterBattleDelay
=======
      \ emcAddPathToPlaylist
      \ emcCreatePlaylist
      \ emcGetAfterBattleDelay
      \ emcGetAllPlaylists
>>>>>>> origin/main
      \ emcGetBattleDelay
      \ emcGetEffectsVolume
      \ emcGetFadeTime
      \ emcGetFootVolume
      \ emcGetMasterVolume
      \ emcGetMaxRestoreTime
      \ emcGetMusicSpeed
      \ emcGetMusicType
      \ emcGetMusicVolume
      \ emcGetPauseTime
      \ emcGetPlaylist
      \ emcGetPlaylistTracks
<<<<<<< HEAD
      \ emcGetTrackName
      \ emcGetTrackDuration
=======
      \ emcGetTrackDuration
      \ emcGetTrackName
>>>>>>> origin/main
      \ emcGetTrackPosition
      \ emcGetVoiceVolume
      \ emcIsBattleOverridden
      \ emcIsMusicOnHold
      \ emcIsMusicSwitching
      \ emcIsPlaylistActive
      \ emcMusicNextTrack
      \ emcMusicPause
      \ emcMusicRestart
      \ emcMusicResume
      \ emcMusicStop
<<<<<<< HEAD
      \ emcPlaylistExists
      \ emcPlayTrack
=======
      \ emcPlayTrack
      \ emcPlaylistExists
>>>>>>> origin/main
      \ emcRestorePlaylist
      \ emcSetAfterBattleDelay
      \ emcSetBattleDelay
      \ emcSetBattleOverride
      \ emcSetEffectsVolume
      \ emcSetFadeTime
      \ emcSetFootVolume
      \ emcSetMasterVolume
      \ emcSetMaxRestoreTime
      \ emcSetMusicHold
      \ emcSetMusicSpeed
<<<<<<< HEAD
=======
      \ emcSetMusicType
>>>>>>> origin/main
      \ emcSetMusicVolume
      \ emcSetPauseTime
      \ emcSetPlaylist
      \ emcSetTrackPosition
<<<<<<< HEAD
      \ emcSetMusicType
      \ emcSetVoiceVolume
" }}}

" vipcxjFunction {{{
syn keyword vipcxjFunction
      \ vcAddMark
      \ vcGetFilePath
      \ vcGetHairColorRGB
      \ vcGetValueNumeric
      \ vcGetValueString
      \ vcIsMarked
      \ vcPrintIni
      \ vcSetActorState
      \ vcSetHairColor
      \ vcSetHairColorRGB
      \ vcSetHairColorRGB3P
" }}}

" cameraCommandsFunction {{{
syn keyword cameraCommandsFunction
      \ CameraGetRef
      \ CameraLookAt
      \ CameraLookAtPosition
      \ CameraMove
      \ CameraMoveToPosition
      \ CameraReset
      \ CameraRotate
      \ CameraRotateToPosition
      \ CameraSetRef
      \ CameraStopLook
" }}}

" obmeFunction {{{
syn keyword obmeFunction
      \ ClearNthEIBaseCost
      \ ClearNthEIEffectName
      \ ClearNthEIHandlerParam
      \ ClearNthEIHostility
      \ ClearNthEIIconPath
      \ ClearNthEIResistAV
      \ ClearNthEISchool
      \ ClearNthEIVFXCode
      \ CreateMgef
      \ GetMagicEffectHandlerC
      \ GetMagicEffectHandlerParamC
      \ GetMagicEffectHostilityC
      \ GetNthEIBaseCost
      \ GetNthEIEffectName
      \ GetNthEIHandlerParam
      \ GetNthEIHostility
      \ GetNthEIIconPath
      \ GetNthEIResistAV
      \ GetNthEISchool
      \ GetNthEIVFXCode
      \ ResolveMgefCode
      \ SetMagicEffectHandlerC
      \ SetMagicEffectHandlerIntParamC
      \ SetMagicEffectHandlerRefParamC
      \ SetMagicEffectHostilityC
      \ SetNthEIBaseCost
      \ SetNthEIEffectName
      \ SetNthEIHandlerIntParam
      \ SetNthEIHandlerRefParam
      \ SetNthEIHostility
      \ SetNthEIIconPath
      \ SetNthEIResistAV
      \ SetNthEISchool
      \ SetNthEIVFXCode
" }}}

" conscribeFunction {{{
syn keyword conscribeFunction
=======
      \ emcSetVoiceVolume
>>>>>>> origin/main
      \ DeleteLinesFromLog
      \ GetLogLineCount
      \ GetRegisteredLogNames
      \ ReadFromLog
      \ RegisterLog
      \ Scribe
      \ UnregisterLog
" }}}

<<<<<<< HEAD
" systemDialogFunction {{{
syn keyword systemDialogFunction
      \ Sysdlg_Browser
      \ Sysdlg_ReadBrowser
      \ Sysdlg_TextInput
" }}}

" csiFunction {{{
syn keyword csiFunction
      \ ClearSpellIcon
      \ HasAssignedIcon
      \ OverwriteSpellIcon
      \ SetSpellIcon
" }}}

" haelFunction {{{
syn keyword haelFunction
      \ GetHUDActiveEffectLimit
      \ SetHUDActiveEffectLimit
" }}}

" lcdFunction {{{
syn keyword lcdFunction
      \ lcd_addinttobuffer
      \ lcd_addtexttobuffer
      \ lcd_clearrect
      \ lcd_cleartextbuffer
      \ lcd_close
      \ lcd_drawcircle
      \ lcd_drawgrid
      \ lcd_drawint
      \ lcd_drawline
      \ lcd_drawprogressbarh
      \ lcd_drawprogressbarv
      \ lcd_drawprogresscircle
      \ lcd_drawrect
      \ lcd_drawtext
      \ lcd_drawtextbuffer
      \ lcd_drawtexture
      \ lcd_flush
      \ lcd_getbuttonstate
      \ lcd_getheight
      \ lcd_getwidth
      \ lcd_ismulti
      \ lcd_isopen
      \ lcd_open
      \ lcd_refresh
      \ lcd_savebuttonsnapshot
      \ lcd_scale
      \ lcd_setfont
" }}}

=======
>>>>>>> origin/main

if !exists("did_obse_inits")

  let did_obse_inits = 1
  hi def link obseStatement Statement
  hi def link obseStatementTwo Statement
  hi def link obseDescBlock String
  hi def link obseComment Comment
  hi def link obseString String
  hi def link obseFloat Float
  hi def link obseInt Number
  hi def link obseToDo Todo
  hi def link obseTypes Type
  hi def link obseCondition Conditional
  hi def link obseOperator Operator
  hi def link obseOtherKey Special
  hi def link obseScriptName Special
  hi def link obseBlock Conditional
  hi def link obseBlockType Structure
  hi def link obseScriptNameRegion Underlined
  hi def link obseNames Label
  hi def link obseVariable Identifier
  hi def link obseReference Special

<<<<<<< HEAD
  hi def link csFunction Function
  hi def link obseFunction Function
  hi def link obseArrayFunction Function
  hi def link pluggyFunction Function
  hi def link obseRepeat Function
  hi def link obseStringFunction Function
  hi def link obseArrayFunction Function
  hi def link tsfcFunction Function
  hi def link blockheadFunction Function
  hi def link switchNightEyeShaderFunction Function
  hi def link oblivionReloadedFunction Function
  hi def link menuQueFunction Function
  hi def link eaxFunction Function
  hi def link networkPipeFunction Function
  hi def link nifseFunction Function
  hi def link reidFunction Function
  hi def link runtimeDebuggerFunction Function
  hi def link addActorValuesFunction Function
  hi def link memoryDumperFunction Function
  hi def link algoholFunction Function
  hi def link soundCommandsFunction Function
  hi def link emcFunction Function
  hi def link vipcxjFunction Function
  hi def link cameraCommands Function
  hi def link obmeFunction Function
  hi def link conscribeFunction Function
  hi def link systemDialogFunction Function
  hi def link csiFunction Function
  hi def link haelFunction Function
  hi def link lcdFunction Function
=======
  hi def link obseFunction Function
>>>>>>> origin/main
  hi def link skillAttribute String

endif

