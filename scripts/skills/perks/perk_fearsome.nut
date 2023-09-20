::Const.Strings.PerkName.Fearsome = "Fearsome";
::Const.Strings.PerkDescription.Fearsome = "Make them scatter and flee!"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Dealing at least 1 HP damage:")
+ "\n Morale check enemy with a penalty of "+ ::MSU.Text.colorGreen("20% this unit\'s resolve")
+ "\n" + ::MSU.Text.colorRed("Does not proc multiple times on the same target from one attack")
+ "\n\n" + ::MSU.Text.colorRed("Default morale check occurs at 15 HP damage with no penalty");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Fearsome].Name = ::Const.Strings.PerkName.Fearsome;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Fearsome].Tooltip = ::Const.Strings.PerkDescription.Fearsome;

this.perk_fearsome <- this.inherit("scripts/skills/skill", {
	m = {
		LastFrameApplied = 0,
		LastEnemyAppliedTo = 0,
		SkillCount = 0
	},
	function create()
	{
		this.m.ID = "perk.fearsome";
		this.m.Name = this.Const.Strings.PerkName.Fearsome;
		this.m.Description = this.Const.Strings.PerkDescription.Fearsome;
		this.m.Icon = "ui/perks/perk_27.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity == null || !_targetEntity.isAlive())
		{
			return;
		}

		if (_targetEntity.getMoraleState() == this.Const.MoraleState.Ignore || !_targetEntity.getCurrentProperties().IsAffectedByLosingHitpoints)
		{
			return;
		}

		if ((this.Time.getFrame() == this.m.LastFrameApplied || this.m.SkillCount == this.Const.SkillCounter) && _targetEntity.getID() == this.m.LastEnemyAppliedTo)
		{
			if (_damageInflictedHitpoints >= this.Const.Morale.OnHitMinDamage)
			{
				this.spawnIcon("perk_27", _targetEntity.getTile());
			}

			return;
		}

		if (_damageInflictedHitpoints >= 1)
		{
			this.spawnIcon("perk_27", _targetEntity.getTile());
		}

		this.m.LastFrameApplied = this.Time.getFrame();
		this.m.LastEnemyAppliedTo = _targetEntity.getID();
		this.m.SkillCount = this.Const.SkillCounter;

		if (_damageInflictedHitpoints >= 1 && _damageInflictedHitpoints < this.Const.Morale.OnHitMinDamage)
		{
			_targetEntity.checkMorale(-1, this.Const.Morale.OnHitBaseDifficulty * (1.0 - _targetEntity.getHitpoints() / _targetEntity.getHitpointsMax()) - this.getContainer().getActor().getCurrentProperties().ThreatOnHit);
		}
	}

	function onAfterUpdate( _properties )
	{
		_properties.ThreatOnHit += this.Math.min(20, this.Math.max(0, (_properties.getBravery() - 10) * 0.2));
	}

	function onCombatStarted()
	{
		this.m.SkillCount = 0;
		this.m.LastEnemyAppliedTo = 0;
		this.m.LastFrameApplied = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.SkillCount = 0;
		this.m.LastEnemyAppliedTo = 0;
		this.m.LastFrameApplied = 0;
	}

});

