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
            Name = "Flesh Servant", //TODO: AI Flesh servant
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
            Name = "Reanimate", //TODO: AI Reanimate
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

::B.Info.Tomes["tome_decay"] <- {
    Name = "Tome of Decay",
    Description = "A tome full of research on the mysteries of decay",
    ID = "tome_decay",
    Projects = [
        {
            Name = "Omen of Decay", //TODO: NPC preset Omen of Decay
            BonusDifficulty = 0,
            Type = "Meditation",
            Reward = ::Const.Perks.PerkDefs.MeditationOmenOfDecay,
            Row = 1,
        },
        {
            Name = "Mark of Decay", //TODO: AI Mark of Decay
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.SpellMarkofDecay,
            Row = 3,
        },
        {
            Name = "Reanimate",
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.SpellReanimate,
            Row = 2,
        },
        {
            Name = "Rotten Offering",
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.ResearchRottenOffering,
            Row = 4,
        },
        {
            Name = "Miasma Body",
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.ResearchMiasmaBody,
            Row = 5,
        },


        //Effects debuff the target for 3 turns.
    ],
};

::B.Info.Tomes["tome_corruption"] <- {
    Name = "Tome of Corruption",
    Description = "A tome full of research on the mysteries of corruption",
    ID = "tome_corruption",
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
            Name = "Reanimate",
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.SpellReanimate,
            Row = 2,
        },
        {
            Name = "Miasma Body",
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.ResearchMiasmaBody,
            Row = 4,
        },
        { //TODO: PERK, SPELL Corpse Explosion
            Name = "Corpse Explosion", //TODO: AI corpse explosion
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.ResearchCorpseExplosion,
            Row = 5,
        },
    ],
};

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

