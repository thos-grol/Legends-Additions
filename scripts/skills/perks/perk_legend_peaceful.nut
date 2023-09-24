::Const.Strings.PerkName.LegendPeaceful = "Clarity";
::Const.Strings.PerkDescription.LegendPeaceful = "Take a glimpse of the landscape and draw it from memory..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("+10") + " Melee or Ranged skill, whichever is highest at base"
+ "\n"+::MSU.Text.colorGreen("+1") + " Vision"
+ "\n"+::MSU.Text.colorGreen("+5") + " Melee Defense"
+ "\n"+::MSU.Text.colorGreen("+5") + " Ranged Defense";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendPeaceful].Name = ::Const.Strings.PerkName.LegendPeaceful;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendPeaceful].Tooltip = ::Const.Strings.PerkDescription.LegendPeaceful;

this.perk_legend_peaceful <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_peaceful";
		this.m.Name = ::Const.Strings.PerkName.LegendPeaceful;
		this.m.Description = ::Const.Strings.PerkDescription.LegendPeaceful;
		this.m.Icon = "ui/perks/peaceful_circle.png";
		this.m.IconDisabled = "ui/perks/peaceful_circle_bw.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.getBaseProperties().MeleeSkill > actor.getBaseProperties().RangedSkill)
			_properties.MeleeSkill += 10;
		else
			_properties.RangedSkill += 10;

		_properties.Vision += 1;
		_properties.MeleeDefense += 5;
		_properties.RangedDefense += 5;
	}

});

