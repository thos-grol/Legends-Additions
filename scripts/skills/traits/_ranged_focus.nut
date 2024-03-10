this._ranged_focus <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait._ranged_focus";
		this.m.Name = "Ranged Focus";
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Description = "For this character, ranged weapons are easier to use than melee weapons.";
		this.m.Titles = [];
		this.m.Excluded = [];
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/morale.png",
				text = ::MSU.Text.colorGreen("100%") + " of Attack is used in ranged attacks and " + ::MSU.Text.colorGreen("50%") " for melee attacks"
			}
		];
	}

	function onUpdate( _properties )
	{
	}

	function onCombatStarted()
	{
	}

	function onAdded()
	{
	}

});

