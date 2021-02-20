" Vim syntax file
" Language: OBSE Script (OBSEScript)
" Original Creator: Ulthar Seramis
" Maintainer: Kat
" Latest Revision: 03 February 2021

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
syn keyword obseTypes array_var float int long ref reference short string_var nextgroup=obseNames skipwhite
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
      \ OnDodge
      \ OnDrinkPotion
      \ OnDrop
      \ OnEatIngredient
      \ OnEnchant
      \ OnEquip
      \ OnFallImpact
      \ OnHealthDamage
      \ OnHit
      \ OnHitWith
      \ OnKnockout
      \ OnLoad
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
      \ OnSpellCast
      \ OnStagger
      \ OnStartCombat
      \ OnTrigger
      \ OnTriggerActor
      \ OnTriggerMob
      \ OnUnequip
      \ OnVampireFeed
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
" CS functions {{{
syn keyword csFunction
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
      \ EvaluatePackage	
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
      \ GetInWorldspace
      \ GetInvestmentGold
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
      \ GetLOS
      \ GetLevel
      \ GetLockLevel
      \ GetLocked
      \ GetMenuHasTrait
      \ GetName
      \ GetNoRumors
      \ GetOffersServicesNow
      \ GetOpenState
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
      \ GetPackageTarget
      \ GetParentRef
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
      \ IsActorUsingATorch
      \ IsActorsAIOff
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
      \ KillActor
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
      \ SCAOnActor
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
      \ SetActorValue
      \ SetActorsAI
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
      \ SetPCExpelled
      \ SetPCFactionAttack
      \ SetPCFactionMurder
      \ SetPCFactionSteal
      \ SetPCFactionSubmitAuthority
      \ SetPCFame
      \ SetPCInfamy
      \ SetPCSleepHours
      \ SetPackDuration
      \ SetPlayerBirthsign
      \ SetPlayerInSEWorld
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
      \ evp
      \ pms
      \ saa
      \ sms
" }}}

