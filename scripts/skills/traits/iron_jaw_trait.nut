this.iron_jaw_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.iron_jaw";
		this.m.Name = "Iron Jaw";
		this.m.Icon = "ui/traits/trait_icon_44.png";
		this.m.Description = "This character shakes off hits that would cripple a lesser man.";
		this.m.Titles = [
			"Ironjaw",
			"the Rock",
			"the Stallion"
		];
		this.m.Excluded = [
			"trait.fragile",
			"trait.fainthearted",
			"trait.bleeder",
			"trait.tiny",
			"trait.ailing"
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
				icon = "ui/icons/special.png",
				text = "The threshold to sustain injuries on getting hit is increased by [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color]"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.ThresholdToReceiveInjuryMult *= 1.25;
	}

});

