this.quick_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.quick";
		this.m.Name = "Quick";
		this.m.Icon = "ui/traits/trait_icon_18.png";
		this.m.Description = "Already there! This character is quick to act, often before opponents do.";
		this.m.Titles = [
			"the Quick"
		];
		this.m.Excluded = [
			"trait.huge",
			"trait.hesitant",
			"trait.clubfooted",
			"trait.slack",
			"trait.heavy",
			"trait.frail"
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
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Initiative"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Initiative += 10;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Fast", true);
	}

});

