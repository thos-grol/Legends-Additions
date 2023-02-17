this.writhing_flesh <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.writhing_flesh";
		this.m.Name = ::Const.Strings.PerkName.WrithingFlesh;
		this.m.Description = ::Const.Strings.PerkDescription.WrithingFlesh;
		this.m.Icon = "ui/perks/writhing_flesh.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.HitpointsMult *= 1.25;
		_properties.IsAffectedByFreshInjuries = false;
	}

});

