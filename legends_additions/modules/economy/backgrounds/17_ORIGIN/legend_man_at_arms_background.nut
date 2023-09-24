::mods_hookExactClass("skills/backgrounds/legend_man_at_arms_background", function(o) {
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
		local items = this.getContainer().getActor().getItems();
		local r;
		local weapons = [
			"weapons/arming_sword",
			"weapons/bludgeon",
			"weapons/boar_spear",
			"weapons/hand_axe",
			"weapons/military_pick",
			"weapons/hand_axe",
			"weapons/legend_glaive",
			"weapons/scramasax"
		];
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"worn_mail_shirt"
			],
			[
				2,
				"patched_mail_shirt"
			],
			[
				3,
				"leather_lamellar"
			],
			[
				3,
				"basic_mail_shirt"
			],
			[
				4,
				"gambeson"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				4,
				""
			],
			[
				3,
				"aketon_cap"
			],
			[
				1,
				"deep_sallet"
			],
			[
				2,
				"full_aketon_cap"
			],
			[
				2,
				"open_leather_cap"
			],
			[
				3,
				"full_leather_cap"
			]
		]));
		local rng = this.Math.rand(0, ::Const.Injury.Permanent.len() - 1);
		this.m.Container.add(this.new("scripts/skills/" + ::Const.Injury.Permanent[rng].Script));
	}

});

