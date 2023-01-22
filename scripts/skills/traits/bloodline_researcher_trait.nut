this.bloodline_researcher_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.bloodline_researcher";
		this.m.Name = "Bloodline Researcher";
		this.m.Icon = "ui/traits/trait_icon_84.png";
		this.m.Description = "This character has the knowledge and skills to brew sequence potions from monster remains.";
		this.m.Order = this.Const.SkillOrder.Background + 10;
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
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Whenever a monster is killed in battle, adds a chance based on monster type to brew a sequence potion."
			}
		];
	}

});

