::mods_hookExactClass("skills/backgrounds/legend_beggar_commander_op_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
			[
				::Const.Perks.BeastsTree,
				::Const.Perks.MysticTree,
				::Const.Perks.UndeadTree,
				::Const.Perks.CivilizationTree,
				::Const.Perks.OutlandersTree,
				::Const.Perks.OrcsTree
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.NineLives,
				::Const.Perks.PerkDefs.FastAdaption,
				::Const.Perks.PerkDefs.BagsAndBelts,
				::Const.Perks.PerkDefs.Recover
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRSurvivalInstinct,
				::Const.Perks.PerkDefs.Backstabber
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.HoldOut,
				::Const.Perks.PerkDefs.FortifiedMind,
				::Const.Perks.PerkDefs.Taunt,
				::Const.Perks.PerkDefs.Rotation
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Sprint,
				::Const.Perks.PerkDefs.RallyTheTroops

			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRDynamicDuo,
				::Const.Perks.PerkDefs.Debilitate,
				::Const.Perks.PerkDefs.Steadfast
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendMindOverBody,
				::Const.Perks.PerkDefs.PTRTheRushOfBattle,
				::Const.Perks.PerkDefs.InspiringPresence
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendFavouredEnemyArcher,
				::Const.Perks.PerkDefs.LegendFavouredEnemySwordmaster,
				::Const.Perks.PerkDefs.LastStand,
				::Const.Perks.PerkDefs.Indomitable,
				::Const.Perks.PerkDefs.PerfectFocus
			]
		);
	}

	o.onTargetKilled = function( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();

		if (actor.isAlliedWith(_targetEntity))
		{
			return;
		}

		actor.getBaseProperties().Hitpoints += (actor.getBaseProperties().Hitpoints < _targetEntity.getBaseProperties().Hitpoints ? 1 : 0);
		actor.getBaseProperties().Bravery += (actor.getBaseProperties().Bravery < _targetEntity.getBaseProperties().Bravery ? 1 : 0);
		actor.getBaseProperties().Stamina += (actor.getBaseProperties().Stamina < _targetEntity.getBaseProperties().Stamina ? 1 : 0);
		actor.getBaseProperties().MeleeSkill += (actor.getBaseProperties().MeleeSkill < _targetEntity.getBaseProperties().MeleeSkill ? 1 : 0);
		actor.getBaseProperties().RangedSkill += (actor.getBaseProperties().RangedSkill < _targetEntity.getBaseProperties().RangedSkill ? 1 : 0);
		actor.getBaseProperties().MeleeDefense += (actor.getBaseProperties().MeleeDefense < _targetEntity.getBaseProperties().MeleeDefense ? 1 : 0);
		actor.getBaseProperties().RangedDefense += (actor.getBaseProperties().RangedDefense < _targetEntity.getBaseProperties().RangedDefense ? 1 : 0);
		actor.getBaseProperties().Initiative += (actor.getBaseProperties().Initiative < _targetEntity.getBaseProperties().Initiative ? 1 : 0);

		local target_skills = _targetEntity.getSkills().getSkillsByFunction(@(skill) skill.isType(::Const.SkillType.Perk));
		local potentialPerks = [];

		foreach (perk in target_skills)
		{
			local id = perk.getID();
			if (id == "perk.stalwart" || id == "perk.legend_composure" || id == "perk.battering_ram")
			{
				continue;
			}

			if (!actor.getSkills().hasSkill(id))
			{
				potentialPerks.push(perk);
			}
		}

		if (potentialPerks.len() == 0)
		{
			return;
		}

		local perk = potentialPerks[this.Math.rand(0, potentialPerks.len() - 1)];

		foreach( i, v in ::Const.Perks.PerkDefObjects )
		{
			if (perk.getID() == v.ID)
			{
				if (v.Script != "")
				{
					this.Tactical.EventLog.log("The framed beggar learned [color=" + ::Const.UI.Color.NegativeValue + "]" + perk.getName() + "[/color] from " + _targetEntity.getName());
					actor.getSkills().add(this.new(v.Script));
					local rowToAddPerk = 0;
					local length = actor.getBackground().getPerkTree()[0].len();
					foreach (i, row in actor.getBackground().getPerkTree())
					{
						if (row.len() < length) rowToAddPerk = i;
					}
					actor.getBackground().addPerk(i, rowToAddPerk);
					break;
				}
			}
		}
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
