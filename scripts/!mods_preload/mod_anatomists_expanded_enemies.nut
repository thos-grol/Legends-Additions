this.getroottable().anatomists_expanded.hook_enemies <- function ()
{
	//ai
	::mods_hookExactClass("ai/tactical/agents/bandit_melee_agent", function (o)
	{
		local onAddBehaviors = ::mods_getMember(o, "onAddBehaviors");
		o.onAddBehaviors = function()
		{
			onAddBehaviors();
			this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_gruesome_feast_potion"));
			this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_darkflight"));
		}
	});

	::mods_hookExactClass("ai/tactical/agents/bounty_hunter_melee_agent", function (o)
	{
		local onAddBehaviors = ::mods_getMember(o, "onAddBehaviors");
		o.onAddBehaviors = function()
		{
			onAddBehaviors();
			this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_gruesome_feast_potion"));
			this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_darkflight"));
		}
	});

	::mods_hookExactClass("ai/tactical/agents/military_melee_agent", function (o)
	{
		local onAddBehaviors = ::mods_getMember(o, "onAddBehaviors");
		o.onAddBehaviors = function()
		{
			onAddBehaviors();
			this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_gruesome_feast_potion"));
			this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_darkflight"));
		}
	});

	//bandits
	::mods_hookExactClass("entity/tactical/enemies/legend_bandit_warlord", function (o)
	{
		local onInit = ::mods_getMember(o, "onInit");
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 20.0)
			{
				if (roll <= 4.0)
				{
					this.getroottable().anatomists_expanded.add_ghoul(this.actor, true);
				}
				else if (roll <= 8.0)
				{
					this.getroottable().anatomists_expanded.add_ghoul(this.actor, false);
				}
				else if (roll <= 12.0)
				{
					this.getroottable().anatomists_expanded.add_orc(this.actor, true);
				}
				else if (roll <= 16.0)
				{
					this.getroottable().anatomists_expanded.add_orc(this.actor, false);
				}
				else if (roll <= 20.0)
				{
					this.getroottable().anatomists_expanded.add_necrosavant(this.actor, true);
				}
			}
		}

		local assignRandomEquipment = ::mods_getMember(o, "assignRandomEquipment");
		o.assignRandomEquipment = function()
		{
			assignRandomEquipment();
			if (this.actor.getFlags().has("orc_8"))
			{
				local weapons = [
					"weapons/greenskins/orc_axe",
					"weapons/greenskins/orc_cleaver",
					"weapons/greenskins/orc_axe_2h",
					"weapons/greenskins/orc_axe_2h"
				];

				if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).isNamed())
				{
					weapons = [
						"weapons/named/named_orc_cleaver",
						"weapons/named/named_orc_axe_2h",
						"weapons/named/named_orc_flail_2h",
						"weapons/named/named_orc_axe"
					];
				}

				this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
				this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/bandit_leader", function (o)
	{
		local onInit = ::mods_getMember(o, "onInit");
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0)
			{
				if (roll <= 3.0)
				{
					this.getroottable().anatomists_expanded.add_ghoul(this.actor, true);
				}
				else if (roll <= 6.0)
				{
					this.getroottable().anatomists_expanded.add_ghoul(this.actor, false);
				}
				else if (roll <= 9.0)
				{
					this.getroottable().anatomists_expanded.add_orc(this.actor, true);
				}
				else if (roll <= 12.0)
				{
					this.getroottable().anatomists_expanded.add_orc(this.actor, false);
				}
				else
				{
					this.getroottable().anatomists_expanded.add_unhold(this.actor, true);
				}
			}
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/legend_bandit_veteran", function (o)
	{
		local onInit = ::mods_getMember(o, "onInit");
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0)
			{
				if (roll <= 5.0)
				{
					this.getroottable().anatomists_expanded.add_ghoul(this.actor, true);
				}
				else if (roll <= 10.0)
				{
					this.getroottable().anatomists_expanded.add_direwolf(this.actor, false);
				}
				else if (roll <= 15.0)
				{
					this.getroottable().anatomists_expanded.add_direwolf(this.actor, true);
				}
			}
		}
	});

	::mods_hookExactClass("entity/tactical/humans/nomad_leader", function (o)
	{
		local onInit = ::mods_getMember(o, "onInit");
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 30.0)
			{
				this.getroottable().anatomists_expanded.add_serpent(this.actor, true);
			}
		}
	});

	::mods_hookExactClass("entity/tactical/humans/executioner", function (o)
	{
		local onInit = ::mods_getMember(o, "onInit");
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 30.0)
			{
				this.getroottable().anatomists_expanded.add_serpent(this.actor, true);
			}
		}
	});

	::mods_hookExactClass("entity/tactical/humans/desert_devil", function (o)
	{
		local onInit = ::mods_getMember(o, "onInit");
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 30.0)
			{
				this.getroottable().anatomists_expanded.add_serpent(this.actor, true);
			}
		}
	});

	::mods_hookExactClass("entity/tactical/humans/barbarian_chosen", function (o)
	{
		local onInit = ::mods_getMember(o, "onInit");
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 25.0)
			{
				this.getroottable().anatomists_expanded.add_unhold(this.actor, true);
			}
		}
	});

	::mods_hookExactClass("entity/tactical/humans/barbarian_champion", function (o)
	{
		local onInit = ::mods_getMember(o, "onInit");
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 20.0)
			{
				this.getroottable().anatomists_expanded.add_unhold(this.actor, true);
			}
		}
	});

	::mods_hookExactClass("entity/tactical/humans/mercenary", function (o)
	{
		local onInit = ::mods_getMember(o, "onInit");
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0)
			{
				if (roll <= 3.0)
				{
					this.getroottable().anatomists_expanded.add_serpent(this.actor, false);
				}
				else if (roll <= 6.0)
				{
					this.getroottable().anatomists_expanded.add_spider(this.actor, false);
				}
				else if (roll <= 9.0)
				{
					this.getroottable().anatomists_expanded.add_direwolf(this.actor, false);
				}
				else if (roll <= 12.0)
				{
					this.getroottable().anatomists_expanded.add_ghoul(this.actor, false);
				}
				else if (roll <= 15.0)
				{
					this.getroottable().anatomists_expanded.add_orc(this.actor, false);
				}
			}
		}
	});

	::mods_hookExactClass("entity/tactical/humans/knight", function (o)
	{
		local onInit = ::mods_getMember(o, "onInit");
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0)
			{
				this.getroottable().anatomists_expanded.add_necrosavant(this.actor, true);
			}
		}
	});

	::mods_hookExactClass("entity/tactical/humans/swordmaster", function (o)
	{
		local onInit = ::mods_getMember(o, "onInit");
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0)
			{
				this.getroottable().anatomists_expanded.add_serpent(this.actor, true);
			}
		}
	});

	::mods_hookExactClass("entity/tactical/humans/hedge_knight", function (o)
	{
		local onInit = ::mods_getMember(o, "onInit");
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0)
			{
				this.getroottable().anatomists_expanded.add_unhold(this.actor, true);
			}
		}
	});

	::mods_hookExactClass("entity/tactical/humans/master_archer", function (o)
	{
		local onInit = ::mods_getMember(o, "onInit");
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0)
			{
				this.getroottable().anatomists_expanded.add_goblin(this.actor, true);
			}
		}
	});
	
	delete this.anatomists_expanded.hook_enemies;
};

