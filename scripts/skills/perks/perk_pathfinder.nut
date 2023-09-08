::Const.Strings.PerkDescription.Pathfinder = "Navigating all sorts of difficult terrain..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n• Movement AP cost is reduced by " + ::MSU.Text.colorGreen("1") + " to a minimum of 2 per tile, and Fatigue cost is reduced to half."
+ "\n• Unlocks the Sprint skill (5 AP, 25 FAT) which allows you to move 4 tiles in a straight line. Does not work across rough terrain or through enemy zones of control."
+ "\n• Unlocks the Climb skill (3 AP, 20 FAT) which allows you to move up or down levels. Does not trigger attacks of opportunity.";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Pathfinder].Tooltip = ::Const.Strings.PerkDescription.Pathfinder;

this.perk_pathfinder <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.pathfinder";
		this.m.Name = this.Const.Strings.PerkName.Pathfinder;
		this.m.Description = this.Const.Strings.PerkDescription.Pathfinder;
		this.m.Icon = "ui/perks/perk_23.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.PathfinderMovementAPCost;
		actor.m.FatigueCosts = clone this.Const.PathfinderMovementFatigueCost;
		actor.m.LevelActionPointCost = 0;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.sprint"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/sprint_skill_5"));
		}

		if (!this.m.Container.hasSkill("actives.legend_climb"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_climb"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.sprint");
		this.m.Container.removeByID("actives.legend_climb");
	}

});

