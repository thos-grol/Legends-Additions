this.tiny_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.tiny";
		this.m.Name = "Tiny";
		this.m.Icon = "ui/traits/trait_icon_02.png";
		this.m.Description = "Being very short of height, this character is used to slipping through.";
		this.m.Titles = [
			"the Dwarf",
			"the Halfman",
			"the Short"
		];
		this.m.Excluded = [
			"trait.huge",
			"trait.strong",
			"trait.tough",
			"trait.brute",
			"trait.iron_jaw",
			"trait.heavy"
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+5[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+5[/color] Ranged Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-15%[/color] Melee Damage"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDamageMult *= 0.85;
		_properties.MeleeDefense += 5;
		_properties.RangedDefense += 5;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Tiny", true);
	}

});

