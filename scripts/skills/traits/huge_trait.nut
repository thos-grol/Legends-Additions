this.huge_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.huge";
		this.m.Name = "Huge";
		this.m.Icon = "ui/traits/trait_icon_61.png";
		this.m.Description = "Being particularly huge and burly, this character\'s strikes hurt plenty, but they\'re also a bigger target than most.";
		this.m.Titles = [
			"the Mountain",
			"the Ox",
			"the Bear",
			"the Giant",
			"the Tower",
			"the Bull"
		];
		this.m.Excluded = [
			"trait.tiny",
			"trait.quick",
			"trait.fragile",
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
				id = 11,
				type = "text",
				icon = "ui/icons/strength.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+20[/color] Strength"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-10[/color] Defense"
			},
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += -10;
		_properties.RangedSkill += 20;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Large", true);
	}

});

