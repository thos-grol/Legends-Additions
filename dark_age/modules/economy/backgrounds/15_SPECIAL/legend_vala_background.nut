::mods_hookExactClass("skills/backgrounds/legend_vala_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.CustomPerkTree = [
			[
				this.Const.Perks.PerkDefs.Student,
				this.Const.Perks.PerkDefs.Colossus,
				this.Const.Perks.PerkDefs.Underdog,
				this.Const.Perks.PerkDefs.LoneWolf,

				this.Const.Perks.PerkDefs.LegendValaPremonition,
			],
			[
				this.Const.Perks.PerkDefs.Dodge,
			],
			[
				this.Const.Perks.PerkDefs.PatternRecognition,
				this.Const.Perks.PerkDefs.HoldOut,
				this.Const.Perks.PerkDefs.FortifiedMind,

				this.Const.Perks.PerkDefs.LegendValaChantFury,
				this.Const.Perks.PerkDefs.LegendValaTranceMalevolent,
				
			],
			[
				this.Const.Perks.PerkDefs.LegendValaChantMastery,
				this.Const.Perks.PerkDefs.LegendValaTranceMastery,
			],
			[
				this.Const.Perks.PerkDefs.ArcaneInsight,
				this.Const.Perks.PerkDefs.NineLives,
				this.Const.Perks.PerkDefs.SurvivalInstinct,
			],
			[
				this.Const.Perks.PerkDefs.Nimble,
				this.Const.Perks.PerkDefs.LegendValaWarden,			
			],
			[
				this.Const.Perks.PerkDefs.Indomitable,
				this.Const.Perks.PerkDefs.LegendMindOverBody,
				this.Const.Perks.PerkDefs.LegendValaSpiritualBond,
			],
			[],
			[],
			[],
			[]
		];
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.Bravery] = this.Math.rand(2, 3);
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(::new("scripts/items/weapons/legend_staff_vala"));
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"legend_vala_cloak"
			],
			[
				1,
				"legend_vala_dress"
			]
		]));

		this.getContainer().getActor().getSkills().add(this.new("scripts/skills/traits/bright_trait"));
	}

});

