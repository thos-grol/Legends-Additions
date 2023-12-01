//convert function, see zz_la_cultists for tree changes
::mods_hookExactClass("skills/backgrounds/character_background", function (o)
{
    o.Convert = function()
	{
		this.addBackgroundType(::Const.BackgroundType.ConvertedCultist);
		local cultistGroup = [
			[],
			[
				::Const.Perks.PerkDefs.LegendSpecCultHood
			],
			[],
			[],
			[],
			[
				::Const.Perks.PerkDefs.LegendSpecCultArmor
			],
			[]
		];
		this.addPerkGroup(cultistGroup);
		// ::LA.addPerk(this.getContainer().getActor(), ::Const.Perks.PerkDefs.LegendTrueBeliever, 1);
	}
});

// ::mods_hookExactClass("entity/tactical/actor", function (o)
// {
//     local addDefaultStatusSprites = o.addDefaultStatusSprites;
// 	o.addDefaultStatusSprites = function()
// 	{
// 		addDefaultStatusSprites();
// 		local compassion = this.addSprite("status_compassion");
// 		compassion.Visible = false;
// 	}
// });

// ::mods_hookExactClass("ai/tactical/behaviors/ai_engage_ranged", function (o)
// {
//     o.m.PossibleSkills = [
// 		"actives.eldritch_blast",
// 		"actives.quick_shot",
// 		"actives.aimed_shot",
// 		"actives.shoot_bolt",
// 		"actives.shoot_stake",
// 		"actives.sling_stone",
// 		"actives.fire_handgonne",
// 		"actives.miasma",
// 		"actives.horror",
// 		"actives.root",
// 		"actives.insects",
// 		"actives.charm",
// 		"actives.raise_undead"
// 	]
// });