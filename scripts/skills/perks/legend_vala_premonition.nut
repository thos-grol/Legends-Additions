::Const.Strings.PerkName.LegendValaPremonition <- "Premonition";
::Const.Strings.PerkDescription.LegendValaPremonition <- ::MSU.Text.color(::Z.Color.Purple, "Class")
+ "\nGlimpse the future... But can you change fate mortal?"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("+X%") + " chance to reroll an incoming hit"
+ "\n" + ::MSU.Text.colorRed("X is 6 * Level");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendValaPremonition].Name = ::Const.Strings.PerkName.LegendValaPremonition;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendValaPremonition].Tooltip = ::Const.Strings.PerkDescription.LegendValaPremonition;

this.legend_vala_premonition <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_vala_premonition";
		this.m.Name = "Premonition";
		this.m.Description = "";
		this.m.Icon = "ui/perks/legend_vala_premonition.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast + 9;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return false;
	}

	function getBonus()
	{
		return this.getContainer().getActor().getLevel() * 6;

	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + getBonus() + "%[/color] chance to have any attacker require two successful attack rolls in order to hit."
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.RerollDefenseChance += getBonus();
	}

});

