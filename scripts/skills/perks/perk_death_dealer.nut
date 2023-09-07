this.perk_death_dealer <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.death_dealer";
		this.m.Name = ::Const.Strings.PerkName.DeathDealer;
		this.m.Description = ::Const.Strings.PerkDescription.DeathDealer;
		this.m.Icon = "ui/perks/death_dealer.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _skill.isAOE() && !_skill.isRanged())
		{
			_properties.DamageTotalMult *= 1.1;
		}
	}

	function onAfterUpdate( _properties )
	{
		foreach( skill in this.getContainer().getSkillsByFunction(function ( _skill )
		{
			return _skill.isAttack() && _skill.isAOE() && !_skill.isRanged();
		}.bindenv(this)) )
		{
			skill.m.FatigueCostMult *= 0.75;
		}
	}
});
