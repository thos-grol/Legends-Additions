this.cultist_penance <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.penance";
		this.m.Name = ::Const.Strings.PerkName.Penance;
		this.m.Description = "Reduce the effects that permenant injuries has on this character or transform the injury in some eldritch way. This character is no longer affected by allies dying or losing hitpoints.";
		this.m.Icon = "ui/perks/penance_circle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByDyingAllies = false;
		_properties.IsAffectedByLosingHitpoints = false;
	}

});

