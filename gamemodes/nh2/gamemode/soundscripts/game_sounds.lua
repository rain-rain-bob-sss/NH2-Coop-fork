sound.Add( {
	name = "AI_BaseNPC.BodyDrop_Heavy",
	channel = CHAN_BODY,
	volume = 1,
	level = SNDLVL_75dB,
	pitch = 90,
	sound = {"physics/flesh/flesh_impact_hard1.wav","physics/flesh/flesh_impact_hard2.wav","physics/flesh/flesh_impact_hard3.wav","physics/flesh/flesh_impact_hard4.wav","physics/flesh/flesh_impact_hard5.wav","physics/flesh/flesh_impact_hard6.wav"}
} )

sound.Add( {
	name = "AI_BaseNPC.BodyDrop_Light",
	channel = CHAN_BODY,
	volume = 0.9,
	level = SNDLVL_75dB,
	pitch = 105,
	sound = {"physics/flesh/flesh_impact_hard1.wav","physics/flesh/flesh_impact_hard2.wav","physics/flesh/flesh_impact_hard3.wav","physics/flesh/flesh_impact_hard4.wav","physics/flesh/flesh_impact_hard5.wav","physics/flesh/flesh_impact_hard6.wav"}
} )

sound.Add( {
	name = "AI_BaseNPC.SwishSound",
	channel = CHAN_BODY,
	volume = 1,
	level = SNDLVL_75dB,
	sound = "npc/zombie/claw_miss2.wav"
} )

sound.Add( {
	name = "AI_BaseNPC.SentenceStop",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = SNDLVL_60dB,
	sound = "common/null.wav"
} )

sound.Add( {
	name = "Player.DenyWeaponSelection",
	channel = CHAN_AUTO,
	volume = 0.001,
	sound = "common/null.wav"
} )

sound.Add( {
	name = "BaseCombatCharacter.CorpseGib",
	channel = CHAN_WEAPON,
	volume = 1,
	level = SNDLVL_75dB,
	sound = {"physics/flesh/flesh_squishy_impact_hard2.wav"}
} )

sound.Add( {
	name = "BaseCombatCharacter.StopWeaponSounds",
	channel = CHAN_WEAPON,
	volume = 1,
	level = SNDLVL_75dB,
	sound = "common/null.wav"
} )

sound.Add( {
	name = "BaseCombatCharacter.AmmoPickup",
	channel = CHAN_ITEM,
	volume = 1,
	level = SNDLVL_75dB,
	sound = "items/ammo_pickup.wav"
} )

sound.Add( {
	name = "BaseCombatWeapon.WeaponDrop",
	channel = CHAN_VOICE,
	volume = 0.8,
	level = SNDLVL_75dB,
	pitch = {95, 110},
	sound = {"physics/metal/weapon_impact_hard1.wav","physics/metal/weapon_impact_hard2.wav","physics/metal/weapon_impact_hard3.wav"}
} )

sound.Add( {
	name = "BaseCombatWeapon.WeaponMaterialize",
	channel = CHAN_WEAPON,
	volume = 1,
	level = SNDLVL_75dB,
	pitch = 150,
	sound = "items/suitchargeok1.wav"
} )

sound.Add( {
	name = "General.BurningFlesh",
	channel = CHAN_WEAPON,
	volume = 0.45,
	sound = "npc/headcrab/headcrab_burning_loop2.wav"
} )

sound.Add( {
	name = "General.BurningObject",
	channel = CHAN_WEAPON,
	sound = "ambient/fire/fire_small_loop2.wav"
} )

sound.Add( {
	name = "General.StopBurning",
	channel = CHAN_WEAPON,
	sound = "common/null.wav"
} )

sound.Add( {
	name = "NH2.Flashlight",
	channel = CHAN_ITEM,
	sound = "items/flashlight1_nh2.wav"
} )

