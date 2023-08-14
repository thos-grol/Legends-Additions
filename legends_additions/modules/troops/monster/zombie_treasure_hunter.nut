::Const.Tactical.Actor.ZombieTreasureHunter = {
	XP = 250,
	ActionPoints = 8,
	Hitpoints = 180,
	Bravery = 90,
	Stamina = 100,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 0,
	Initiative = 70,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::mods_hookExactClass("entity/tactical/enemies/zombie_treasure_hunter", function(o) {
	o.onInit = function()
	{
		this.zombie_knight.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.ZombieTreasureHunter);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.FatigueDealtPerHitMult = 2.0;
		b.DamageTotalMult = 1.25;
		b.DamageReceivedArmorMult = 0.75;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.update();
	}

	o.assignRandomEquipment = function()
	{
		local r;

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/oriental/heavy_southern_mace"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/oriental/two_handed_scimitar"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		local aList = [
			[
				1,
				"oriental/stitched_nomad_armor"
			],
			[
				1,
				"oriental/leather_nomad_robe"
			],
			[
				1,
				"oriental/nomad_robe"
			],
			[
				1,
				"oriental/thick_nomad_robe"
			]
		];
		local armor = this.Const.World.Common.pickArmor(aList);
		this.m.Items.equip(armor);
		local helmet = [
			[
				1,
				"oriental/nomad_head_wrap"
			]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}

});

