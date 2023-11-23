::Const.Strings.PerkName.Quickstep <- "Quickstep";
::Const.Strings.PerkDescription.Quickstep <- "Strike and move with grace..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\nGrants Footwork if the unit does not have it"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "On attack hit:")
+ "\nFootwork has a 25% chance to cost 0 AP and Fatigue"
+ "\n"+ ::MSU.Text.colorRed("Becomes 75% if the unit has the footwork perk")
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "\'Footwork\' (3 AP, 20 Fat):")
+ "\nLeave a zone of control without incurring any free attacks";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Quickstep].Name = ::Const.Strings.PerkName.Quickstep;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Quickstep].Tooltip = ::Const.Strings.PerkDescription.Quickstep;

this.perk_quickstep <- this.inherit("scripts/skills/skill", {
	m = {
		Active = false,
		Chance = 25,
		ChanceMax = 75,
		Skills = [
			"actives.footwork"
		]
	},
	function create()
	{
		this.m.ID = "perk.quickstep";
		this.m.Name = ::Const.Strings.PerkName.Quickstep;
		this.m.Description = ::Const.Strings.PerkDescription.Quickstep;
		this.m.Icon = "ui/perks/perk_25.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.footwork"))
			this.m.Container.add(::new("scripts/skills/actives/footwork"));

		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled()) return;
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.Disengage) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_disengage"));
			agent.finalizeBehaviors();
		}
	}

	function onRemoved()
	{
		if (!this.m.Container.hasSkill("perk.footwork"))
			this.m.Container.removeByID("actives.footwork");
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (::Math.rand(1,100) <= (this.m.Container.hasSkill("perk.footwork") ? this.m.ChanceMax : this.m.Chance))
		{
			this.m.Active = true;

			if (!this.getContainer().getActor().isHiddenToPlayer()) this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " can quickstep");
		}

	}

	function onCombatFinished()
	{
		this.m.Active = false;
	}

	//0 cost logic
	function onAfterUpdate(_properties)
	{
		if (!this.m.Active || !this.getContainer().getActor().isPlacedOnMap())
		{
			this.m.Active = false;
			return;
		}

		local skills = this.getContainer().getSkillsByFunction((@(_skill) this.m.Skills.find(_skill.getID()) != null).bindenv(this));
		if (skills.len() == 0) return;

		foreach (s in skills)
		{
			if (s != null)
			{
				s.m.ActionPointCost *= 0;
				s.m.FatigueCostMult *= 0;
			}
		}
	}

	function onAffordablePreview( _skill, _movementTile )
	{
		if (_skill != null)
		{
			foreach (skill in this.getContainer().getSkillsByFunction((@(_skill) this.m.Skills.find(_skill.getID()) != null).bindenv(this)))
			{
				this.modifyPreviewField(skill, "ActionPointCost", 0, false);
				this.modifyPreviewField(skill, "FatigueCostMult", 0, true);
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.Tactical.TurnSequenceBar.getActiveEntity() != null &&
			this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID()
			&& this.m.Skills.find(_skill.getID()) != null
			) this.m.Active = false;
	}

});

