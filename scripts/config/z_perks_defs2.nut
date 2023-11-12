// ::Const.Strings.PerkName.EldritchBlast <- "Eldritch Blast"
// // ::Const.Strings.PerkDescription.LegendSpecCultHood = "With face obscured by a cultist hood, gain " + ::MSU.Text.colorGreen( 15 ) + "% of your base resolve as a bonus to melee and ranged defense. Also works with cultist leather hood, leather helmet, sack, decayed sack helm, warlock hood or mask of davkul.\n Also unlocks a crafting recipe to make cultist hoods and sacks.";
// ::Const.Strings.PerkDescription.EldritchBlast <- "Blast your foes with eldritch energy.";

// ::Const.Strings.PerkName.SacrificialRitual <- "Sacrificial Ritual"
// ::Const.Strings.PerkDescription.SacrificialRitual <- "Perform a sacrifical ritual for davkul. Davkul will now claim all the souls of the enemies you have slain. Based on your piety, Davkul will award you.";

// ::Const.Strings.PerkName.PainRitual <- "Pain Ritual"
// ::Const.Strings.PerkDescription.PainRitual <- "";

// ::Const.Strings.PerkName.CompassionRitual <- "Compassion Ritual"
// ::Const.Strings.PerkDescription.CompassionRitual <- "All Dharmas are forms of emptiness..." +
// "\n\n[color=" + ::Const.UI.Color.Passive + "][u]Passive:[/u][/color]" +
// "\n• Curse a target with all of this character's permanent injuries." +
// "\n• This curse acts upon strange, incomprehensible laws. The window to use this curse is mysterious, but can be partially influenced by the ammount of permenant injuries this character has." +
// "\n• Only one target can be cursed at a time.";

// ::Const.Strings.PerkName.SpiritVessel <- "Spirit Vessel"
// ::Const.Strings.PerkDescription.SpiritVessel <- "Not all doors are wounds, but all wounds are doors..." +
// "\n\n[color=" + ::Const.UI.Color.Passive + "][u]Passive:[/u][/color]" +
// "\n• This character loses " + ::MSU.Text.colorRed( "44%" ) + " initiative, health, and fatigue." +
// "\n• They act as vessel for spirits, summoning them around them on turn end or when hit. Every time a spirit is summoned, the chance decreases." +
// "\n• Each permenant injury increases the chance of this effect."+
// "\n• Being rewarded Perfect Spirit Vessel will strengthen the effects.";

// ::Const.Strings.PerkName.WrithingFlesh <- "Writhing Flesh"
// ::Const.Strings.PerkDescription.WrithingFlesh <- "Flesh writhes beneath the surface. Something has about this character has changed..." +
// "\n\n[color=" + ::Const.UI.Color.Passive + "][u]Passive:[/u][/color]" +
// "\n• +" + ::MSU.Text.colorGreen( "25%" ) + " Hitpoints" +
// "\n• This character is no longer affected by fresh temporary injuries.";

// ::Const.Strings.PerkName.EyesOnTheInside <- "Eyes on the Inside"
// ::Const.Strings.PerkDescription.EyesOnTheInside <- "Grant us eyes, for we are blind..." +
// "\n\n[color=" + ::Const.UI.Color.Passive + "][u]Passive:[/u][/color]" +
// "\n• On turn start, gaze into the soul of a non-ally, and have a 44% chance to morale check and to drain them." +
// "\n• The range of the effect is this character's vision. They become unaffected by night time";



