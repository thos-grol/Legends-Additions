::Const.Tactical.Actor.FreeCompanyBillman = {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 65,
	Stamina = 120,
	MeleeSkill = 75,
	RangedSkill = 50,
	MeleeDefense = 5,
	RangedDefense = 15,
	Initiative = 95,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/free_company_billman", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FreeCompanyBillman);
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
		local r = this.Math.rand(1, 101);

		if (r <= 25)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
		}
		else if (r <= 49)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/longaxe"));
		}
		else if (r <= 73)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_voulge"));
		}
		else if (r <= 98)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_halberd"));
		}
		else if (r <= 99)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_military_voulge"));
		}
		else if (r <= 99)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_military_halberd"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/polehammer"));
		}

		this.free_company_abstract.assignRandomEquipment();
	}

});

