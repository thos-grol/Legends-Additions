::B.Info.Tomes <- {};
::B.Info.Tomes["tome_flesh"] <- {
    Name = "Tome of Flesh",
    Description = "A tome full of research on the mysteries of the flesh",
    ID = "tome_flesh",
    Projects = [
        {
            Name = "Pact of Flesh",
            BonusDifficulty = 0,
            Type = "Meditation",
            Reward = ::Const.Perks.PerkDefs.MeditationPactOfFlesh,
            Row = 1,
        },
        {
            Name = "Flesh Servant",
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.SpellFleshServant,
            Row = 2,
        },
        {
            Name = "Research - Flesh Assimilation",
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.ResearchFleshAssimilation,
            Row = 3,
        },
        {
            Name = "Reanimate",
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.SpellReanimate,
            Row = 4,
        },
        {
            Name = "Research - Flesh Overclocking",
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.ResearchFleshOverclocking,
            Row = 5,
        },
    ],
};

//TODO: NECROMANCER finish necromancer tomes
// ::B.Info.Tomes["tome_decay"] <- {
//     Name = "Tome of Decay",
//     Description = "A tome full of research on the mysteries of decay",
//     ID = "tome_decay",
//     Projects = [
//         {
//             Name = "Omen of Decay", //Increases the potency of decay. Enemies killed with the decay effect will strengthen this effect. //TODO: PERK
//             BonusDifficulty = 0,
//             Type = "Meditation",
//             Reward = ::Const.Perks.PerkDefs.MeditationOmenOfDecay,
//             Row = 1,
//         },
//         {
//             Name = "Reanimate",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellReanimate,
//             Row = 2,
//         },
//         {
//             Name = "Mark of Decay", //Applies decay and mark of decay, debuffing their damage and fatigue
//             BonusDifficulty = 0, //TODO: PERK
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellMarkofDecay,
//             Row = 3,
//         },
//         {
//             Name = "Rotten Offering", //TODO: PERK
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.ResearchRottenOffering, //mark of decay marked enemies are more likely to be targetted by enemies. If the target is killed while marked, raise them if possible on death.
//             Row = 4,
//         },
//         {
//             Name = "Miasma Body", //TODO: PERK
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.ResearchRottenOffering, //on turn start, reanimated undead have a chance to spread miasma around them. Miasma will apply decay, strength based on caster's omen of decay. Otherwise, default is 5 damage per turn.
//             Row = 5,
//         },


//         //Effects debuff the target for 3 turns.
//     ],
// };

// ::B.Info.Tomes["tome_corruption"] <- {
//     Name = "Tome of Corruption",
//     Description = "A tome full of research on the mysteries of corruption",
//     ID = "tome_corruption",
//     Projects = [
//         {
//             Name = "Pact of Flesh",
//             BonusDifficulty = 0,
//             Type = "Meditation",
//             Reward = ::Const.Perks.PerkDefs.MeditationPactOfFlesh,
//             Row = 1,
//         },
//         {
//             Name = "Flesh Servant",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellFleshServant,
//             Row = 2,
//         },
//         {
//             Name = "Reanimate",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellReanimate,
//             Row = 2,
//         },
//         {
//             Name = "Miasma Body",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.ResearchFleshOverclocking,
//             Row = 4,
//         },
//         { //TODO: PERK
//             Name = "Corpse Explosion",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.ResearchCorpseExplosion,
//             Row = 5,
//         },
//     ],
// };

// ::B.Info.Tomes["tome_anguish"] <- {
//     Name = "Tome of Anguish",
//     ID = "tome_anguish",
//     Projects = [
//         { //TODO: PERK
//             Name = "Tears of Anguish", //Decrease the mana cost of anguish. The effects and research effects of anguish grows more powerful the more lives are claimed by it.

//             //For all corpses with 5 tiles, has a 10+X% chance to raise them each turn.
//             BonusDifficulty = 0,
//             Type = "Meditation",
//             Reward = ::Const.Perks.PerkDefs.MeditationOmenOfDecay,
//             Row = 1,
//         },
//         {
//             Name = "Flesh Servant",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellFleshServant,
//             Row = 2,
//         },
//         { //TODO: PERK
//             Name = "Anguish",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellMarkofDeath, //"Curse target with spiritual anguish where they bear part of the wounds they inflict."; //Effects debuff the target for 3 turns.
//             Row = 4,
//         },
//         { //TODO: PERK
//             Name = "Research - Spreading Anguish",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellMarkofDeath, //"Increase the duration of Anguish by 1. At the beginning of the turn, anguish has a chance to spread to all of the victim's allied neighbors. Anguish also spreads on the victim's death.";
//             Row = 5,
//         },
//         { //TODO: PERK
//             Name = "Research - Torment Soul",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellMarkofDeath, //"Increases the damage conversion of anguish, but increases the cost. If a character with anguish dies, they have a chance of rising as a Geist.";
//             Row = 6,
//         },
//     ],
// };

// ::B.Info.Tomes["tome_spiritualism"] <- {
//     Name = "Tome of Spiritualism",
//     ID = "tome_spiritualism",
//     Projects = [
//         { //: ERK, do this after implementing ghosts
//             Name = "Journey to the Underworld", //Decrease the cost of Negative Energy Hand and Haunt. The caster takes no damage from ranged attacks. The caster has a 25% damage to negate an attack. Killing enemies with negative energy hand will buff all aspects of this archetype. At certain point, negative energy hand becomes negative energy barrage.
//             BonusDifficulty = 0,
//             Type = "Meditation",
//             Reward = ::Const.Perks.PerkDefs.MeditationOmenOfDecay,
//             Row = 1,
//         },
//         { //: PERK
//             Name = "Negative Energy Hand",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellFleshServant,
//             Row = 2,
//         },
//         { //: PERK
//             Name = "Research - Partial Astral Projection",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellMarkofDeath, //Negative energy hand now uses the highest skill, melee or ranged. isranged = false. increases the range of negative energy hand. Will inflict decay on landing.
//             Row = 4,
//         },
//         { //: PERK
//             Name = "Haunt",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellMarkofDeath, //Resolve check the user to inflict fear damage. then summon a geist nearby them.
//             Row = 5,
//         },
//         { //: PERK
//             Name = "???",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellMarkofDeath,
//             Row = 6,
//         },

//         //Effects debuff the target for 3 turns.
//     ],
// };

