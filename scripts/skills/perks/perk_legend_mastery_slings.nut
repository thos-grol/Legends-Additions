this.perk_legend_mastery_slings <- this.inherit("scripts/skills/skill", { //FEATURE_0: sling proficiency
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_mastery_slings";
		this.m.Name = this.Const.Strings.PerkName.LegendMasterySlings;
		this.m.Description = this.Const.Strings.PerkDescription.LegendMasterySlings;
		this.m.Icon = "ui/perks/sling_03.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.Vision += 1;
		_properties.IsSpecializedInSlings = true;
	}

});

