this.asthmatic_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.asthmatic";
		this.m.Name = "Asthmatic";
		this.m.Icon = "ui/traits/trait_icon_22.png";
		this.m.Description = "Being short of breath and prone to coughing, this character takes longer to recover from fatigue than others.";
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.athletic",
			"trait.iron_lungs",
			"trait.swift"
		];
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
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Fatigue Recovery per turn"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRate += -5;
	}

});

