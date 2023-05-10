::mods_hookExactClass("skills/backgrounds/legend_husk_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0, ::Const.Perks.TalentedTree],
			[0, ::Const.Perks.DeviousTree],
			[0, ::Const.Perks.CalmTree],
			[0, ::Const.Perks.OrganisedTree],
			[0, ::Const.Perks.TrainedTree],
			[0, ::Const.Perks.SergeantClassTree],
			[0, ::Const.Perks.HealerClassTree],
			[0, ::Const.Perks.TrapperClassTree],
			[0, ::Const.Perks.ChefClassTree],
			[0, ::Const.Perks.ClerkClassTree],
			[0, ::Const.Perks.HoundmasterClassTree],
			[0, ::Const.Perks.TacticianClassTree],
			[0, ::Const.Perks.ScoutClassTree],
			[0, ::Const.Perks.EntertainerClassTree],
			[0, ::Const.Perks.RangedTree],
			[0, ::Const.Perks.DaggerTree],
			[0, ::Const.Perks.BowTree],
			[0, ::Const.Perks.CrossbowTree],
			[0.5, ::Const.Perks.PolearmTree],
			[0, ::Const.Perks.SlingTree],
			[0.5, ::Const.Perks.ThrowingTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.CultistProfessionTree
			],
			Weapon = [
				::Const.Perks.CleaverTree,
				::Const.Perks.FlailTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 1;
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
			if (this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/battle_whip"));
			}
			else if (!this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
			}
		}
		else if (r >= 5)
		{
			items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));
		}

		items.equip(this.Const.World.Common.pickArmor([
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
		items.equip(this.Const.World.Common.pickHelmet([
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

