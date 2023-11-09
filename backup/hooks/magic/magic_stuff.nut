::Const.Magic <- {};

::Const.Magic.Type <- {
	Neutral = 0,
    NegativeEnergy = 1,
	Fire = 2,
	Ice = 3,
	Air = 4,
    Earth = 5
};

local perkDefObjects = [
    {
        ID = "perk.legend_deathtouch",
        Script = "scripts/skills/perks/perk_legend_deathtouch",
        Name = ::Const.Strings.PerkName.LegendDeathtouch,
        Tooltip = ::Const.Strings.PerkDescription.LegendDeathtouch,
        Icon = "ui/perks/deathtouch_circle.png",
        IconDisabled = "ui/perks/deathtouch_circle_bw.png",
        Const = "LegendDeathtouch"
    }
];


//Bright
//Extremely Bright
//Genius

::Const.Perks.addPerkDefObjects(perkDefObjects);
::Const.Perks.updatePerkGroupTooltips();

::Const.Strings.PerkName.MatrixNegativeEnergy <- "Matrix: Negative Energy";
::Const.Strings.PerkDescription.MatrixNegativeEnergy <- "Basic Magic Matrix. \nEngrave a magic matrix upon the soul to allow the casting of negative energy spells. \nYou can only take 1 basic matrix perk.\nNegative Energy: 1\nSpiritualism: 1";

// ::Const.Strings.PerkName.MatrixGehenna <- "Matrix: Gehenna";
// ::Const.Strings.PerkDescription.MatrixGehenna <- "Advanced Magic Matrix. \nInspired by visions of a flaming hell, a genius necromancer created a magic matrix that allows the caster to cast negative energy and fire spells. \nCan repermutate and refund 'Matrix: Negative Energy'. Counts basic matrix perk.\nNegative Energy: 1\nSpiritualism: 1\nFire: 1";

::Const.Strings.PerkName.MeditiationBasic <- "Meditation Technique: Basic";
::Const.Strings.PerkDescription.MeditiationBasic <- ". \nNegative Energy: 1";

::Const.Strings.PerkName.MeditiationUnderworldThoughts <- "Meditation Technique: Underworld Thoughts";
::Const.Strings.PerkDescription.MeditiationUnderworldThoughts <- "Decrease the mana cost of Reanimate and Haunt by 1. Buffs reanimate and haunt. Becomes more powerful, the lower your hp is. ";

::Const.Strings.PerkName.MeditiationUnderworldThoughts <- "Meditation Technique: Lament";
::Const.Strings.PerkDescription.MeditiationUnderworldThoughts <- "Becomes stronger the more your trusted comrades die. Buffs anguish";

::Const.Strings.PerkName.MeditiationUnderworldThoughts <- "Meditation Technique: Astral Explorer";
::Const.Strings.PerkDescription.MeditiationUnderworldThoughts <- "Becomes more powerful, the lower your hp is. Buffs negative energy hand";

//Soul shock!



//////////


::Const.Strings.PerkName.NegativeEnergyHand <- "Negative Energy Hand";
::Const.Strings.PerkDescription.NegativeEnergyHand <- "Condense negative energy in your hand and touch, tearing at the soul of your victim for 25-35 damage ignoring armor and draining them.\nDrain: duration, 3 turns base. -40% fatigue recovery, and -X% max health, X = duration\nNegative Energy: 1\nSpiritualism: 1";

    ::Const.Strings.PerkName.PartialAstralProjection <- "Partial Astral Projection";
    ::Const.Strings.PerkDescription.PartialAstralProjection <- "Further mastery of spiritualism and negative energy allows the user to throw out their spirit hand 3 tiles. Negative energy hand now uses the highest attack (melee or ranged) skill for it's hit calculation. \n+5 min and max Negative Energy Hand damage.";

::Const.Strings.PerkName.Reanimate <- "Reanimate";
::Const.Strings.PerkDescription.Reanimate <- "Reanimates the dead as one of your servants. Those reanimated have their health doubled. \nNegative Energy: 1\nSpiritualism: 1";

::Const.Strings.PerkName.CorpseRot <- "Corpse Rot";
::Const.Strings.PerkDescription.CorpseRot <- "Charm an undead. \nSpiritualism: 1";

::Const.Strings.PerkName.CorpseExplosion <- "Corpse Explosion";
::Const.Strings.PerkDescription.CorpseExplosion <- "Target an undead (except necrosavant), and create an explosion based on the target's health. Chance: 0 if same faction, depends on will and magic skill if not.\nNegative Energy: 1\nFire: 1";



Reanimate

::Const.Strings.PerkName.Anguish <- "Anguish";
::Const.Strings.PerkDescription.Anguish <- "Curse target with spiritual anguish where they bear part of the wounds they inflict.";

    ::Const.Strings.PerkName.SpreadingAnguish <- "Research: Spreading Anguish";
    ::Const.Strings.PerkDescription.SpreadingAnguish <- "Increase the duration of Anguish by 1. At the beginning of the turn, anguish has a chance to spread to all of the victim's allied neighbors. Anguish also spreads on the victim's death.";

    ::Const.Strings.PerkName.TormentSoul <- "Research: Torment Soul";
    ::Const.Strings.PerkDescription.TormentSoul <- "Increases the damage conversion of anguish, but increases the cost. If a character with anguish dies, they have a chance of rising as a Geist.";


::Const.Strings.PerkName.Haunt <- "Haunt";
::Const.Strings.PerkDescription.Haunt <- "Summons x Geists, depending on skill 1 to 6 monsters.";


//Cooldown is duration of haunt.


// Necromancy
//     Book of Negative Energy
//     Book of Unlife
//     Lich's Tome




//Necromancer
    //Tome of Spiritualism
        //Novice
            //Mana pool: 3
            //Matrix: Negative Energy
            //Underworld Thoughts
            //Negative Energy Hand
            //Reanimate

        //Intermediate
            //Mana pool: 5
            //Matrix: Negative Energy
            //Underworld Thoughts
            //Negative Energy Hand
                //Partial Astral Projection
            //Reanimate
            //Anguish
                //Torment Soul

        //Master
            //Mastered the entire book
            //Has magic items
            //Mana pool: 6
            //Matrix: Negative Energy
            //Underworld Thoughts
            //Negative Energy Hand
                //Partial Astral Projection
            //Reanimate
            //Anguish
                //Torment Soul
                //Spreading Anguish
            //Haunt
//Hero Necromancers

    //An alchemist reading this book can learn the recipe to brew the Black Lead Potion.

    //Years after the conjunction of the spheres and the tide of magic that washed into this world, the wisdom of the ancients allowed them to devise a method to ignite the vitality and convert it into a container for spirituality or mana. Unlocks the recipe to brew the Black Lead Potion.
// 10 hp -> 1 mana

// XAP Battle Meditation, recover skill, recovers 3 mana
// 	Samadhi - -3 AP, recovers 1 more mana
// 	Battlemage - performs battle meditation on turn end

// 4AP Negative Energy Hand, 1 mana
// 6AP Ray of Enfeeblement, 3 mana, cd
// 4AP Reanimate, 2 Mana
// 4AP Corpse Rot, 3 Mana
// 4AP Corpse Explosion, 4 mana

// 6AP Haunt, 3 Mana, cd
// 6AP Anguish, 5 Mana, cd