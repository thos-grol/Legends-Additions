::mods_hookExactClass("entity/tactical/enemies/bandit_raider_wolf", function(o) {
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		assignRandomEquipment();
		this.m.Skills.removeByType(::Const.SkillType.Perk);

		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_str_cover_ally"));

		this.m.Skills.add(::new("scripts/skills/effects/dodge_effect"));

		this.m.Skills.addTreeOfEquippedWeapon(4);

		if (this.LegendsMod.Configs().LegendTherianthropyEnabled())
		{
			if (this.Math.rand(1, 10) == 1)
			{
				this.m.Skills.add(::new("scripts/skills/injury_permanent/legend_lycanthropy_injury"));
				this.m.Skills.add(::new("scripts/skills/traits/weasel_trait"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_legend_back_to_basics"));
			}
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary)
		{
			this.m.Skills.add(::new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_close_combat_archer"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bloody_harvest"));
			this.m.Skills.addTreeOfEquippedWeapon(5);
		}
	}
});
