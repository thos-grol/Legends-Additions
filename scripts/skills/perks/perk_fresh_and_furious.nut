::Const.Strings.PerkName.FreshAndFurious <- "Fresh";
::Const.Strings.PerkDescription.FreshAndFurious <- "This character seems to have endless energy..."
+ "\n" + ::MSU.Text.color(::Z.Log.Color.Purple, "[u]Destiny[/u]")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]On first skill use this turn:[/u]")
+ "\n"+::MSU.Text.colorGreen("-50%") + "AP cost"
+ "\n"+::MSU.Text.colorRed("Invalid if Fatigue is over 40% max")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Purple, "You may only pick 1 destiny");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.FreshAndFurious].Name = ::Const.Strings.PerkName.FreshAndFurious;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.FreshAndFurious].Tooltip = ::Const.Strings.PerkDescription.FreshAndFurious;

this.perk_fresh_and_furious <- ::inherit("scripts/skills/skill", {
	m = {
		IsUsingFreeSkill = false,
		IsSpent = true
	},
	function create()
	{
		this.m.ID = "perk.fresh_and_furious";
		this.m.Name = ::Const.Strings.PerkName.FreshAndFurious;
		this.m.Description = "This character seems to have endless energy.";
		this.m.Icon = "ui/perks/rf_fresh_and_furious.png";
		this.m.IconMini = "rf_fresh_and_furious_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.IsSpent || !this.isEnabled();
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The next skill used has its Action Point cost [color=" + ::Const.UI.Color.PositiveValue + "]halved[/color]"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "[color=" + ::Const.UI.Color.NegativeValue + "]Will expire upon using a skill with non-zero Action Point or Fatigue cost or when current Fatigue reaches 40% of Maximum Fatigue[/color]"
		});

		return tooltip;
	}

	function isEnabled()
	{
		return this.getContainer().getActor().getFatigue() < 0.4 * this.getContainer().getActor().getFatigueMax();
	}

	function onAfterUpdate( _properties )
	{
		if (!this.m.IsSpent && this.isEnabled())
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				// ::Math.round to round up the subtraction because we want to emulate the behavior of _properties.IsSkillUseHalfCost
				// whereby it rounds down the cost (due to integer division) after halving it.
				skill.m.ActionPointCost -= ::Math.max(0, ::Math.min(skill.m.ActionPointCost - 1, ::Math.round(skill.m.ActionPointCost / 2.0)));
			}
		}
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		// Sometimes you use a non-free skill which uses a free skill inside its onUse function
		// In this case, we want to ensure that if IsUsingFreeSkill is false, we don't set it to true
		if (!this.m.IsUsingFreeSkill) return;
		this.m.IsUsingFreeSkill = _forFree || (_skill.getActionPointCost() == 0 && _skill.getFatigueCost() == 0);
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.IsSpent = !this.m.IsUsingFreeSkill;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = true;
	}
});
