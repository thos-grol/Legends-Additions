::mods_hookExactClass("skills/backgrounds/legend_vala_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.CustomPerkTree = [
			[
				::Const.Perks.PerkDefs.Student,
				::Const.Perks.PerkDefs.Colossus,
				::Const.Perks.PerkDefs.Underdog,
				::Const.Perks.PerkDefs.LoneWolf,

				::Const.Perks.PerkDefs.LegendValaPremonition,
			],
			[
				::Const.Perks.PerkDefs.Dodge,
				::Const.Perks.PerkDefs.LegendValaWarden,

			],
			[
				::Const.Perks.PerkDefs.PatternRecognition,
				::Const.Perks.PerkDefs.HoldOut,
				::Const.Perks.PerkDefs.FortifiedMind,
				::Const.Perks.PerkDefs.LegendAmbidextrous,
			],
			[
				::Const.Perks.PerkDefs.LegendValaChantFury,
				::Const.Perks.PerkDefs.LegendValaTranceMalevolent,
				::Const.Perks.PerkDefs.LegendSpecFists,
				::Const.Perks.PerkDefs.LegendKnifeplay,

			],
			[
				::Const.Perks.PerkDefs.ArcaneInsight,
				::Const.Perks.PerkDefs.NineLives,
				::Const.Perks.PerkDefs.SurvivalInstinct,
			],
			[
				::Const.Perks.PerkDefs.Nimble,
			],
			[
				::Const.Perks.PerkDefs.Indomitable,
				::Const.Perks.PerkDefs.LegendMindOverBody,
				::Const.Perks.PerkDefs.LegendValaChantMastery,
				::Const.Perks.PerkDefs.LegendValaTranceMastery,
				::Const.Perks.PerkDefs.StanceAsura,
			],
			[],
			[],
			[],
			[]
		];
	}

	o.onAddEquipment = function()
	{
        local actor = this.getContainer().getActor();
		local talents = actor.getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.Bravery] = ::Math.rand(2, 3);
		actor.fillTalentValues(2, true);
		local items = actor.getItems();
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

		local bright = ::new("scripts/skills/traits/bright_trait");
		actor.getSkills().add(bright);
		bright.upgrade();
		bright.upgrade();
	}

});

