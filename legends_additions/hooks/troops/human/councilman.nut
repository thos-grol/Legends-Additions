::Const.Tactical.Actor.Councilman = {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 40,
	Stamina = 120,
	MeleeSkill = 50,
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
::mods_hookExactClass("entity/tactical/humans/councilman", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Councilman);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.getSprite("socket").setBrush("bust_base_military");
	}

	o.assignRandomEquipment = function()
	{
		local r;
		r = this.Math.rand(1, 11);
		local withDetail = true;
		local withHelmet = true;

		if (r <= 7)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"linen_tunic"
				]
			]));

			if (this.Math.rand(1, 100) <= 33)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"feathered_hat"
					]
				]));
				withHelmet = false;
			}
		}
		else if (r <= 9)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"noble_tunic"
				]
			]));
		}
		else if (r == 10)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"monk_robe"
				]
			]));
			withDetail = false;
			withHelmet = false;
		}
		else if (r == 11)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"wizard_robe"
				]
			]));
			withDetail = false;

			if (this.Math.rand(1, 100) <= 50)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"wizard_hat"
					]
				]));
				withHelmet = false;
			}
		}

		if (withDetail && this.Math.rand(1, 100) <= 66)
		{
			local variants = [
				"01",
				"06",
				"07",
				"08",
				"09"
			];
			this.getSprite("surcoat").setBrush("bust_body_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
		}

		if (withHelmet && this.Math.rand(1, 100) <= 25)
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"feathered_hat"
					]
				]));
			}
			else
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"noble_headgear"
					]
				]));
			}
		}
	}

});

