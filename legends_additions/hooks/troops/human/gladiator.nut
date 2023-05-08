::Const.Tactical.Actor.Gladiator = {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 110,
	Bravery = 90,
	Stamina = 135,
	MeleeSkill = 75,
	RangedSkill = 65,
	MeleeDefense = 20,
	RangedDefense = 10,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
::mods_hookExactClass("entity/tactical/humans/gladiator", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Gladiator);
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
		this.getSprite("socket").setBrush("bust_base_southern");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
	}

	o.assignRandomEquipment = function()
	{
		local r;

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/shamshir",
				"weapons/oriental/heavy_southern_mace",
				"weapons/oriental/heavy_southern_mace",
				"weapons/fighting_axe",
				"weapons/fighting_axe",
				"weapons/fighting_spear"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/oriental/two_handed_scimitar",
					"weapons/oriental/swordlance",
					"weapons/oriental/polemace",
					"weapons/two_handed_hammer",
					"weapons/greataxe",
					"weapons/legend_ranged_flail"
				]);
			}

			if (this.Const.DLC.Wildmen && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/two_handed_flail",
					"weapons/two_handed_flanged_mace",
					"weapons/bardiche"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 50)
		{
			local weapons = [
				"weapons/throwing_axe",
				"weapons/javelin"
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.push("weapons/throwing_spear");
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			local offhand = [
				"tools/throwing_net",
				"shields/oriental/metal_round_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + offhand[this.Math.rand(0, offhand.len() - 1)]));
		}

		local armor = this.Const.World.Common.pickArmor([
			[
				1,
				"oriental/gladiator_harness"
			]
		]);

		if (this.Math.rand(1, 3) <= 2)
		{
			armor.setUpgrade(this.new("scripts/items/" + (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue() ? "legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade" : "armor_upgrades/heavy_gladiator_upgrade")));
		}
		else
		{
			armor.setUpgrade(this.new("scripts/items/" + (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue() ? "legend_armor/armor_upgrades/legend_light_gladiator_upgrade" : "armor_upgrades/light_gladiator_upgrade")));
		}

		this.m.Items.equip(armor);
		local helm = this.Const.World.Common.pickHelmet([
			[
				1,
				"oriental/gladiator_helmet",
				this.Math.rand(13, 15)
			],
			[
				1,
				""
			]
		]);
		this.m.Items.equip(helm);
	}

	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local r = this.Math.rand(1, 3);
		local armor = clone this.Const.Items.NamedSouthernArmors;
		local helmets = clone this.Const.Items.NamedSouthernHelmets;

		if (r == 1)
		{
			if (this.Math.rand(0, 1) == 0)
			{
				this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedSouthernMeleeWeapons[this.Math.rand(0, this.Const.Items.NamedSouthernMeleeWeapons.len() - 1)]));
			}
			else
			{
				local namedWeaponArray = clone ::Const.Items.NamedMeleeWeapons;
				::MSU.Array.remove(namedWeaponArray, "weapons/named/named_dagger");
				::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_parrying_dagger");
				::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_shovel");
				::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_sickle");
				this.m.Items.equip(this.new("scripts/items/" + ::MSU.Array.rand(namedWeaponArray)));
			}
		}
		else if (r == 2)
		{
			if (this.Math.rand(0, 1) == 0)
			{
				this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedSouthernShields[this.Math.rand(0, this.Const.Items.NamedSouthernShields.len() - 1)]));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedShields[this.Math.rand(0, this.Const.Items.NamedShields.len() - 1)]));
			}
		}
		else if (r == 3)
		{
			if (this.Math.rand(0, 1) == 0)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor(this.Const.World.Common.convNameToList(armor)));
			}
			else
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet(this.Const.World.Common.convNameToList(helmets)));
			}
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
		return true;
	}

});

