::mods_hookExactClass("skills/backgrounds/legend_berserker_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.MaceTree,
				::Const.Perks.AxeTree,
				::Const.Perks.ThrowingTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.SturdyTree,
				::Const.Perks.IndestructibleTree,
				::Const.Perks.LargeTree,
				::Const.Perks.FitTree
			],
			Enemy = [
				::Const.Perks.OrcTree,
				::Const.Perks.GoblinTree
			],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = [
				::Const.Perks.BerserkerMagicTree
			]
		};
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.MeleeSkill] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		local stash = this.World.Assets.getStash();
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		stash.add(this.new("scripts/items/supplies/roots_and_berries_item"));
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"barbarians/hide_and_bone_armor"
			]
		]));
		local item = ::Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/leather_helmet"
			]
		]);
		local r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/ancient/rhomphaia"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/warbrand"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/ancient/crypt_cleaver"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_longsword"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/greenskins/orc_axe_2h"));
		}

		this.getContainer().getActor().TherianthropeInfectionRandom();
	}

});
