::Const.Strings.PerkName.LegendSpecFists = "CQC";
::Const.Strings.PerkDescription.LegendSpecFists = "Fighting with arms and legs. The basics..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]On attack:[/u]")
+ "\nStrike with fists for each empty hand"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]\'Kick\'[/u] (4 AP, 14 Fat):")
+ "\n• Kick the enemy, canceling Shieldwall, Spearwall, Return Favor, or Riposte"
+ "\n• Has a chance to inflict Daze (" + ::MSU.Text.colorGreen("– 25%") + " dmg, " + ::MSU.Text.colorGreen("– 25%") + " Max Fat, " + ::MSU.Text.colorGreen("– 25%") + " Initiative)";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecFists].Name = ::Const.Strings.PerkName.LegendSpecFists;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecFists].Tooltip = ::Const.Strings.PerkDescription.LegendSpecFists;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecFists].Icon = "ui/perks/ambidexterity_circle.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecFists].IconDisabled = "ui/perks/ambidexterity_circle_bw.png";

this.perk_mastery_fist <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery_fist";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecFists;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecFists;
		this.m.Icon = "ui/perks/unarmed_mastery_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInFists = true;
	}

});

