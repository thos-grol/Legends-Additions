this.bloodthirsty_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.bloodthirsty";
		this.m.Name = "Bloodthirsty";
		this.m.Icon = "ui/traits/trait_icon_42.png";
		this.m.Description = "This character is prone to excessive violence and cruelty towards enemies. An opponent isn\'t good enough dead, their head needs to be on a spike!";
		this.m.Titles = [
			"the Butcher",
			"the Mad",
			"the Cruel"
		];
		this.m.Excluded = [
			"trait.weasel",
			"trait.fainthearted",
			"trait.hesistant",
			"trait.craven",
			"trait.insecure",
			"trait.craven",
			"trait.paranoid",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.teamplayer"
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
				icon = "ui/icons/special.png",
				text = ::MSU.Text.colorGreen("+50%") + " Fatality chance."
			}
		];
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.FatalityChanceMult *= 1.50;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Vicious", true);
	}

});

