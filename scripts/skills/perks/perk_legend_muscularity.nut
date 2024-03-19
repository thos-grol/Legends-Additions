::Const.Strings.PerkName.LegendMuscularity = "Muscularity";
::Const.Strings.PerkDescription.LegendMuscularity = ::MSU.Text.color(::Z.Color.Purple, "Destiny")
+ "\n"+"Extreme Strength..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("+25%") + " Strength"
+ "\n"+::MSU.Text.colorGreen("– 50%") + " Endurance and Agility penalty from armor";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMuscularity].Name = ::Const.Strings.PerkName.LegendMuscularity;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMuscularity].Tooltip = ::Const.Strings.PerkDescription.LegendMuscularity;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMuscularity].Icon = "ui/perks/muscularity.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMuscularity].IconDisabled = "ui/perks/muscularity_bw.png";

this.perk_legend_muscularity <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_muscularity";
		this.m.Name = ::Const.Strings.PerkName.LegendMuscularity;
		this.m.Description = ::Const.Strings.PerkDescription.LegendMuscularity;
		this.m.Icon = "ui/perks/muscularity_circle.png";
		this.m.IconDisabled = "ui/perks/muscularity_circle_bw.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Destiny", true);
	}

	function onUpdate( _properties )
	{
		_properties.RangedSkillMult *= 1.25;
	}

});

