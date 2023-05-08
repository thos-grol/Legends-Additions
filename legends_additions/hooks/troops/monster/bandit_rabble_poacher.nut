::Const.Tactical.Actor.BanditRabble = {
	XP = 75,
	ActionPoints = 9,
	Hitpoints = 35,
	Bravery = 25,
	Stamina = 80,
	MeleeSkill = 40,
	RangedSkill = 30,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/enemies/bandit_rabble_poacher", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditRabble);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 10)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_pox_01");
		}
		else if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			b.RangedDefense += 5;
		}

		this.setArmorSaturation(0.8);
		this.getSprite("shield_icon").setBrightness(0.9);

		if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Easy)
		{
			this.m.Skills.add(this.new("scripts/skills/traits/craven_trait"));
		}

		if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Hard)
		{
			this.m.Skills.add(this.new("scripts/skills/traits/brave_trait"));
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/traits/determined_trait"));
		}

		this.m.Skills.update();
	}

	o.assignRandomEquipment = function()
	{
		local weapons = [
			[
				"weapons/short_bow",
				"ammo/quiver_of_arrows"
			],
			[
				"weapons/legend_sling"
			],
			[
				"weapons/legend_sling"
			]
		];
		local n = this.Math.rand(0, weapons.len() - 1);

		foreach( w in weapons[n] )
		{
			this.m.Items.equip(this.new("scripts/items/" + w));
		}

		this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));

		if (this.Math.rand(1, 100) <= 90)
		{
			local item = this.Const.World.Common.pickArmor([
				[
					20,
					"leather_wraps"
				],
				[
					20,
					"tattered_sackcloth"
				],
				[
					20,
					"legend_rabble_tunic"
				],
				[
					20,
					"monk_robe"
				],
				[
					20,
					"legend_rabble_fur"
				]
			]);
			this.m.Items.equip(item);
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			local item = this.Const.World.Common.pickHelmet([
				[
					1,
					"headscarf"
				],
				[
					1,
					"mouth_piece"
				]
			]);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}

});

