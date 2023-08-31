::mods_hookExactClass("skills/backgrounds/raider_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.AxeTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.ShieldTree,
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [],
			Enemy = [],
			Class = [],
			Magic = []
		};

		this.m.PerkTreeDynamicMins.Traits = 4;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 5);

		if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/morning_star"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"patched_mail_shirt"
			],
			[
				1,
				"padded_leather"
			],
			[
				1,
				"leather_lamellar"
			],
			[
				1,
				"worn_mail_shirt"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"dented_nasal_helmet"
			],
			[
				1,
				"nasal_helmet_with_rusty_mail"
			]
		]));
	}

});

