::Const.Tactical.Actor.LegendPeasantButcher = {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 50,
	Stamina = 100,
	MeleeSkill = 60,
	RangedSkill = 10,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/legend_peasant_butcher", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantButcher);
		this.m.Hitpoints = b.Hitpoints;
		this.m.ActionPoints = b.ActionPoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_butcher_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_prepare_bleed_skill"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lacerate"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_slaughter"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_butcher_damage"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				7,
				"butcher_apron"
			],
			[
				1,
				"leather_wraps"
			]
		]));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"headscarf"
					],
					[
						1,
						"hood"
					],
					[
						1,
						"headscarf"
					],
					[
						1,
						"feathered_hat"
					]
				]));
			}
		}
	}

	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.m.Items.equip(this.new("scripts/items/weapons/named/legend_named_butchers_cleaver"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lacerate"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_slaughter"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_slaughterer"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_butcher_damage"));
		this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"legend_champion_butcher_helmet"
			]
		]));
	}

});

