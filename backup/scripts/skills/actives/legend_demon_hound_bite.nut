this.legend_demon_hound_bite <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_demon_hound_bite";
		this.m.Name = "Höllenhund Bite";
		this.m.Description = "";
		this.m.KilledString = "Drained of life";
		this.m.Icon = "skills/demon_hound_bite.png";
		this.m.Overlay = "demon_hound_bite";
		this.m.SoundOnUse = [
			"sounds/enemies/hollen_attack_01.wav",
			"sounds/enemies/hollen_attack_02.wav",
			"sounds/enemies/hollen_attack_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 6;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 0;
	}

	function onUpdate( _properties )
	{
		_properties.DamageRegularMin += 30;
		_properties.DamageRegularMax += 50;
		_properties.DamageArmorMult *= 1.0;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity.getHitpoints() <= 0 || !_targetEntity.isAlive()) return;
		if (_targetEntity.getFlags().has("undead")) return;
		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_targetEntity) + " sprit is being drained");
		}

		local poison = _targetEntity.getSkills().getSkillByID("effects.drained_effect");
		if (poison == null)
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/drained_effect"));
			poison = _targetEntity.getSkills().getSkillByID("effects.drained_effect");
			poison.setActorID(this.getContainer().getActor().getID());
		}
		else
		{
			poison.setActorID(this.getContainer().getActor().getID());
			poison.resetTime();
		}
		
	}

});

