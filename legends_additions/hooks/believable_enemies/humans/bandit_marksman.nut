::mods_hookExactClass("entity/tactical/enemies/bandit_marksman", function(o) {
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		assignRandomEquipment();
		this.m.Skills.removeByID("perk.close_combat_archer");

		this.m.Skills.addTreeOfEquippedWeapon(4);

		if (this.Math.rand(1,100) <= 25)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_flaming_arrows"));
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_onslaught"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
			if (::Math.rand(1, 100) <= 50) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_eyes_up"));
		}
	}
});
