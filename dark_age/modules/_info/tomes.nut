::B.Info.Tomes <- {};

::B.Info.Tomes["tome_flesh"] <- {
    Name = "Tome of Flesh",
    Description = "A tome full of research on the mysteries of the flesh.",
    ID = "tome_flesh",
    Projects = [
        {
            Name = "Potion - Winter",
            BonusDifficulty = 0,
            Type = "Potion",
            Reward = "Winter",
        },
        {
            Name = "Underworld Thoughts",
            BonusDifficulty = 0,
            Type = "Meditation",
            Reward = ::Const.Perks.PerkDefs.MeditationUnderworldThoughts,
        },
        {
            Name = "Reanimate",
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.SpellReanimate,
        },
        // {
        //     Name = "Research - Flesh Mastery",
        //     BonusDifficulty = 0,
        //     Type = "Perk",
        //     Reward = ::Const.Perks.PerkDefs.ResearchFleshMastery,
        // },
        {
            Name = "Flesh Servant",
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.SpellFleshServant,
        }
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