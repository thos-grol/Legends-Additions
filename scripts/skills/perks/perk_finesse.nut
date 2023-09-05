this.perk_finesse <- ::inherit("scripts/skills/skill", {
	m = {
		CurrBonus = 0
	},
	function create()
	{
		this.m.ID = "perk.finesse";
		this.m.Name = ::Const.Strings.PerkName.Finesse;
		this.m.Description = ::Const.Strings.PerkDescription.Finesse;
		this.m.Icon = "ui/perks/rf_finesse.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate( _properties )
	{
		foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
		{
			skill.m.FatigueCostMult *= 0.8;
		}
	}

	function onTurnEnd()
	{
		this.m.CurrBonus = this.getContainer().getActor().getActionPoints();
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += this.m.CurrBonus * 2;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.CurrBonus = 0;
	}
});
