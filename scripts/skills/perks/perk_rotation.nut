::Const.Strings.PerkName.Rotation = "Footwork";
::Const.Strings.PerkDescription.Rotation = "On my mark!"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "\'Rotation\' (3 AP, 25 Fat):")
+ "\nSwitch places with an allied unit"
+ "\n"+::MSU.Text.colorRed("Invalid if either character is stunned, rooted or otherwise disabled")

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "\'Footwork\' (3 AP, 20 Fat):")
+ "\nLeave a zone of control without incurring any free attacks";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Rotation].Name = ::Const.Strings.PerkName.Rotation;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Rotation].Tooltip = ::Const.Strings.PerkDescription.Rotation;

//////////////////

this.perk_rotation <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rotation";
		this.m.Name = this.Const.Strings.PerkName.Rotation;
		this.m.Description = this.Const.Strings.PerkDescription.Rotation;
		this.m.Icon = "ui/perks/perk_11.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.rotation"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/rotation"));
		}

		if (!this.m.Container.hasSkill("actives.footwork"))
		{
			this.m.Container.add(::new("scripts/skills/actives/footwork"));
		}

		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled()) return;
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.Disengage) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_disengage"));
			agent.finalizeBehaviors();
		}

		if (agent.findBehavior(::Const.AI.Behavior.ID.Rotation) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_defend_rotation"));
			agent.finalizeBehaviors();
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.rotation");

		if (this.m.Container.hasSkill("perk.quickstep")) return;
		this.m.Container.removeByID("actives.footwork");
	}

});

