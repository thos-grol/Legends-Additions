
//Lv 5 Template
::Const.Tactical.Actor.LegendPeasantBlacksmith <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 68,
	Bravery = 35,
	Stamina = 105,
	MeleeSkill = 60,
	RangedSkill = 10,
	MeleeDefense = 5,
	RangedDefense = -3,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/legend_peasant_blacksmith", function(o) {
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		assignRandomEquipment();
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_hammer_skill"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_hammer_damage"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_internal_hemorrhage"));

		this.level_melee_skill(4, ::Math.rand(-6, 3) );
		this.level_melee_defense(4, ::Math.rand(-6, 3) );
		this.level_health(4, ::Math.rand(-6, 3) );

	}

    o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendPeasantBlacksmith);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = ::Math.rand(0, 255);
		this.getSprite("socket").setBrush("bust_base_militia");
	}
});
