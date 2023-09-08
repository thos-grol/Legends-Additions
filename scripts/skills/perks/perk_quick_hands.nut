::Const.Strings.PerkName.QuickHands = "Quick Hands";
::Const.Strings.PerkDescription.QuickHands = "Slower is dead..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n• Once per turn, swapping any item costs no Action Points (besides shields)";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.QuickHands].Name = ::Const.Strings.PerkName.QuickHands;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.QuickHands].Tooltip = ::Const.Strings.PerkDescription.QuickHands;

this.perk_quick_hands <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.quick_hands";
		this.m.Name = this.Const.Strings.PerkName.QuickHands;
		this.m.Description = "Maybe use this instead? This character has quick hands and can still swap an item for free this turn.";
		this.m.Icon = "ui/perks/perk_39.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk | this.Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().isPlayerControlled() && this.getContainer().getActor().isPlacedOnMap() && this.getContainer().getActor().getItems().m.ActionCost == 0)
		{
			this.m.IsHidden = false;
		}
		else
		{
			this.m.IsHidden = true;
		}
	}

	function getName()
	{
		local name = this.skill.getName();

		if (this.getContainer() != null && this.getContainer().hasSkill("injury.missing_hand"))
		{
			name = ::MSU.String.replace(name, "Quick Hands", "Quick Hand");
		}

		return name;
	}

	function getDescription()
	{
		local description = this.skill.getDescription();

		if (this.getContainer() != null && this.getContainer().hasSkill("injury.missing_hand"))
		{
			description = ::MSU.String.replace(description, "has quick hands", "has a quick hand");
		}

		return description;
	}

	function onCombatStarted()
	{
		this.skill.onCombatStarted();

		if (this.getContainer().getActor().isPlayerControlled())
		{
			this.m.IsHidden = false;
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsHidden = true;
	}

});

