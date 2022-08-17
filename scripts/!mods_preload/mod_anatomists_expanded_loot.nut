this.getroottable().anatomists_expanded.doPotionDrop <- function (_killer, _skill, _tile, _fatalityType, chance, item)
{
	if (_tile != null && _killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
	{
		local count = 0.0
		local roster = this.World.getPlayerRoster().getAll();
		foreach( i, bro in roster )
		{
			if (i >= 25)
			{
				break;
			}
			
			//TODO: revamp to count if anatomist trait exists
			if (bro.getBackground().getID() == "background.anatomist")
			{
				count++;
			}
		}
		if (this.World.Assets.getOrigin().getID() == "scenario.anatomists")
		{
			count *= 2.0;
		}

		
		local rand = this.Math.rand(1.0, 100.0);
		this.logInfo("Rolling for potion: " + rand + " vs " + chance * count)

		if (rand <= chance * count)
		{
			local loot = this.new(item);
			loot.drop(_tile);
		}
		
	}
}

this.getroottable().anatomists_expanded.hook_loot <- function ()
{
	::mods_hookExactClass("entity/tactical/enemies/alp", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 2.5;
			local item = "scripts/items/misc/anatomist/alp_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/legend_demon_alp", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 5;
			local item = "scripts/items/misc/anatomist/demon_alp_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});
	
	::mods_hookExactClass("entity/tactical/enemies/direwolf", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 2.5;
			local item = "scripts/items/misc/anatomist/direwolf_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/legend_white_direwolf", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 5;
			local item = "scripts/items/misc/anatomist/white_direwolf_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	//necrosavant

	::mods_hookExactClass("entity/tactical/enemies/vampire", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 2.5;
			local item = "scripts/items/misc/anatomist/necrosavant_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/legend_vampire_lord", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 5;
			local item = "scripts/items/misc/anatomist/necrosavant_lord_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	//goblin

	::mods_hookExactClass("entity/tactical/goblin", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 1.25;
			local item = "scripts/items/misc/anatomist/goblin_grunt_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/goblin_leader", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 5;
			local item = "scripts/items/misc/anatomist/goblin_grunt_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	//orc

	::mods_hookExactClass("entity/tactical/enemies/legend_orc_behemoth", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 2.5;
			local item = "scripts/items/misc/anatomist/orc_young_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/legend_orc_elite", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 1.25;
			local item = "scripts/items/misc/anatomist/orc_young_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/orc_berserker", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 1.25;
			local item = "scripts/items/misc/anatomist/orc_young_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/orc_warrior", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 1.25;
			local item = "scripts/items/misc/anatomist/orc_young_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/orc_young", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 1.25;
			local item = "scripts/items/misc/anatomist/orc_young_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/orc_warlord", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 5;
			local item = "scripts/items/misc/anatomist/orc_warlord_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	//serpent

	::mods_hookExactClass("entity/tactical/enemies/serpent", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 2.5;
			local item = "scripts/items/misc/anatomist/serpent_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	//spider

	::mods_hookExactClass("entity/tactical/enemies/spider", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 1.25;
			local item = "scripts/items/misc/anatomist/webknecht_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/legend_redback_spider", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 2.5;
			local item = "scripts/items/misc/anatomist/wiederganger_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	//unhold
	::mods_hookExactClass("entity/tactical/enemies/unhold", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 2.5;
			local item = "scripts/items/misc/anatomist/unhold_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/legend_rock_unhold", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 5;
			local item = "scripts/items/misc/anatomist/ancient_priest_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	//nachzehrer
	::mods_hookExactClass("entity/tactical/enemies/ghoul", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 1.25;
			local item = "scripts/items/misc/anatomist/nachzehrer_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/legend_skin_ghoul", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 2.5;
			local item = "scripts/items/misc/anatomist/fallen_hero_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	//lindwurm
	::mods_hookExactClass("entity/tactical/enemies/lindwurm", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 5.0;
			local item = "scripts/items/misc/anatomist/lindwurm_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/legend_stollwurm", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 5.0;
			local item = "scripts/items/misc/anatomist/orc_warrior_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/schrat", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 5.0;
			local item = "scripts/items/misc/anatomist/schrat_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/legend_greenwood_schrat", function (o)
	{
		local onDeath = ::mods_getMember(o, "onDeath");
		o.onDeath = function(_killer, _skill, _tile, _fatalityType)
		{
			onDeath(_killer, _skill, _tile, _fatalityType);
			local chance = 5.0;
			local item = "scripts/items/misc/anatomist/ifrit_potion_item";
			this.getroottable().anatomists_expanded.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
		}
	});
	
	delete this.anatomists_expanded.hook_loot;
};