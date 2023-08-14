::Const.Tactical.Actor.FreeCompanyArcher = {
	XP = 175,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 50,
	Stamina = 110,
	MeleeSkill = 55,
	RangedSkill = 65,
	MeleeDefense = 5,
	RangedDefense = 10,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/free_company_archer_low", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FreeCompanyArcher);
		b.RangedSkill -= 10;
		b.MeleeDefense -= 5;
		b.RangedDefense -= 5;
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
		this.m.Items.equip(this.new("scripts/items/weapons/short_bow"));
		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
		this.free_company_abstract.assignRandomEquipment();
	}

});

