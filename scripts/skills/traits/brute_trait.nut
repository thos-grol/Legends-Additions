this.brute_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.brute";
		this.m.Name = "Brute";
		this.m.Icon = "ui/traits/trait_icon_01.png";
		this.m.Description = "Not one for delicate attacks, this character will use full force for additional damage when striking an opponent\'s head in melee at the expense of some accuracy.";
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
				id = 10,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Damage on a hit to the head"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Melee Skill"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += -5;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && !_skill.isRanged())
		{
			_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.15;
		}
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Vicious", true);
	}

});