this.getroottable().anatomists_expanded.add_serpent <- function (_actor, complete)
{
	_actor.getFlags().add("serpent");
	_actor.getSkills().add(this.new("scripts/skills/effects/serpent_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/webknecht_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
}

this.getroottable().anatomists_expanded.add_direwolf <- function (_actor, complete)
{
	_actor.getFlags().add("werewolf");
	_actor.getSkills().add(this.new("scripts/skills/racial/werewolf_player_racial"));
	_actor.getSkills().add(this.new("scripts/skills/effects/direwolf_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/alp_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));

	if (complete)
	{
		_actor.getFlags().add("werewolf_8");
		_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_battleheart"));
		_actor.getSkills().add(this.new("scripts/skills/perks/perk_pathfinder"));
	}
}

this.getroottable().anatomists_expanded.add_ghoul <- function (_actor, complete)
{
	_actor.getFlags().add("ghoul");
	_actor.getSkills().add(this.new("scripts/skills/effects/nachzehrer_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_gruesome_feast"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_alert"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_killing_frenzy"));

	if (complete)
	{
		_actor.getFlags().add("ghoul_8");
		_actor.getSkills().add(this.new("scripts/skills/effects/unhold_potion_effect"));
		_actor.getSkills().add(this.new("scripts/skills/effects/hyena_potion_effect"));
		_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_lacerate"));
	}
}

this.getroottable().anatomists_expanded.add_spider <- function (_actor, complete)
{
	_actor.getFlags().add("spider");
	_actor.getSkills().add(this.new("scripts/skills/effects/serpent_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/webknecht_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/alp_potion_effect"));

	if (complete)
	{
		_actor.getFlags().add("spider_8");
		_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_item_web_skill"));
		_actor.getSkills().add(this.new("scripts/skills/perks/perk_nimble"));
	}
}

this.getroottable().anatomists_expanded.add_unhold <- function (_actor, complete)
{
	_actor.getSkills().add(this.new("scripts/skills/traits/huge_trait"));
	_actor.getFlags().add("unhold");
	_actor.getSkills().add(this.new("scripts/skills/effects/unhold_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/wiederganger_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_colossus"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_muscularity"));

	if (complete)
	{
		_actor.getFlags().add("unhold_8");
		_actor.getSkills().add(this.new("scripts/skills/effects/orc_warrior_potion_effect"));
	}
}

this.getroottable().anatomists_expanded.add_orc <- function (_actor, complete)
{
	_actor.getSkills().add(this.new("scripts/skills/traits/huge_trait"));
	_actor.getFlags().add("orc");
	_actor.getSkills().add(this.new("scripts/skills/effects/orc_young_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/orc_warrior_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_colossus"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_hale_and_hearty"));

	if (complete)
	{
		_actor.getFlags().add("orc_8");
		_actor.getSkills().add(this.new("scripts/skills/effects/orc_warlord_potion_effect"));
		_actor.getSkills().add(this.new("scripts/skills/effects/orc_berserker_potion_effect"));
	}
}

this.getroottable().anatomists_expanded.add_necrosavant <- function (_actor, complete)
{
	_actor.getFlags().add("vampire");
	_actor.getSkills().add(this.new("scripts/skills/effects/necrosavant_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_nine_lives"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_bloodlust"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_sanguinary"));
	if (complete)
	{
		_actor.getFlags().add("vampire_8");
		_actor.getSkills().add(this.new("scripts/skills/effects/ancient_priest_potion_effect"));
		_actor.getSkills().add(this.new("scripts/skills/actives/darkflight"));
		_actor.getSkills().add(this.new("scripts/skills/effects/webknecht_potion_effect"));
	}
}

this.getroottable().anatomists_expanded.add_goblin <- function (_actor, complete)
{
	_actor.getSkills().add(this.new("scripts/skills/traits/tiny_trait"));
	_actor.getFlags().add("goblin");
	_actor.getSkills().add(this.new("scripts/skills/effects/goblin_overseer_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/effects/goblin_grunt_potion_effect"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_footwork"));
	_actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_nailed_it"));
}

