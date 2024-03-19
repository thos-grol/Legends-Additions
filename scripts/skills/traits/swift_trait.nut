this.swift_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.swift";
		this.m.Name = "Swift";
		this.m.Icon = "ui/traits/trait_icon_53.png";
		this.m.Description = "This character has impressive reactions...";
		this.m.Titles = [
			"the Swift",
			"Quickfeet"
		];
		this.m.Excluded = [
			"trait.clumsy",
			"trait.fat",
			"trait.clubfooted",
			"trait.predictable",
			"trait.asthmatic"
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
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Reflex"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.RangedDefense += 10;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Calm", true);
	}

});

