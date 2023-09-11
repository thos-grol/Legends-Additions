//TODO: rewrite using new format
::Const.Strings.PerkName.Overwhelm = "Overwhelm";
::Const.Strings.PerkDescription.Overwhelm = "Overwhelm them with a flurry of strikes. Follow up to create devestating attacks."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n• Attacks hit or miss inflict a stacking Overwhelm effect (" + ::MSU.Text.colorGreen("-10%") + " melee and ranged attack for a turn)." //TODO: overwhelm cap
+ "\n• " + ::MSU.Text.colorGreen("+20%") + " increased damage for the next attack on landing an attack.";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Overwhelm].Name = ::Const.Strings.PerkName.Overwhelm;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Overwhelm].Tooltip = ::Const.Strings.PerkDescription.Overwhelm;

this.perk_overwhelm <- this.inherit("scripts/skills/skill", {
	m = {
		SkillCount = 0,
		LastTargetID = 0
	},
	function create()
	{
		this.m.ID = "perk.overwhelm";
		this.m.Name = this.Const.Strings.PerkName.Overwhelm;
		this.m.Description = this.Const.Strings.PerkDescription.Overwhelm;
		this.m.Icon = "ui/perks/perk_62.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();

		if (!_targetEntity.isAlliedWith(actor) && !actor.getSkills().hasSkill("effect.double_strike"))
		{
			actor.getSkills().add(this.new("scripts/skills/effects/double_strike_effect"));
		}

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
			if (this.m.SkillCount == this.Const.SkillCounter && this.m.LastTargetID == _targetEntity.getID())
			{
				return;
			}

			this.m.SkillCount = this.Const.SkillCounter;
			this.m.LastTargetID = _targetEntity.getID();
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/overwhelmed_effect"));
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
			if (this.m.SkillCount == this.Const.SkillCounter && this.m.LastTargetID == _targetEntity.getID())
			{
				return;
			}

			this.m.SkillCount = this.Const.SkillCounter;
			this.m.LastTargetID = _targetEntity.getID();
			this.m.SkillCount = this.Const.SkillCounter;
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/overwhelmed_effect"));
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

});

