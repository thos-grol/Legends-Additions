this.irrational_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.irrational";
		this.m.Name = "Irrational";
		this.m.Icon = "ui/traits/trait_icon_28.png";
		this.m.Description = "The glass is half empty now but was half full just a moment ago.";
		this.m.Excluded = [
			"trait.pessimist",
			"trait.optimist",
			"trait.insecure"
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
				icon = "ui/icons/bravery.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] or [color=" + this.Const.UI.Color.NegativeValue + "]-20[/color] Will at every morale or skill check"
			}
		];
	}

});

