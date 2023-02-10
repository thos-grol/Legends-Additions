//"Synapse Blockage";
//"This character\'s body has mutated in such a way that their fight-or-flight response is altered. In high stress situations, their limbic system is simply refused resources for flight, making them effectively unbreakable in the battle line.";

::mods_hookExactClass("skills/effects/ancient_priest_potion_effect", function(o) {
	o.create = function()
	{
		this.m.ID = "effects.ancient_priest_potion";
		this.m.Name = "Synapse Blockage";
		this.m.Icon = "skills/status_effect_134.png";
		this.m.IconMini = "status_effect_134_mini";
		this.m.Overlay = "status_effect_134";
        this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	o.getTooltip = function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Morale cannot be reduced below Steady"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Mutations of another sequence may cause this character's genes to spiral out of control, killing them in the process"
			}
		];
		return ret;
	}
});
