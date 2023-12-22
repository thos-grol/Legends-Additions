::Const.Strings.PerkDescription.LegendRecuperation = "Recover health and fatigue..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("+2") + " Hitpoint recovery"
+ "\n" + ::MSU.Text.colorGreen("+2") + " Fatigue recovery"
+ "\n" + ::MSU.Text.colorGreen("+25%") + "Hitpoint recovery on world map"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "\'Recover\' (X AP):")
+ "\n" + ::MSU.Text.colorGreen("– 5.5% * X") + " Fatigue accumulated"
+ "\n"+::MSU.Text.colorRed("Cannot be used if another skill has been used");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendRecuperation].Tooltip = ::Const.Strings.PerkDescription.LegendRecuperation;


this.perk_legend_recuperation <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_recuperation";
		this.m.Name = ::Const.Strings.PerkName.LegendRecuperation;
		this.m.Description = ::Const.Strings.PerkDescription.LegendRecuperation;
		this.m.Icon = "ui/perks/recuperation_circle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		actor.setHitpoints(::Math.min(actor.getHitpointsMax(), actor.getHitpoints() + 2));
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRate += 2;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.recover"))
			this.m.Container.add(::new("scripts/skills/actives/recover_skill"));

		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled()) return;
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.Recover) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_recover"));
			agent.finalizeBehaviors();
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.recover");
	}

	

});

