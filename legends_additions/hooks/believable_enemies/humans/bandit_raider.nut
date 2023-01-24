//Bandit Raider
//Level 7 Raider template
::mods_hookExactClass("entity/tactical/enemies/bandit_raider", function(o) {
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		assignRandomEquipment();
		this.m.Skills.removeByType(::Const.SkillType.Perk);

		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_str_cover_ally"));

		local offhandItem = this.getOffhandItem();
		if (offhandItem != null && offhandItem.isItemType(::Const.Items.ItemType.Shield))
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		}
		else
		{
			this.m.Skills.add(::new("scripts/skills/effects/dodge_effect"));
			local mainhandItem = this.getMainhandItem();
			if (mainhandItem != null && mainhandItem.isItemType(::Const.Items.ItemType.OneHanded))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
			}
		}

		this.m.Skills.addTreeOfEquippedWeapon(4);

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary)
		{
			this.m.Skills.add(::new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_close_combat_archer"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bloody_harvest"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_str_phalanx"));
			this.m.Skills.addTreeOfEquippedWeapon(5);

			local offhandItem = this.getOffhandItem();
			if (offhandItem != null && offhandItem.isItemType(::Const.Items.ItemType.Shield))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_str_phalanx"));
			}
			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_survival_instinct"));
			}
		}
	}
});
