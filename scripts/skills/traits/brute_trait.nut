this.brute_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.brute";
		this.m.Name = "Brute";
		this.m.Icon = "ui/traits/trait_icon_01.png";
		this.m.Description = "Not one for delicate attacks...";
		this.m.Titles = [
			"the Bull",
			"the Ox",
			"the Hammer"
		];
		this.m.Excluded = [
			"trait.pragmatic",
			"trait.tiny",
			"trait.fragile",
			"trait.insecure",
			"trait.hesitant",
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
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-10[/color] Attack"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/strength.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+20[/color] Strength"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += -10;
		_properties.RangedSkill += 10;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Large", true);
	}

});

