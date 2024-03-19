this.bleeder_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.bleeder";
		this.m.Name = "Bleeder";
		this.m.Icon = "ui/traits/trait_icon_16.png";
		this.m.Description = "This character is prone to bleeding and will do so longer than most others.";
		this.m.Excluded = [
			"trait.tough",
			"trait.iron_jaw",
			"trait.survivor"
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
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will receive bleeding damage for [color=" + this.Const.UI.Color.NegativeValue + "]1[/color] additional turn"
			}
		];
	}

});

