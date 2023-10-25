this.bandit_raider <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Name = "Raider";
		this.m.Type = this.Const.EntityType.BanditRaider;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditRaider.XP;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditRaider);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		this.abstract_human.assignRandomEquipment();
	}

	function pickOffhand()
	{
		if (::Math.rand(1, 100) > 25) return;

		this.m.PATTERN_OVERWRITE <- {};

		if (::Math.rand(1, 100) <= 80) //Sheild users
		{
			// ["T", 1],
			// ["D", 2],
			// ["W", 3], <- 3: ["Z", "scripts/skills/perks/perk_shield_bash"]
			// ["W", 4],
			// ["T", 5],
			// ["D", 6],
			// ["T", 3], <- 7: ["Z", "scripts/skills/perks/perk_shield_expert"]
			this.m.PATTERN_OVERWRITE[3] <- ["Z", "scripts/skills/perks/perk_shield_bash"];
			this.m.PATTERN_OVERWRITE[7] <- ["Z", "scripts/skills/perks/perk_shield_expert"];

			if (this.Math.rand(1, 100) <= 75) this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
			else this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));

		}
		else //nets
		{
			// ["T", 1],
			// ["D", 2],
			// ["W", 3], <- 3: ["Z", "scripts/skills/perks/perk_shield_bash"]
			// ["W", 4],
			// ["T", 5],
			// ["D", 6],
			// ["T", 3], <- 7: ["Z", "scripts/skills/perks/perk_shield_expert"]
			this.m.PATTERN_OVERWRITE[3] <- ["Z", "scripts/skills/perks/perk_legend_net_repair"];
			this.m.PATTERN_OVERWRITE[7] <- ["Z", "scripts/skills/perks/perk_legend_net_casting"];
			//net perk autoloads nets
		}

	}

	function pickOutfit()
	{
		local armor = [
			[
				1,
				"bandit_armor_medium"
			],
			[
				2,
				"bandit_armor_light"
			],
			[
				2,
				"leather_lamellar"
			]
		];
		local helmet = [
			[
				1,
				"nasal_helmet"
			],
			[
				1,
				"rondel_helm"
			],
			[
				1,
				"barbute_helmet"
			],
			[
				1,
				"scale_helm"
			],
			[
				1,
				"dented_nasal_helmet"
			],
			[
				1,
				"rusty_mail_coif"
			],
			[
				1,
				"headscarf"
			],
			[
				1,
				"nasal_helmet_with_rusty_mail"
			]
		];
		local outfits = [
			[
				1,
				"dark_southern_outfit_00"
			]
		];

		foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
		{
			this.m.Items.equip(item);
		}
	}

});

