this.perfect_body_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.perfect_body";
		this.m.Name = "Perfect Body";
		this.m.Icon = "ui/traits/trait_icon_21.png";
		this.m.Description = "This character's body has been perfected with the lindwurm potion. All imperfections of the flesh have been removed.";
		this.m.Order = this.Const.SkillOrder.Trait - 10;
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
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+1[/color] Vision"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Max Fatigue"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Initiative"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The threshold to sustain injuries on getting hit is increased by [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color]"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] Fatigue Recovery per turn"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Builds up [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] less fatigue for each tile travelled"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] chance to have any attacker require two successful attack rolls in order to hit"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Vision += 1;
		_properties.Hitpoints += 10;
		_properties.Stamina += 10;
		_properties.Initiative += 10;
		_properties.MeleeSkill += 5;
		_properties.FatigueRecoveryRate += 3;
		_properties.MovementFatigueCostAdditional -= 2;
		_properties.ThresholdToReceiveInjuryMult *= 1.25;
		_properties.RerollDefenseChance += 10;
	}

	function onAdded()
	{
		local _actor = this.getContainer().getActor();
		_actor.getSkills().removeByID("trait.short_sighted");
		_actor.getSkills().removeByID("trait.bleeder");
		_actor.getSkills().removeByID("trait.ailing");
		_actor.getSkills().removeByID("trait.fragile");
		_actor.getSkills().removeByID("trait.asthmatic");
		_actor.getSkills().removeByID("trait.clubfooted");
		_actor.getSkills().removeByID("trait.night_blind");
		_actor.getSkills().removeByID("trait.frail");
	}
});

