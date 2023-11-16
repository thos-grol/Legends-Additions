::B.Info.Tomes <- {};
//TODO: NECROMANCER finish necromancer tomes
::B.Info.Tomes["tome_flesh"] <- {
    Name = "Tome of Flesh",
    Description = "A tome full of research on the mysteries of the flesh.",
    ID = "tome_flesh",
    Projects = [
        {
            Name = "Underworld Thoughts",
            BonusDifficulty = 0,
            Type = "Meditation",
            Reward = ::Const.Perks.PerkDefs.MeditationUnderworldThoughts,
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
            Row = 3,
        },
        {
            Name = "Mark of Death", //TODO: spell that causes allied undead to beeline for the target. Performs resolve clash, upon losing, target becomes drained
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.SpellReanimate,
            Row = 3,
        },



        // {
        //     Name = "Research - Flesh Mastery",
        //     BonusDifficulty = 0,
        //     Type = "Perk",
        //     Reward = ::Const.Perks.PerkDefs.ResearchFleshMastery,
        // },
    ],
};

// ::B.Info.Tomes["tome_corruption"] <- {
//     Name = "Tome of Corruption",
//     ID = "tome_corruption",
//     Projects = [
//         {
//             Name = "Potion - Winter",
//             BonusDifficulty = 0,
//             Type = "Potion",
//             Reward = "Winter",
//         },
//         {
//             Name = "Underworld Thoughts",
//             BonusDifficulty = 0,
//             Type = "Meditation",
//             Reward = ::Const.Perks.PerkDefs.MeditationUnderworldThoughts,
//         },
//         {
//             Name = "Reanimate",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellReanimate,
//         },
//         {
//             Name = "Corpse Explosion",
//             BonusDifficulty = 0,
//             Type = "Perk",
//             Reward = ::Const.Perks.PerkDefs.SpellCorpseExplosion,
//         }
//     ],
// };

//Tome of Anguish
    // Meditation Technique: Anguish (Buffs the power of anguish, small chance for nearby corpses around to reanimate)
    // anguish

//Tome of Spiritualism
    // Meditation Technique: Astral Wanderer ()
    //Haunt
    // Negative Energy Hand
        // 	partial astral projection