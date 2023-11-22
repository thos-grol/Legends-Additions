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

::B.Info.Tomes["tome_decay"] <- {
    Name = "Tome of Decay",
    Description = "A tome full of research on the mysteries of decay",
    ID = "tome_decay",
    Projects = [
        {
            Name = "Omen of Decay",
            BonusDifficulty = 0,
            Type = "Meditation",
            Reward = ::Const.Perks.PerkDefs.MeditationOmenOfDecay,
            Row = 1,
        },
        {
            Name = "Mark of Decay",
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
        {
            Name = "Corpse Explosion",
            BonusDifficulty = 0,
            Type = "Perk",
            Reward = ::Const.Perks.PerkDefs.SpellCorpseExplosion,
            Row = 5,
        },
    ],
};

