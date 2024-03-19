this.superstitious_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.superstitious";
		this.m.Name = "Superstitious";
		this.m.Icon = "ui/traits/trait_icon_26.png";
		this.m.Description = "It\'s cursed! This character is highly superstitious and therefore more vulnerable to skills that directly attack his Will.";
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave"
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Will at morale checks against fear, panic or mind control effects"
			}
		];
	}

});

