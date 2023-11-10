//TODO: PERK winter mage
::Const.Strings.PerkName.DirewolfRuinAura <- "Ruin Knight";
::Const.Strings.PerkDescription.DirewolfRuinAura <- ::MSU.Text.color(::Z.Log.Color.Purple, "Class")
+ "\nBring tragedy and ruin to those around you... The remnant power of the God of Ruin"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\nF Class Vitality: " + ::MSU.Text.colorGreen("+50") + " Hitpoints"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Turn start, 20% chance:")
+ "\n• Inflict an injury on all units within 2 tiles";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.DirewolfRuinAura].Name = ::Const.Strings.PerkName.DirewolfRuinAura;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.DirewolfRuinAura].Tooltip = ::Const.Strings.PerkDescription.DirewolfRuinAura;

this.perk_class_winter_mage <- this.inherit("scripts/skills/skill", {
	m = {
	},
	function create()
	{
		this.m.ID = "perk.direwolf_ruin_aura";
		this.m.Name = ::Const.Strings.PerkName.DirewolfRuinAura;
		this.m.Description = ::Const.Strings.PerkDescription.DirewolfRuinAura;
		this.m.Icon = "ui/perks/perk_29.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints -= 25;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Only receive [color=" + ::Const.UI.Color.PositiveValue + "] 0%[/color] of any damage to hitpoints for " + this.m.Charges + " attacks. Bone plating takes precedence over this effect."
		});

		return tooltip;
	}

});