" OBSE Functions {{{
syn keyword obseFunction
      \ ACos
      \ AHammerKey
      \ ASin
      \ ATan
      \ ATan2
      \ Abs
      \ AddEffectItem
      \ AddEffectItemC
      \ AddFullEffectItem
      \ AddFullEffectItemC
      \ AddItemNS
      \ AddSpellNS
      \ AddToLeveledList
      \ AnimPathIncludes
      \ AppendToName
      \ CalcLeveledItem
      \ Call
      \ CanCorpseCheck
      \ CanFastTravelFromWorld
      \ Ceil
      \ ClearHotKey
      \ ClearLeveledList
      \ ClearOwnership_T
      \ ClearPlayersLastRiddenHorse
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
      \ Con_SetINISetting
      \ Con_SetImageSpaceGlow
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
      \ DebugPrint
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
      \ GetActiveMenuComponentID
      \ GetActiveMenuFilter
      \ GetActiveMenuMode
      \ GetActiveMenuObject
      \ GetActiveMenuRef
      \ GetActiveMenuSelection
      \ GetActiveUIComponentFullName
      \ GetActiveUIComponentID
      \ GetActiveUIComponentNAme
      \ GetActorBaseLevel
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
      \ GetBoundingRadius
      \ GetCalcAllLevels
      \ GetCalcEachInCount
      \ GetCallingScript
      \ GetCellClimate
      \ GetCellLighting
      \ GetCellMusicType
      \ GetCellNorthRotation
      \ GetCellWaterType
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
      \ GetCurrentPackageProcedure
      \ GetCurrentScript
      \ GetCurrentSoulLevel
      \ GetCurrentWeatherID
      \ GetDebugSelection
      \ GetEditorSize
      \ GetEnchMenuEnchItem
      \ GetEnchMenuSoulgem
      \ GetEnchantment
      \ GetEnchantmentCharge
      \ GetEnchantmentCost
      \ GetEnchantmentType
      \ GetEquipmentSlot
      \ GetEquipmentSlotMask
      \ GetEquippedCurrentCharge
      \ GetEquippedCurrentHealth
      \ GetEquippedObject
      \ GetEquippedTorchTimeLeft
      \ GetEquippedWeaponPoison
      \ GetEyes
      \ GetFPS
      \ GetFallTimer
      \ GetFirstRef
      \ GetFullGoldValue
      \ GetGameLoaded
      \ GetGameRestarted
      \ GetGodMode
      \ GetGoldValue
      \ GetHair
      \ GetHairColor
      \ GetHighActors
      \ GetHorse
      \ GetHotKeyItem
      \ GetIgnoresResistance
      \ GetIngredient
      \ GetIngredientChance
      \ GetInventoryObject
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
      \ GetMagicEffectSchool
      \ GetMagicEffectUsedObject
      \ GetMagicEffectUsedObjectC
      \ GetMagicItemEffectCount
      \ GetMagicItemType
      \ GetMagicProjectileSpell
      \ GetMapMarkers
      \ GetMerchantContainer
      \ GetMessageBoxType
      \ GetMiddleHighActors
      \ GetModIndex
      \ GetMouseButtonPress
      \ GetNextRef
      \ GetNthAcitveEffectMagnitude
      \ GetNthActiveEffectActorValue
      \ GetNthActiveEffectCaster
      \ GetNthActiveEffectCode
      \ GetNthActiveEffectData
      \ GetNthActiveEffectDuration
      \ GetNthActiveEffectMagicItem
      \ GetNthActiveEffectMagicItemIndex
      \ GetNthActiveEffectTimeElapsed
      \ GetNthChildRef
      \ GetNthDetectedActor
      \ GetNthEffectItem
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
      \ GetNthMagicEffectCounter
      \ GetNthMagicEffectCounterC
      \ GetNthPackage
      \ GetNthPlayerSpell
      \ GetNthRaceBonusSkill
      \ GetNthRaceSpell
      \ GetNthSpell
      \ GetNumChildRefs
      \ GetNumDetectedActors
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
      \ GetNumericINISetting
      \ GetOBSERevision
      \ GetOBSEVersion
      \ GetObjectCharge
      \ GetObjectHealth
      \ GetObjectType
      \ GetOpenKey
      \ GetOpenSound
      \ GetOwner
      \ GetOwningFactionRank
      \ GetPCAttributeBonus
      \ GetPCMajorSkillUps
      \ GetParentCell
      \ GetParentCellOwner
      \ GetParentCellOwningFactionRank
      \ GetParentCellWaterHeight
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
      \ GetRaceVoice
      \ GetRefCount
      \ GetRefVariable
      \ GetRequiredSkillExp
      \ GetRider
      \ GetScript
      \ GetScriptActiveEffectIndex
      \ GetServicesMask
      \ GetSkillSpecialization
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
      \ GetSpellType
      \ GetSpells
      \ GetTeleportCell	
      \ GetTerrainHeight
      \ GetTexturePath
      \ GetTimeLeft
      \ GetTotalAEAbilityMagnitude
      \ GetTotalAEAlchemyMagnitude
      \ GetTotalAEAllSpellsMagnitude
      \ GetTotalAEDiseaseMagnitude
      \ GetTotalAEEnchantmentMagnitude
      \ GetTotalAELesserPowerMagnitude
      \ GetTotalAENonAbilityMagnitude
      \ GetTotalAEPowerMagnitude
      \ GetTotalAESpellMagnitude
      \ GetTotalActiveEffectMagnitude
      \ GetTotalPCAttributeBonus
      \ GetTrainerLevel
      \ GetTrainerSkill
      \ GetTravelHorse
      \ GetVariable
      \ GetVelocity
      \ GetVerticalVelocity
      \ GetWeahterCloudSpeedUpper
      \ GetWeaponReach
      \ GetWeaponSpeed
      \ GetWeaponType
      \ GetWeatherCloudSpeedLower
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
      \ HasEffectShader
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
      \ IsAnimPlaying
      \ IsApparatus
      \ IsArmor
      \ IsAttacking
      \ IsAutomaticDoor
      \ IsBarterMenuActive
      \ IsBipedIconPathValid
      \ IsBipedModelPathValid
      \ IsBlocking
      \ IsBook
      \ IsCasting
      \ IsCellPublic
      \ IsClassAttribute
      \ IsClassSkill
      \ IsClonedForm
      \ IsClothing
      \ IsContainer
      \ IsControlPressed
      \ IsCreature
      \ IsCreatureBiped
      \ IsDodging
      \ IsDoor
      \ IsFactionEvil
      \ IsFactionHidden
      \ IsFlora
      \ IsFlying
      \ IsFood
      \ IsFormValid
      \ IsFurniture
      \ IsGlobalCollisionDisabled
      \ IsHarvested
      \ IsHiddenDoor
      \ IsIconPathValid
      \ IsInAir
      \ IsInOblivion
      \ IsIngredient
      \ IsJumping
      \ IsKey
      \ IsKeyPressed
      \ IsKeyPressed2
      \ IsKeyPressed3
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
      \ IsMinimalUseDoor
      \ IsModLoaded
      \ IsModelPathValid
      \ IsMovingBackward
      \ IsMovingForward
      \ IsMovingLeft
      \ IsMovingRight
      \ IsNthActiveEffectApplied
      \ IsNthEffectItemScriptHostile
      \ IsNthEffectItemScripted
      \ IsOblivionInterior
      \ IsOblivionWorld
      \ IsOffLimits
      \ IsOnGround
      \ IsPCLevelOffset
      \ IsPathNodeDisabled
      \ IsPersistent
      \ IsPlayable
      \ IsPlayable2
      \ IsPluginInstalled
      \ IsPoison
      \ IsPowerAttacking
      \ IsQuestItem
      \ IsRaceBonusSkill
      \ IsRaceBonusSkillC
      \ IsRecoiling
      \ IsRefEssential
      \ IsReference
      \ IsScripted
      \ IsSigilStone
      \ IsSoulGem
      \ IsStaggered
      \ IsSummonable
      \ IsThirdPerson
      \ IsTurningLeft
      \ IsTurningRight
      \ IsUnderWater
      \ IsWeapon
      \ Label
      \ LeftShift
      \ Log
      \ Log10
      \ LogicalAnd
      \ LogicalNot
      \ LogicalOr
      \ LogicalXor
      \ MagicEffectCodeFromChars
      \ MagicEffectFXPersists
      \ MagicEffectFXPersistsC
      \ MagicEffectFromChars
      \ MagicEffectFromCode
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
      \ PathEdgeExists
      \ PlayIdle
      \ Pow
      \ Print
      \ PrintActiveTileInfo
      \ PrintC
      \ PrintToConsole
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
      \ ResolveModIndex
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
      \ SetCanFastTravelFromWorld
      \ SetCellBehavesAsExterior
      \ SetCellClimate
      \ SetCellHasWater
      \ SetCellIsPublic
      \ SetCellLighting
      \ SetCellWaterType
      \ SetClimateHasMassser
      \ SetClimateHasSecunda
      \ SetClimateMoonPhaseLength
      \ SetClimateSunsetBegin
      \ SetClimateSunsetEnd
      \ SetClimateVolatility
      \ SetCloseSound
      \ SetContainerRespawns
      \ SetCreatureSkill
      \ SetCurrentSoulLevel
      \ SetDebugMode
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
      \ SetGoldValue_T
      \ SetHair
      \ SetHarvested
      \ SetHasBeenPickedUp
      \ SetHotKeyItem
      \ SetIconPath
      \ SetIgnoresResistance
      \ SetIngredientChance
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
      \ SetRefCount
      \ SetRefEssential
      \ SetScaleEx
      \ SetScript
      \ SetSkillSpecialization
      \ SetSkillUseIncrement
      \ SetSoulGemCapacity
      \ SetSoulLevel
      \ SetSpellExplodesWithNoTarget
      \ SetSpellHostile
      \ SetSpellMagickaCost
      \ SetSpellMasteryLevel
      \ SetSpellType
      \ SetSummonable
      \ SetTextInputControlHandler
      \ SetTextInputDefaultControlsDisabled
      \ SetTimeLeft
      \ SetTrainerLevel
      \ SetTrainerSkill
      \ SetTravelHorse
      \ SetVelocity
      \ SetVerticalVelocity
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
      \ ToggleCreatureModel
      \ ToggleSkillPerk
      \ UnHammerKey
      \ UnequipItemNS
      \ UnequipItemSilent
