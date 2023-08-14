::Const.Tactical.Actor.SkeletonPriest = {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 110,
	Stamina = 100,
	MeleeSkill = 40,
	RangedSkill = 0,
	MeleeDefense = 0,
	RangedDefense = 5,
	Initiative = 5,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::mods_hookExactClass("entity/tactical/enemies/skeleton_priest", function(o) {
	o.onInit = function()
	{
		this.skeleton.onInit();
		this.getSprite("body").setBrush("bust_skeleton_body_02");
		this.setDirty(true);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonPriest);
		b.TargetAttractionMult = 3.0;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Skills.add(this.new("scripts/skills/actives/horror_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/miasma_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		}
	}

	o.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("Atheist", 1, 1);
		}

		if (this.LegendsMod.Configs().LegendMagicEnabled())
		{
			if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
			{
				local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = i )
				{
					local r = this.Math.rand(1, 100);
					local loot;

					if (r <= 5)
					{
						loot = this.new("scripts/items/misc/legend_ancient_scroll_item");
						loot.drop(_tile);
					}

					i = ++i;
				}
			}
		}

		this.skeleton.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	o.assignRandomEquipment = function()
	{
		local armor = [
			[
				1,
				"ancient/ancient_priest_attire"
			]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[
				99,
				"ancient/ancient_priest_diadem"
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

