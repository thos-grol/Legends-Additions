::mods_hookExactClass("skills/backgrounds/legend_husk_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		if ("Weapon" in this.m.PerkTreeDynamic)
		{
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.ThrowingTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.CrossbowTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.StaffTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.SwordTree );
		}
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.MeleeSkill] = 1;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 8);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/greenskins/legend_bone_carver"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_reinforced_flail"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
		}
		else if (r == 4)
		{
			if (::Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/battle_whip"));
			}
			else if (!::Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
			}
		}
		else if (r >= 5)
		{
			items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"tattered_sackcloth"
			],
			[
				1,
				"leather_wraps"
			],
			[
				1,
				"decayed_reinforced_mail_hauberk"
			],
			[
				1,
				"decayed_coat_of_plates"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"cultist_hood"
			],
			[
				1,
				"hood"
			],
			[
				1,
				"cultist_leather_hood"
			]
		]));
	}

});