local perks = [
///////////////////////////////////////////////////////////////////////////
// Mastery
///////////////////////////////////////////////////////////////////////////
    {
        ID = "perk.mastery.axec",
        Script = "scripts/skills/perks/perk_mastery_axec",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/mastery_axe.png",
        IconDisabled = "ui/perks/perk_44_sw.png",
        Const = "SpecAxeC"
    },
    {
        ID = "perk.mastery.rangedc",
        Script = "scripts/skills/perks/perk_mastery_rangedc",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/mastery_bow.png",
        IconDisabled = "ui/perks/perk_44_sw.png",
        Const = "SpecRangedC"
    },
    {
        ID = "perk.mastery.cleaverc",
        Script = "scripts/skills/perks/perk_mastery_cleaverc",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/mastery_cleaver.png",
        IconDisabled = "ui/perks/perk_44_sw.png",
        Const = "SpecCleaverC"
    },
    {
        ID = "perk.mastery.fistc",
        Script = "scripts/skills/perks/perk_mastery_fistc",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/mastery_fist.png",
        IconDisabled = "ui/perks/perk_44_sw.png",
        Const = "SpecFistC"
    },
    {
        ID = "perk.mastery.flailc",
        Script = "scripts/skills/perks/perk_mastery_flailc",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/mastery_flail.png",
        IconDisabled = "ui/perks/perk_44_sw.png",
        Const = "SpecFlailC"
    },
    {
        ID = "perk.mastery.hammerc",
        Script = "scripts/skills/perks/perk_mastery_hammerc",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/mastery_hammer.png",
        IconDisabled = "ui/perks/perk_44_sw.png",
        Const = "SpecHammerC"
    },
    {
        ID = "perk.mastery.polearmc",
        Script = "scripts/skills/perks/perk_mastery_polearmc",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/mastery_polearm.png",
        IconDisabled = "ui/perks/perk_44_sw.png",
        Const = "SpecPolearmC"
    },
    {
        ID = "perk.mastery.spearc",
        Script = "scripts/skills/perks/perk_mastery_spearc",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/mastery_spear.png",
        IconDisabled = "ui/perks/perk_44_sw.png",
        Const = "SpecSpearC"
    },
    {
        ID = "perk.mastery.swordc",
        Script = "scripts/skills/perks/perk_mastery_swordc",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/mastery_sword.png",
        IconDisabled = "ui/perks/perk_44_sw.png",
        Const = "SpecSwordC"
    },

///////////////////////////////////////////////////////////////////////////
// Stances
///////////////////////////////////////////////////////////////////////////

    {
        ID = "perk.stance.executioner",
        Script = "scripts/skills/perks/perk_stance_executioner",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/executioner.png",
        IconDisabled = "ui/perks/executioner_bw.png",
        Const = "StanceExecutioner"
    },
    {
        ID = "perk.stance.gourmet",
        Script = "scripts/skills/perks/perk_stance_gourmet",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/gourmet.png",
        IconDisabled = "ui/perks/gourmet_bw.png",
        Const = "StanceGourmet"
    },
    {
        ID = "perk.stance.the_strongest",
        Script = "scripts/skills/perks/perk_stance_the_strongest",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/the_strongest.png",
        IconDisabled = "ui/perks/the_strongest_bw.png",
        Const = "StanceTheStrongest"
    },
    {
        ID = "perk.stance.wrath",
        Script = "scripts/skills/perks/perk_stance_wrath",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/wrath.png",
        IconDisabled = "ui/perks/wrath_bw.png",
        Const = "StanceWrath"
    },
    {
        ID = "perk.stance.seismic_slam",
        Script = "scripts/skills/perks/perk_stance_seismic_slam",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/seismic_slam.png",
        IconDisabled = "ui/perks/seismic_slam_bw.png",
        Const = "StanceSeismicSlam"
    },
    {
        ID = "perk.stance.prisoner",
        Script = "scripts/skills/perks/perk_stance_prisoner",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/prisoner.png",
        IconDisabled = "ui/perks/prisoner_bw.png",
        Const = "StancePrisoner"
    },
    {
        ID = "perk.stance.breakthrough",
        Script = "scripts/skills/perks/perk_stance_breakthrough",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/breakthrough.png",
        IconDisabled = "ui/perks/breakthrough_bw.png",
        Const = "StanceBreakthrough"
    },
    {
        ID = "perk.stance.followup",
        Script = "scripts/skills/perks/perk_stance_followup",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/followup.png",
        IconDisabled = "ui/perks/followup_bw.png",
        Const = "StanceFollowup"
    },
    {
        ID = "perk.stance.marksman",
        Script = "scripts/skills/perks/perk_stance_marksman",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/marksman.png",
        IconDisabled = "ui/perks/marksman_bw.png",
        Const = "StanceMarksman"
    },
    {
        ID = "perk.stance.david",
        Script = "scripts/skills/perks/perk_stance_david",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/david.png",
        IconDisabled = "ui/perks/david_bw.png",
        Const = "StanceDavid"
    },
    {
        ID = "perk.stance.asura",
        Script = "scripts/skills/perks/perk_stance_asura",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/asura.png",
        IconDisabled = "ui/perks/asura_bw.png",
        Const = "StanceAsura"
    },

///////////////////////////////////////////////////////////////////////////
// Class
///////////////////////////////////////////////////////////////////////////

    {
        ID = "perk.class.ruin_knight",
        Script = "scripts/skills/perks/perk_class_ruin_knight",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/perk_29.png",
        IconDisabled = "ui/perks/perk_29_sw.png",
        Const = "RuinKnight"
    },

    {
        ID = "perk.class.winter_mage",
        Script = "scripts/skills/perks/perk_class_winter_mage",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/class_winter_mage.png",
        IconDisabled = "ui/perks/class_winter_mage_bw.png",
        Const = "WinterMage"
    },

///////////////////////////////////////////////////////////////////////////
// Monster
///////////////////////////////////////////////////////////////////////////

    {
        ID = "perk.nachzerer_gluttony_barrier",
        Script = "scripts/skills/perks/perk_nachzerer_gluttony_barrier",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/perk_29.png",
        IconDisabled = "ui/perks/perk_29_sw.png",
        Const = "NachzererGluttonyBarrier"
    },
	{
        ID = "perk.direwolf_berserk_mode",
        Script = "scripts/skills/perks/perk_direwolf_berserk_mode",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/perk_29.png",
        IconDisabled = "ui/perks/perk_29_sw.png",
        Const = "DirewolfBerserkMode"
    },


///////////////////////////////////////////////////////////////////////////
// Perk Rework
///////////////////////////////////////////////////////////////////////////

	{
        ID = "perk.hybridization",
        Script = "scripts/skills/perks/perk_hybridization",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/hybridization.png",
        IconDisabled = "ui/perks/hybridization_bw.png",
        Const = "Hybridization"
    },
    {
        ID = "perk.quickstep",
        Script = "scripts/skills/perks/perk_quickstep",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/quickstep.png",
        IconDisabled = "ui/perks/quickstep_bw.png",
        Const = "Quickstep"
    },
    {
        ID = "perk.dismemberment",
        Script = "scripts/skills/perks/perk_dismemberment",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/dismemberment.png",
        IconDisabled = "ui/perks/dismemberment_bw.png",
        Const = "Dismemberment"
    },
    {
        ID = "perk.death_dealer",
        Script = "scripts/skills/perks/perk_death_dealer",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/death_dealer.png",
        IconDisabled = "ui/perks/death_dealer_bw.png",
        Const = "DeathDealer"
    },
    {
        ID = "perk.trial_by_fire",
        Script = "scripts/skills/perks/perk_trial_by_fire",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/liberty_perk.png",
        IconDisabled = "ui/perks/liberty_perk_bw.png",
        Const = "TrialByFire"
    },
    {
        ID = "perk.lead_by_example",
        Script = "scripts/skills/perks/perk_lead_by_example",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/lead_by_example.png",
        IconDisabled = "ui/perks/lead_by_example_bw.png",
        Const = "LeadByExample"
    },
    {
        ID = "perk.fresh_and_furious",
        Script = "scripts/skills/perks/perk_fresh_and_furious",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/fresh_and_furious.png",
        IconDisabled = "ui/perks/fresh_and_furious_bw.png",
        Const = "FreshAndFurious"
    },
    {
        ID = "perk.survival_instinct",
        Script = "scripts/skills/perks/perk_survival_instinct",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/survival_instinct.png",
        IconDisabled = "ui/perks/survival_instinct_bw.png",
        Const = "SurvivalInstinct"
    },
    {
        ID = "perk.fitness",
        Script = "scripts/skills/perks/perk_fitness",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/wears_it_well.png",
        IconDisabled = "ui/perks/wears_it_well_bw.png",
        Const = "Fitness"
    },
    {
        ID = "perk.pocket_dirt",
        Script = "scripts/skills/perks/perk_pocket_dirt",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/throw_sand_01.png",
        IconDisabled = "ui/perks/throw_sand_01_bw.png",
        Const = "PocketDirt"
    },
    {
        ID = "perk.agile",
        Script = "scripts/skills/perks/perk_agile",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/fitness.png",
        IconDisabled = "ui/perks/fitness_bw.png",
        Const = "Agile"
    },
    {
        ID = "perk.rattle",
        Script = "scripts/skills/perks/perk_rattle",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/rattle.png",
        IconDisabled = "ui/perks/rattle_bw.png",
        Const = "Rattle"
    },
    {
        ID = "perk.strange_strikes",
        Script = "scripts/skills/perks/perk_strange_strikes",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/strange_strikes.png",
        IconDisabled = "ui/perks/strange_strikes_bw.png",
        Const = "StrangeStrikes"
    },
    {
        ID = "perk.intimidate",
        Script = "scripts/skills/perks/perk_intimidate",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/intimidate.png",
        IconDisabled = "ui/perks/intimidate_bw.png",
        Const = "Intimidate"
    },
    {
        ID = "perk.pokepoke",
        Script = "scripts/skills/perks/perk_pokepoke",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/pokepoke.png",
        IconDisabled = "ui/perks/pokepoke_bw.png",
        Const = "PokePoke"
    },
    {
        ID = "perk.pattern_recognition",
        Script = "scripts/skills/perks/perk_pattern_recognition",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/pattern_recognition.png",
        IconDisabled = "ui/perks/pattern_recognition_bw.png",
        Const = "PatternRecognition"
    },

    // Magic

    {
        ID = "perk.meditation.underworld_thoughts",
        Script = "scripts/skills/perks/perk_meditation_underworld_thoughts",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/meditation_underworld_thoughts.png",
        IconDisabled = "ui/perks/meditation_underworld_thoughts_bw.png",
        Const = "MeditationUnderworldThoughts"
    },

    {
        ID = "perk.spell.reanimate",
        Script = "scripts/skills/perks/perk_spell_reanimate",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/spell_reanimate.png",
        IconDisabled = "ui/perks/spell_reanimate_bw.png",
        Const = "SpellReanimate"
    },
    {
        ID = "perk.spell.flesh_servant",
        Script = "scripts/skills/perks/perk_spell_flesh_servant",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/spell_flesh_servant.png",
        IconDisabled = "ui/perks/spell_flesh_servant_bw.png",
        Const = "SpellFleshServant"
    },
    {
        ID = "perk.spell.corpse_explosion",
        Script = "scripts/skills/perks/perk_spell_corpse_explosion",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/spell_corpse_explosion.png", //FEATURE_0: ART spell_corpse_explosion
        IconDisabled = "ui/perks/spell_corpse_explosion_bw.png",
        Const = "SpellCorpseExplosion"
    },

    // {
	// 	ID = "perk.eldritch_blast",
	//     Script = "scripts/skills/perks/cultist_eldritch_blast",
	//     Name = "",
	// 	Tooltip = "",
	// 	Icon = "ui/perks/eldritch_blast.png",
    //     IconDisabled = "ui/perks/eldritch_blast_bw.png",
    //     Const = "EldritchBlast"
	// },
	// {
	// 	ID = "perk.sacrificial_ritual",
	//     Script = "scripts/skills/perks/cultist_sacrificial_ritual",
	//     Name = "",
	// 	Tooltip = "",
	// 	Icon = "ui/perks/sacrificial_ritual.png",
    //     IconDisabled = "ui/perks/sacrificial_ritual_bw.png",
    //     Const = "SacrificialRitual"
	// },
	// {
	// 	ID = "perk.pain_ritual",
	//     Script = "scripts/skills/perks/cultist_pain_ritual",
	//     Name = "",
	// 	Tooltip = "",
	// 	Icon = "ui/perks/pain_ritual.png",
    //     IconDisabled = "ui/perks/pain_ritual_bw.png",
    //     Const = "PainRitual"
	// },
	// {
	// 	ID = "perk.writhing_flesh",
	//     Script = "scripts/skills/perks/cultist_writhing_flesh",
	//     Name = "",
	// 	Tooltip = "",
	// 	Icon = "ui/perks/writhing_flesh.png",
    //     IconDisabled = "ui/perks/writhing_flesh_bw.png",
    //     Const = "WrithingFlesh"
	// },
	// {
	// 	ID = "perk.eyes_on_the_inside",
	//     Script = "scripts/skills/perks/cultist_eyes_on_the_inside",
	//     Name = "",
	// 	Tooltip = "",
	// 	Icon = "ui/perks/eyes_on_the_inside.png",
    //     IconDisabled = "ui/perks/eyes_on_the_inside_bw.png",
    //     Const = "EyesOnTheInside"
	// },
	// {
	// 	ID = "perk.spirit_vessel",
	//     Script = "scripts/skills/perks/cultist_spirit_vessel",
	//     Name = "",
	// 	Tooltip = "",
	// 	Icon = "ui/perks/spirit_vessel.png",
    //     IconDisabled = "ui/perks/spirit_vessel_bw.png",
    //     Const = "SpiritVessel"
	// },
	// {
	// 	ID = "perk.compassion_ritual",
	//     Script = "scripts/skills/perks/cultist_compassion_ritual",
	//     Name = "",
	// 	Tooltip = "",
	// 	Icon = "ui/perks/compassion_ritual.png",
    //     IconDisabled = "ui/perks/compassion_ritual_bw.png",
    //     Const = "CompassionRitual"
	// }
];

