//TODO: rewrite using new format
::Const.Strings.PerkName.LegendTwirl <- "Footwork";
::Const.Strings.PerkDescription.LegendTwirl <- "Footwork is important... Repeat it again!"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n"+::MSU.Text.colorGreen("Rotation can now target enemies")
+ "\n"+::MSU.Text.colorGreen("Rotating an enemy has a chance to Stagger them. ") +::MSU.Text.colorRed("The higher the mdef, the lower the chance")
+ "\n"+::MSU.Text.colorGreen("+3") + " Melee Defense";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendTwirl].Name = ::Const.Strings.PerkName.LegendTwirl;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendTwirl].Tooltip = ::Const.Strings.PerkDescription.LegendTwirl;

this.perk_legend_twirl <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_twirl";
		this.m.Name = this.Const.Strings.PerkName.LegendTwirl;
		this.m.Description = this.Const.Strings.PerkDescription.LegendTwirl;
		this.m.Icon = "ui/perks/twirl_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate(_properties)
    {
        _properties.MeleeDefense += 3;
    }

});

