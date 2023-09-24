this.swift_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.swift";
		this.m.Name = "Swift";
		this.m.Icon = "ui/traits/trait_icon_53.png";
		this.m.Description = "This character is naturally swift and agile, and has an easier time dodging incoming projectiles.";
		this.m.Titles = [
			"the Swift",
			"Quickfeet"
		];
		this.m.Excluded = [
			"trait.clumsy",
			"trait.fat",
			"trait.clubfooted",
			"trait.predictable"
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
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+5[/color] Ranged Defense"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.RangedDefense += 5;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Fast", true);
	}

});

