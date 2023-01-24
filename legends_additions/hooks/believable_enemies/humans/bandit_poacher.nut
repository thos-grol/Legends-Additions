::mods_hookExactClass("entity/tactical/enemies/bandit_poacher", function(o) {
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		assignRandomEquipment();
		this.m.Skills.removeByType(::Const.SkillType.Perk);
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_entrenched"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_target_practice"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_onslaught"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(::new("scripts/skills/traits/fearless_trait"));

			local weapon = this.getMainhandItem();
			if (weapon != null)
			{
				if (weapon.isWeaponType(::Const.Items.WeaponType.Sling))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_sling_skill"));
				}
				else
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_ballistics"));
				}
			}

		}
	}
});
