this.teamwork_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.teamwork";
		this.m.Name = "Teamwork";
		this.m.Description = "You aren't supposed to see this.";
		this.m.Icon = "ui/perks/perk_01.png";
		this.m.IconMini = "perk_01_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsHidden = true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _targetEntity != null && _targetEntity.getID() != this.getContainer().getActor().getID() && _targetEntity.getFaction() == this.getContainer().getActor().getFaction())
		{
			_properties.MeleeSkillMult *= 0.25;
			_properties.RangedSkillMult *= 0.25;
		}
	}

	function onCombatFinished()
	{
		this.removeSelf();
	}

});

