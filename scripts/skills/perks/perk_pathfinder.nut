::Const.Strings.PerkDescription.Pathfinder = "Navigating all sorts of difficult terrain..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("– 1") + " movement AP cost (minimum of 2 per tile)"
+ "\n"+::MSU.Text.colorGreen("– 50%") + " movement Fatigue cost"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "\'Sprint\' (5 AP, 25 Fat):")
+ "\nSprint 4 tiles in a straight line"
+ "\n"+::MSU.Text.colorRed("Does not work across rough terrain or through enemy zones of control")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "\'Climb\' (3 AP, 20 Fat):")
+ "\nClimb up or down levels. Does not trigger attacks of opportunity";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Pathfinder].Tooltip = ::Const.Strings.PerkDescription.Pathfinder;

this.perk_pathfinder <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.pathfinder";
		this.m.Name = ::Const.Strings.PerkName.Pathfinder;
		this.m.Description = ::Const.Strings.PerkDescription.Pathfinder;
		this.m.Icon = "ui/perks/perk_23.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = ::Const.PathfinderMovementAPCost;
		actor.m.FatigueCosts = clone ::Const.PathfinderMovementFatigueCost;
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