" }}}

" Array Functions {{{
syn keyword obseArrayFunction
      \ ar_Construct
      \ ar_Size
      \ ar_Dump
      \ ar_DumpID
      \ ar_Erase
      \ ar_Find
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
      \ csc
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
      \ HudS_Align
      \ HudSEsp
      \ HudsInfo
      \ HudS_L
      \ HudS_Opac
      \ HudSProtect
      \ HudS_SclX
      \ HudS_SclY
      \ HudS_Show
      \ HudS_Tex
      \ HudS_X
      \ HudS_Y
      \ HudT_Align
      \ HudTEsp
      \ HudT_Font
      \ HudTInfo
      \ HudT_L
      \ HudT_Opac
      \ HudTProtect
      \ HudT_SclX
      \ HudT_SclY
      \ HudT_Show
      \ HudT_Text
      \ HudT_X
      \ HudT_Y
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
      \ rcsc
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
" }}}

" Blockhead Functions {{{
syn keyword blockheadFunction
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
" }}}

" switchNightEyeShaderFunction {{{
syn keyword switchNightEyeShaderFunction
      \ EnumNightEyeShader
      \ SetNightEyeShader
" }}}

" Oblivion Reloaded Functions {{{
syn keyword oblivionReloadedFunction
      \ ORGetCustomEffectValue
      \ ORGetEffectValue
      \ ORGetLocationName
      \ ORGetSections
      \ ORGetSetting
      \ ORGetSettings
      \ ORGetShaders
      \ ORGetShaderValue
      \ ORLoadSettings
      \ ORPurgeResources
      \ ORSaveSettings
      \ ORScreenshot
      \ ORSetCustomEffectValue
      \ ORSetSetting
