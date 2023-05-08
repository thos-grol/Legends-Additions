::Const.Tactical.Actor.FreeCompanySpearman = {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 90,
	Bravery = 55,
	Stamina = 120,
	MeleeSkill = 60,
	RangedSkill = 50,
	MeleeDefense = 15,
	RangedDefense = 5,
	Initiative = 75,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/free_company_spearman_low", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FreeCompanySpearman);
		b.MeleeSkill -= 10;
		b.MeleeDefense -= 5;
		b.Hitpoints -= 5;
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
		if (this.Math.rand(0, 1) == 0)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));
		}

		if (this.Math.rand(0, 2) != 0)
		{
			if (this.Math.rand(0, 1) == 0)
			{
				this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
			}
		}

		this.free_company_abstract.assignRandomEquipment();
	}

});

