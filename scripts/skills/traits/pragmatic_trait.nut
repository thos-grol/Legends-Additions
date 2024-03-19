this.pragmatic_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.pragmatic";
		this.m.Name = "Pragmatic";
		this.m.Icon = "ui/traits/pragmatic_trait.png";
		this.m.Description = "Concerned more with matters of fact than with what could or should be.";
		this.m.Excluded = [
			"trait.brute",
			"trait.pessimist",
			"trait.irrational",
			"trait.dastard",
			"trait.fainthearted",
			"trait.paranoid",
			"trait.insecure",
			"trait.superstitious",
			"trait.cocky",
			"trait.lucky",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.aggressive"
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
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Attack"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-20%[/color] Chance To Hit Head"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.HitChance[::Const.BodyPart.Head] -= 20;
		_properties.MeleeSkill += 10;
	}

});

