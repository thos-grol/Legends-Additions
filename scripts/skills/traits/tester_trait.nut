this.tester_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.tester";
		this.m.Name = "Tester";
		this.m.Icon = "ui/traits/trait_icon_63.png";
		this.m.Description = "Increases attributes for testing.";
		this.m.Order = ::Const.SkillOrder.Background + 10;
		this.m.Type = this.m.Type;
		this.m.Titles = [];
		this.m.Excluded = [];
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
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Vision += 1;
		_properties.Hitpoints += 200;
		_properties.Stamina += 200;
		_properties.Initiative += 200;
		_properties.MeleeSkill += 200;
		_properties.RangedSkill += 200;
		_properties.RangedDefense += 200;
		_properties.MeleeDefense += 200;
		_properties.FatigueRecoveryRate += 3;
		_properties.MovementFatigueCostAdditional -= 2;
		_properties.ThresholdToReceiveInjuryMult *= 1.25;
		_properties.RerollDefenseChance += 10;
	}

});

