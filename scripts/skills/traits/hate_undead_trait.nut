this.hate_undead_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.hate_undead";
		this.m.Name = "Hate for Undead";
		this.m.Icon = "ui/traits/trait_icon_50.png";
		this.m.Description = "Some past event in this character\'s life has fueled a burning hatred for all things that refuse to stay six feet underground.";
		this.m.Excluded = [
			"trait.weasel",
			"trait.craven",
			"trait.dastard",
			"trait.fainthearted",
			"trait.fear_undead",
			"trait.legend_peaceful"
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
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Will when in battle with undead"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Attack when in battle with undead"
			},

		];
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			this.m.Type = ::Const.SkillType.Trait;
			return;
		}

		local fightingUndead = false;
		local enemies = this.Tactical.Entities.getAllHostilesAsArray();

		foreach( enemy in enemies )
		{
			if (this.Const.EntityType.getDefaultFaction(enemy.getType()) == this.Const.FactionType.Zombies || this.Const.EntityType.getDefaultFaction(enemy.getType()) == this.Const.FactionType.Undead)
			{
				fightingUndead = true;
				break;
			}
		}

		if (fightingUndead)
		{
			_properties.Bravery += 10;
			_properties.MeleeSkillMult *= 1.05;
			this.m.Type = ::Const.SkillType.StatusEffect;
		}
		else
		{
			this.m.Type = ::Const.SkillType.Trait;
		}
	}

});

