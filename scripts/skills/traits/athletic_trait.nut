this.athletic_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.athletic";
		this.m.Name = "Athletic";
		this.m.Icon = "ui/traits/trait_icon_21.png";
		this.m.Description = "This character is physically fit.";
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.asthmatic",
			"trait.clubfooted",
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] Endurance"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Builds up [color=" + ::Const.UI.Color.PositiveValue + "]2[/color] less Fatigue for each tile travelled"
			},
		];
	}

	function onUpdate( _properties )
	{
		_properties.MovementFatigueCostAdditional -= 2;
		_properties.Stamina += 20;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Fit", true);
	}

});

