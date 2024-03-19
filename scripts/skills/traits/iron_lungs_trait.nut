this.iron_lungs_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.iron_lungs";
		this.m.Name = "Iron Lungs";
		this.m.Icon = "ui/traits/trait_icon_33.png";
		this.m.Description = "This character will rarely run out of breath, whether swinging a heavy weapon or running across all the battlefield.";
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.asthmatic",
			"trait.fat",
			"trait.gluttonous",
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
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Fatigue Recovery per turn"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRate += 5;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Fit", true);
	}

});

