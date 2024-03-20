::Const.Strings.PerkName.LoneWolf = "Mind Over Body";
::Const.Strings.PerkDescription.LoneWolf = "\n" + "The spirit is willing, but the flesh is weak..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("– x%") + " Skill Fatigue costs for each point of Will over 50 (40% at 100 Will)"
+ "\n" + ::MSU.Text.colorGreen("+Morale unnaffected by Hitpoint loss");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LoneWolf].Name = ::Const.Strings.PerkName.LoneWolf;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LoneWolf].Tooltip = ::Const.Strings.PerkDescription.LoneWolf;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LoneWolf].Icon = "ui/perks/mind_over_body.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LoneWolf].IconDisabled = "ui/perks/mind_over_body_bw.png";

this.perk_lone_wolf <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.lone_wolf";
		this.m.Name = ::Const.Strings.PerkName.LoneWolf;
		this.m.Description = ::Const.Strings.PerkDescription.LoneWolf;
		this.m.Icon = "ui/perks/mind_over_body.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getBonus()
	{
		if (this.getContainer() == null) return 0;

		local actor = this.getContainer().getActor();
		if (actor == null) return 0;
		if (actor.getCurrentProperties().getBravery() <= 50) return 0;
		return actor.getCurrentProperties().getBravery() / 40.0;
	}

	function getTooltip()
	{
		local bonus = this.getBonus();
		local tooltip = this.skill.getTooltip();

		if (bonus > 0)
		{
			local reduction = ::Math.round((1 - 1 / ::Math.pow(bonus, 0.5)) * 100);
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
		if (bonus > 0)
			_properties.FatigueEffectMult *= 1.0 / ::Math.pow(bonus, 0.5);

		_properties.IsAffectedByLosingHitpoints = false;
	}

});

