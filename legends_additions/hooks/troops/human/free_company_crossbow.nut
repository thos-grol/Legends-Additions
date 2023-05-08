::Const.Tactical.Actor.FreeCompanyCrossbow = {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 40,
	Bravery = 55,
	Stamina = 120,
	MeleeSkill = 55,
	RangedSkill = 65,
	MeleeDefense = 5,
	RangedDefense = 20,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/free_company_crossbow", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FreeCompanyCrossbow);
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

		if (r <= 90)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
		}
		else if (r <= 99)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/light_crossbow"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
		}

		r = this.Math.rand(1, 4);

		if (r == 4)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));
		}
		else
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
		}

		this.free_company_abstract.assignRandomEquipment();
	}

});

