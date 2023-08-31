::mods_hookExactClass("skills/backgrounds/sellsword_background", function(o) {
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
				this.Const.Perks.FlailTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.ShieldTree,
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
			],
			Enemy = [],
			Class = [
				this.Const.Perks.BeastClassTree
			],
			Magic = []
		};

		this.m.PerkTreeDynamicMins.Traits = 4;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/flail"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/greataxe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/billhook"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/winged_mace"));
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
				"basic_mail_shirt"
			],
			[
				1,
				"worn_mail_shirt"
			],
			[
				1,
				"leather_lamellar"
			],
			[
				1,
				"mail_shirt"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"nasal_helmet"
			],
			[
				1,
				"padded_nasal_helmet"
			],
			[
				1,
				"mail_coif"
			],
			[
				1,
				"closed_mail_coif"
			],
			[
				1,
				"reinforced_mail_coif"
			],
			[
				1,
				"kettle_hat"
			],
			[
				1,
				"padded_kettle_hat"
			],
			[
				1,
				"hood"
			]
		]));
	}

});

