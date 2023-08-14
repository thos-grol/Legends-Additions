::Const.Tactical.Actor.FreeCompanySlayer = {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 55,
	Stamina = 110,
	MeleeSkill = 70,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 5,
	Initiative = 75,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
::mods_hookExactClass("entity/tactical/humans/free_company_slayer", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FreeCompanySlayer);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
	}

	o.assignRandomEquipment = function()
	{
		local r = this.Math.rand(1, 100);

		if (r <= 32)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
		}
		else if (r <= 64)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/flail"));
		}
		else if (r <= 96)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/three_headed_flail"));
		}

		r = this.Math.rand(1, 100);

		if (r <= 30)
		{
			this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
		}
		else if (r <= 60)
		{
			this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
		}
		else if (r <= 70)
		{
			this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 50)
		{
			r = this.Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
			}
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
			}
		}

		this.free_company_abstract.assignRandomEquipment();
	}

});

