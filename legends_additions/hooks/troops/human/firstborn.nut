::Const.Tactical.Actor.Envoy = {
	XP = 0,
	ActionPoints = 9,
	Hitpoints = 50,
	Bravery = 40,
	Stamina = 100,
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
::mods_hookExactClass("entity/tactical/humans/firstborn", function(o) {
	o.getPlaceInFormation = function()
	{
		return 26;
	}

	o.isReallyKilled = function( _fatalityType )
	{
		return true;
	}

	o.onInit = function()
	{
		this.player.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Envoy);
		b.TargetAttractionMult = 3.0;
		b.MoraleCheckBraveryMult[this.Const.MoraleCheckType.MentalAttack] = 1000.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
		this.m.Attributes.resize(this.Const.Attributes.COUNT, [
			0
		]);
		this.getSprite("socket").setBrush("bust_base_militia");
		this.setAppearance();
		this.assignRandomEquipment();
	}

	o.assignRandomEquipment = function()
	{
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic"
			]
		]));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"feathered_hat"
			],
			[
				3,
				""
			]
		]));
	}

});

