this.tough_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.tough";
		this.m.Name = "Tough";
		this.m.Icon = "ui/traits/trait_icon_14.png";
		this.m.Description = "This character is tough as nails, shrugging off hits and blows.";
		this.m.Titles = [
			"the Rock",
			"the Bull",
			"the Ox",
			"the Bear"
		];
		this.m.Excluded = [
			"trait.tiny",
			"trait.fragile",
			"trait.bleeder",
			"trait.ailing",
			"trait.light",
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
				icon = "ui/icons/health.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Vitality"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += 10;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Sturdy", true);
	}

});

