::mods_hookExactClass("skills/backgrounds/assassin_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.CrossbowTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.FitTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [
				this.Const.Perks.SwordmastersTree,
				this.Const.Perks.NoblesTree,
				this.Const.Perks.MercenaryTree
			],
			Class = [],
			Magic = [
				this.Const.Perks.AssassinMagicTree
			]
		};

		this.m.PerkTreeDynamicMins.Traits = 4;
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.Initiative] = 2;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/rondel_dagger"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"thick_dark_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			]
		]));
	}

});
