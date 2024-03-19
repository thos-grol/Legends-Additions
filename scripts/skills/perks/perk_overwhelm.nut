::Const.Strings.PerkName.Overwhelm = "Tempest";
::Const.Strings.PerkDescription.Overwhelm = ::MSU.Text.color(::Z.Color.Purple, "Destiny")
+ "\nBecome a tempest of destruction on the battlefield"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "On enemy attack:")
+ "\nIf this character is under 50% Fatigued and their Agility is higher than the enemy, do a melee attack"
+ "\n" + ::MSU.Text.colorRed("Does not work with weapons over X weight. X is 25% of Strength")

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "On attack:")
+ "\nInflict 1 stack of " + ::MSU.Text.colorRed("Overwhelm") + ": " + ::MSU.Text.colorGreen("– 10%") + " melee and ranged attack per stack for a turn).";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Overwhelm].Name = ::Const.Strings.PerkName.Overwhelm;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Overwhelm].Tooltip = ::Const.Strings.PerkDescription.Overwhelm;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Overwhelm].Icon = "ui/perks/overwhelm.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Overwhelm].IconDisabled = "ui/perks/overwhelm_bw.png";

this.perk_overwhelm <- this.inherit("scripts/skills/skill", {
	m = {
		SkillCount = 0,
		LastTargetID = 0
	},
	function create()
	{
		this.m.ID = "perk.overwhelm";
		this.m.Name = ::Const.Strings.PerkName.Overwhelm;
		this.m.Description = ::Const.Strings.PerkDescription.Overwhelm;
		this.m.Icon = "ui/perks/perk_62.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function can_be_used(_target)
	{
		if (_target == null) return false;
		local actor = this.getContainer().getActor();
		if (actor.getInitiative() <= _target.getInitiative()) return false;
		if (actor.getFatigue() >= 0.5 * actor.getFatigueMax()) return false;

		local weapon = actor.getMainhandItem();
		if (weapon == null || weapon.m.StaminaModifier * -1.0 > actor.m.CurrentProperties.getRangedSkill() * 0.25) return false;

		return true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();

		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getContainer().getActor().getID()) return;

		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(this.getContainer().getActor())) return;

		if (!_targetEntity.isTurnStarted() && !_targetEntity.isTurnDone())
		{
			if (this.m.SkillCount == ::Const.SkillCounter && this.m.LastTargetID == _targetEntity.getID())
			{
				return;
			}

			this.m.SkillCount = ::Const.SkillCounter;
			this.m.LastTargetID = _targetEntity.getID();
			if (!_targetEntity.getFlags().has("immunity_overwhelm"))
				_targetEntity.getSkills().add(::new("scripts/skills/effects/overwhelmed_effect"));
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getContainer().getActor().getID())
		{
			return;
		}

		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			return;
		}

		if (!_targetEntity.isTurnStarted() && !_targetEntity.isTurnDone())
		{
			if (this.m.SkillCount == ::Const.SkillCounter && this.m.LastTargetID == _targetEntity.getID())
			{
				return;
			}

			this.m.SkillCount = ::Const.SkillCounter;
			this.m.LastTargetID = _targetEntity.getID();
			this.m.SkillCount = ::Const.SkillCounter;
			if (!_targetEntity.getFlags().has("immunity_overwhelm"))
				_targetEntity.getSkills().add(::new("scripts/skills/effects/overwhelmed_effect"));
		}
	}

	function onCombatStarted()
	{
		this.m.SkillCount = 0;
		this.m.LastTargetID = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.SkillCount = 0;
		this.m.LastTargetID = 0;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Destiny", true);
	}

	
});

