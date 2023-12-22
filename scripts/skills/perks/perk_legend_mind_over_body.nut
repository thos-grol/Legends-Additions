::Const.Strings.PerkName.LegendMindOverBody = "Mind Over Body";
::Const.Strings.PerkDescription.LegendMindOverBody = ::MSU.Text.color(::Z.Color.Purple, "Destiny")
+ "\n" + "The spirit is willing, but the flesh is weak..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("– x%") + " Skill Fatigue costs based on resolve"
+ "\n" + ::MSU.Text.colorRed("About 30% at 120 Resolve")
+ "\n\n" + ::MSU.Text.colorGreen("+Fresh Injury effect immunity")
+ "\n" + ::MSU.Text.colorGreen("+Morale unnaffected by Hitpoint loss");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMindOverBody].Name = ::Const.Strings.PerkName.LegendMindOverBody;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMindOverBody].Tooltip = ::Const.Strings.PerkDescription.LegendMindOverBody;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMindOverBody].Icon = "ui/perks/mind_over_body.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMindOverBody].IconDisabled = "ui/perks/mind_over_body_bw.png";

this.perk_legend_mind_over_body <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_mind_over_body";
		this.m.Name = ::Const.Strings.PerkName.LegendMindOverBody;
		this.m.Description = ::Const.Strings.PerkDescription.LegendMindOverBody;
		this.m.Icon = "ui/perks/mind_over_body.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Destiny", true);
	}

	function getBonus()
	{
		if (this.getContainer() == null)
		{
			return 0;
		}

		local actor = this.getContainer().getActor();

		if (actor == null)
		{
			return 0;
		}

		local resolve = actor.getCurrentProperties().getBravery();
		local fraction = resolve / 60.0;
		local normal = ::Math.floor(fraction * 100);
		local bonus = normal * 0.01;
		return bonus;
	}

	function getTooltip()
	{
		local bonus = this.getBonus();

		if (bonus > 1)
		{
			bonus = ::Math.pow(bonus, 0.5);
		}

		local reduction = ::Math.round((1 - 1 / bonus) * 100);
		local tooltip = this.skill.getTooltip();

		if (bonus > 1)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "All your fatigue costs are reduced by [color=" + ::Const.UI.Color.PositiveValue + "]" + reduction + "%[/color]."
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character does not have enough resolve to benefit from Mind Over Body."
			});
		}

		return tooltip;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();

		if (bonus > 1)
		{
			bonus = ::Math.pow(bonus, 0.5);
			_properties.FatigueEffectMult *= 1.0 / bonus;
		}
		_properties.IsAffectedByFreshInjuries = false;
		_properties.IsAffectedByLosingHitpoints = false;
	}

});

