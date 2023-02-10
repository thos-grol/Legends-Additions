::LA.drop_potion <- function (_killer, _skill, _tile, _fatalityType, chance, item)
{
	if (_tile != null && _killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
	{
		local count = 0.0
		local roster = this.World.getPlayerRoster().getAll();
		foreach( i, bro in roster )
		{
			if (i >= 25) break;
			if (bro.getBackground().getID() == "background.anatomist") count++;
		}
		count *= 2.0;

		local ROLL = this.Math.rand(1.0, 100.0);
		this.logInfo("Rolling for potion: " + ROLL + " vs " + chance * count)

		if (ROLL <= chance * count)
		{
			local loot = ::new(item);
			loot.drop(_tile);
		}
	}
}

//FEATURE_2: Reenable Alp potions
// ::mods_hookExactClass("entity/tactical/enemies/alp", function (o)
// {
//     local onDeath = o.onDeath;
//     o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//     {
//         onDeath(_killer, _skill, _tile, _fatalityType);
//         local chance = 2.0;
//         local item = "scripts/items/misc/anatomist/alp_potion_item";
//         ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
//     }
// });

// ::mods_hookExactClass("entity/tactical/enemies/legend_demon_alp", function (o)
// {
//     local onDeath = o.onDeath;
//     o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//     {
//         onDeath(_killer, _skill, _tile, _fatalityType);
//         local chance = 5.0;
//         local item = "scripts/items/misc/anatomist/geist_potion_item";
//         ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
//     }
// });

::mods_hookExactClass("entity/tactical/enemies/direwolf", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 2.5;
        local item = "scripts/items/misc/anatomist/direwolf_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

::mods_hookExactClass("entity/tactical/enemies/legend_white_direwolf", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 5.0;
        local item = "scripts/items/misc/anatomist/goblin_overseer_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

//FEATURE_2: Reenable vampire potions
// necrosavant
::mods_hookExactClass("entity/tactical/enemies/vampire", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 2.5;
        local item = "scripts/items/misc/anatomist/necrosavant_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

// ::mods_hookExactClass("entity/tactical/enemies/legend_vampire_lord", function (o)
// {
//     local onDeath = o.onDeath;
//     o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//     {
//         onDeath(_killer, _skill, _tile, _fatalityType);
//         local chance = 5;
//         local item = "scripts/items/misc/anatomist/apotheosis_potion_item";
//         ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
//     }
// });

//goblin

::mods_hookExactClass("entity/tactical/goblin", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 0.75;
        local item = "scripts/items/misc/anatomist/goblin_grunt_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

::mods_hookExactClass("entity/tactical/enemies/goblin_leader", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 1;
        local item = "scripts/items/misc/anatomist/goblin_grunt_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

//orc

::mods_hookExactClass("entity/tactical/enemies/legend_orc_behemoth", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 2.5;
        local item = "scripts/items/misc/anatomist/orc_young_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

::mods_hookExactClass("entity/tactical/enemies/legend_orc_elite", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 1.25;
        local item = "scripts/items/misc/anatomist/orc_young_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

::mods_hookExactClass("entity/tactical/enemies/orc_berserker", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 1.25;
        local item = "scripts/items/misc/anatomist/orc_young_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

::mods_hookExactClass("entity/tactical/enemies/orc_warrior", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 1.25;
        local item = "scripts/items/misc/anatomist/orc_young_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

::mods_hookExactClass("entity/tactical/enemies/orc_young", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 1.25;
        local item = "scripts/items/misc/anatomist/orc_young_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

::mods_hookExactClass("entity/tactical/enemies/orc_warlord", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 5;
        local item = "scripts/items/misc/anatomist/orc_warlord_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

//serpent
//FEATURE_2: Reenable Serpent potion
// ::mods_hookExactClass("entity/tactical/enemies/serpent", function (o)
// {
//     local onDeath = o.onDeath;
//     o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//     {
//         onDeath(_killer, _skill, _tile, _fatalityType);
//         local chance = 2.5;
//         local item = "scripts/items/misc/anatomist/serpent_potion_item";
//         ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
//     }
// });

//spider

::mods_hookExactClass("entity/tactical/enemies/spider", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 1.25;
        local item = "scripts/items/misc/anatomist/webknecht_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

::mods_hookExactClass("entity/tactical/enemies/legend_redback_spider", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 2.5;
        local item = "scripts/items/misc/anatomist/wiederganger_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

//unhold
::mods_hookExactClass("entity/tactical/enemies/unhold", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 2.5;
        local item = "scripts/items/misc/anatomist/unhold_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

::mods_hookExactClass("entity/tactical/enemies/legend_rock_unhold", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 5;
        local item = "scripts/items/misc/anatomist/ancient_priest_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

//nachzehrer
::mods_hookExactClass("entity/tactical/enemies/ghoul", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 1.25;
        local item = "scripts/items/misc/anatomist/nachzehrer_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

::mods_hookExactClass("entity/tactical/enemies/legend_skin_ghoul", function (o)
{
    local onDeath = o.onDeath;
    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
    {
        onDeath(_killer, _skill, _tile, _fatalityType);
        local chance = 2.5;
        local item = "scripts/items/misc/anatomist/fallen_hero_potion_item";
        ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
    }
});

//FEATURE_2: Reenable Lindwurm potions
//lindwurm
// ::mods_hookExactClass("entity/tactical/enemies/lindwurm", function (o)
// {
//     local onDeath = o.onDeath;
//     o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//     {
//         onDeath(_killer, _skill, _tile, _fatalityType);
//         local chance = 5.0;
//         local item = "scripts/items/misc/anatomist/lindwurm_potion_item";
//         ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
//     }
// });

// ::mods_hookExactClass("entity/tactical/enemies/legend_stollwurm", function (o)
// {
//     local onDeath = o.onDeath;
//     o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//     {
//         onDeath(_killer, _skill, _tile, _fatalityType);
//         local chance = 5.0;
//         local item = "scripts/items/misc/anatomist/orc_warrior_potion_item";
//         ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
//     }
// });

//FEATURE_2: Reenable Schrat potions
// ::mods_hookExactClass("entity/tactical/enemies/schrat", function (o)
// {
//     local onDeath = o.onDeath;
//     o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//     {
//         onDeath(_killer, _skill, _tile, _fatalityType);
//         local chance = 5.0;
//         local item = "scripts/items/misc/anatomist/schrat_potion_item";
//         ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
//     }
// });

// ::mods_hookExactClass("entity/tactical/enemies/legend_greenwood_schrat", function (o)
// {
//     local onDeath = o.onDeath;
//     o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//     {
//         onDeath(_killer, _skill, _tile, _fatalityType);
//         local chance = 5.0;
//         local item = "scripts/items/misc/anatomist/ifrit_potion_item";
//         ::LA.drop_potion(_killer, _skill, _tile, _fatalityType, chance, item);
//     }
// });