::logInfo("z_perks_defs2");
::Const.Perks.addPerkDefObjects(perks);

////////////////////////////////////////////////////

::Z.Perks.ProficiencyToMastery <- {
    "Axe" : {
        "Proficiency" : ::Const.Perks.PerkDefs.SpecAxe,
        "Mastery" : ::Const.Perks.PerkDefs.SpecAxeC,
    },
    "Ranged" : {
        "Proficiency" : ::Const.Perks.PerkDefs.SpecBow,
        "Mastery" : ::Const.Perks.PerkDefs.SpecRangedC,
    },
    "Cleaver" : {
        "Proficiency" : ::Const.Perks.PerkDefs.SpecCleaver,
        "Mastery" : ::Const.Perks.PerkDefs.SpecCleaverC,
    },
    "Fist" : {
        "Proficiency" : ::Const.Perks.PerkDefs.LegendSpecFists,
        "Mastery" : ::Const.Perks.PerkDefs.SpecFistC,
    },
    "Flail" : {
        "Proficiency" : ::Const.Perks.PerkDefs.SpecFlail,
        "Mastery" : ::Const.Perks.PerkDefs.SpecFlailC,
    },
    "Hammer" : {
        "Proficiency" : ::Const.Perks.PerkDefs.SpecHammer,
        "Mastery" : ::Const.Perks.PerkDefs.SpecHammerC,
    },
    "Polearm" : {
        "Proficiency" : ::Const.Perks.PerkDefs.SpecPolearm,
        "Mastery" : ::Const.Perks.PerkDefs.SpecPolearmC,
    },
    "Spear" : {
        "Proficiency" : ::Const.Perks.PerkDefs.SpecSpear,
        "Mastery" : ::Const.Perks.PerkDefs.SpecSpearC,
    },
    "Sword" : {
        "Proficiency" : ::Const.Perks.PerkDefs.SpecSword,
        "Mastery" : ::Const.Perks.PerkDefs.SpecSwordC,
    }
};