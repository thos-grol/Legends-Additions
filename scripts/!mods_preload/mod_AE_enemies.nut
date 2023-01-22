this.getroottable().AE.hook_enemies <- function ()
{
	//add potion code to actor class
	::mods_hookExactClass("entity/tactical/actor", function (o)
	{
		o.add_potion <- function(name, complete)
		{
			switch(name)
			{
				case "serpent":
					this.getFlags().add("serpent");
					this.m.Skills.add(this.new("scripts/skills/effects/serpent_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/effects/webknecht_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
					break;
				case "direwolf":
					this.getFlags().add("werewolf");
					this.m.Skills.add(this.new("scripts/skills/racial/werewolf_player_racial"));
					this.m.Skills.add(this.new("scripts/skills/effects/direwolf_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/effects/alp_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));

					if (complete)
					{
						this.getFlags().add("werewolf_8");
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));
						this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
					}
					break;
				case "ghoul":
					this.getFlags().add("ghoul");
					this.m.Skills.add(this.new("scripts/skills/effects/nachzehrer_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_gruesome_feast"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));

					if (complete)
					{
						this.getFlags().add("ghoul_8");
						this.m.Skills.add(this.new("scripts/skills/effects/unhold_potion_effect"));
						this.m.Skills.add(this.new("scripts/skills/effects/hyena_potion_effect"));
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lacerate"));
					}
					break;
				case "spider":
					this.getFlags().add("spider");
					this.m.Skills.add(this.new("scripts/skills/effects/serpent_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/effects/webknecht_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/effects/alp_potion_effect"));

					if (complete)
					{
						this.getFlags().add("spider_8");
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_item_web_skill"));
						this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
					}
					break;
				case "unhold":
					this.m.Skills.add(this.new("scripts/skills/traits/huge_trait"));
					this.getFlags().add("unhold");
					this.m.Skills.add(this.new("scripts/skills/effects/unhold_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/effects/wiederganger_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));

					if (complete)
					{
						this.getFlags().add("unhold_8");
						this.m.Skills.add(this.new("scripts/skills/effects/orc_warrior_potion_effect"));
					}
					break;
				case "orc":
					this.m.Skills.add(this.new("scripts/skills/traits/huge_trait"));
					this.getFlags().add("orc");
					this.m.Skills.add(this.new("scripts/skills/effects/orc_young_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/effects/orc_warrior_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_hale_and_hearty"));

					if (complete)
					{
						this.getFlags().add("orc_8");
						this.m.Skills.add(this.new("scripts/skills/effects/orc_warlord_potion_effect"));
						this.m.Skills.add(this.new("scripts/skills/effects/orc_berserker_potion_effect"));
					}
					break;
				case "necrosavant":
					this.getFlags().add("vampire");
					this.m.Skills.add(this.new("scripts/skills/effects/necrosavant_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bloodlust"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_sanguinary"));
					if (complete)
					{
						this.getFlags().add("vampire_8");
						this.m.Skills.add(this.new("scripts/skills/effects/ancient_priest_potion_effect"));
						this.m.Skills.add(this.new("scripts/skills/actives/darkflight"));
						this.m.Skills.add(this.new("scripts/skills/effects/webknecht_potion_effect"));
					}
					break;
				case "goblin":
					this.m.Skills.add(this.new("scripts/skills/traits/tiny_trait"));
					this.getFlags().add("goblin");
					this.m.Skills.add(this.new("scripts/skills/effects/goblin_overseer_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/effects/goblin_grunt_potion_effect"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_nailed_it"));
					break;
			}
			
		}
		
	});

	//////////////////////////////// AI ///////////////////////////////////////////

	::mods_hookExactClass("ai/tactical/agents/bandit_melee_agent", function (o)
	{
		local onAddBehaviors = o.onAddBehaviors;
		o.onAddBehaviors = function()
		{
			onAddBehaviors();
			this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_gruesome_feast_potion"));
			this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_darkflight"));
		}
	});

	::mods_hookExactClass("ai/tactical/agents/bounty_hunter_melee_agent", function (o)
	{
		local onAddBehaviors = o.onAddBehaviors;
		o.onAddBehaviors = function()
		{
			onAddBehaviors();
			this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_gruesome_feast_potion"));
			this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_darkflight"));
		}
	});

	::mods_hookExactClass("ai/tactical/agents/military_melee_agent", function (o)
	{
		local onAddBehaviors = o.onAddBehaviors;
		o.onAddBehaviors = function()
		{
			onAddBehaviors();
			this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_gruesome_feast_potion"));
			this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_darkflight"));
		}
	});


	//////////////////////////////// Enemies ///////////////////////////////////////////

	//bandits
	::mods_hookExactClass("entity/tactical/enemies/legend_bandit_warlord", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 20.0)
			{
				if (roll <= 4.0) this.add_potion("ghoul", true);
				else if (roll <= 8.0) this.add_potion("ghoul", false);
				else if (roll <= 12.0) this.add_potion("orc", true);
				else if (roll <= 16.0) this.add_potion("orc", false);
				else if (roll <= 20.0) this.add_potion("necrosavant", true);
			}
		}

		local assignRandomEquipment = o.assignRandomEquipment;
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
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0)
			{
				if (roll <= 3.0) this.add_potion("ghoul", true);
				else if (roll <= 6.0) this.add_potion("ghoul", false);
				else if (roll <= 9.0) this.add_potion("orc", true);
				else if (roll <= 12.0) this.add_potion("orc", false);
				else this.add_potion("unhold", true);
			}
		}
	});

	::mods_hookExactClass("entity/tactical/enemies/legend_bandit_veteran", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0)
			{
				if (roll <= 5.0) this.add_potion("ghoul", true);
				else if (roll <= 10.0) this.add_potion("direwolf", false);
				else if (roll <= 15.0) this.add_potion("direwolf", true);
			}
		}
	});

	::mods_hookExactClass("entity/tactical/humans/nomad_leader", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 30.0) this.add_potion("serpent", true);
		}
	});

	::mods_hookExactClass("entity/tactical/humans/executioner", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 30.0) this.add_potion("serpent", true);
		}
	});

	::mods_hookExactClass("entity/tactical/humans/desert_devil", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 25.0) this.add_potion("serpent", true);
		}
	});

	::mods_hookExactClass("entity/tactical/humans/barbarian_chosen", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 25.0) this.add_potion("unhold", true);
		}
	});

	::mods_hookExactClass("entity/tactical/humans/barbarian_champion", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 20.0) this.add_potion("unhold", true);
		}
	});

	::mods_hookExactClass("entity/tactical/humans/mercenary", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 3.0) this.add_potion("serpent", true);
			else if (roll <= 6.0) this.add_potion("spider", false);
			else if (roll <= 9.0) this.add_potion("direwolf", false);
			else if (roll <= 12.0) this.add_potion("ghoul", false);
			else if (roll <= 15.0) this.add_potion("orc", false);
		}
	});

	::mods_hookExactClass("entity/tactical/humans/knight", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 30.0) this.add_potion("necrosavant", true);
		}
	});

	::mods_hookExactClass("entity/tactical/humans/swordmaster", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 30.0) this.add_potion("serpent", true);
		}
	});

	::mods_hookExactClass("entity/tactical/humans/hedge_knight", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0) this.add_potion("unhold", true);
		}
	});

	::mods_hookExactClass("entity/tactical/humans/master_archer", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 20.0) this.add_potion("goblin", true);
		}
	});
};