" }}}

" menuQue Functions {{{
syn keyword menuQueFunction
      \ GetAllSkills
      \ GetAVSkillMasteryLevelC
      \ GetAVSkillMasteryLevelF
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
      \ tile_FadeFloat
      \ tile_GetFloat
      \ tile_GetInfo
      \ tile_GetName
      \ tile_GetString
      \ tile_GetVar
      \ tile_HasTrait
      \ tile_SetFloat
      \ tile_SetString
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
      \ NiExtraDataGetArray
      \ NiExtraDataGetName
      \ NiExtraDataGetNumber
      \ NiExtraDataGetString
      \ NiExtraDataSetArray
      \ NiExtraDataSetName
      \ NiExtraDataSetNumber
      \ NiExtraDataSetString
      \ NifClose
      \ NifGetAltGrip
      \ NifGetBackShield
      \ NifGetNumBlocks
      \ NifGetOffHand
      \ NifGetOriginalPath
      \ NifGetPath
      \ NifOpen
      \ NifWriteToDisk
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
" }}}

" memoryDumperFunction {{{
syn keyword memoryDumperFunction
      \ SetDumpAddr
      \ SetDumpType
      \ SetFadeAmount
      \ SetObjectAddr
      \ ShowMemoryDump
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
      \ emcGetTrackName
      \ emcGetTrackDuration
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
      \ emcPlaylistExists
      \ emcPlayTrack
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
      \ emcSetMusicVolume
      \ emcSetPauseTime
      \ emcSetPlaylist
      \ emcSetTrackPosition
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
      \ DeleteLinesFromLog
      \ GetLogLineCount
      \ GetRegisteredLogNames
      \ ReadFromLog
      \ RegisterLog
      \ Scribe
      \ UnregisterLog
" }}}

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
  hi def link obseRepeat Repeat

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
  hi def link skillAttribute String
  hi def link skillAttribute String

endif

