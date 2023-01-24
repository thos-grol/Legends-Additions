this.negative_energy_hand <- this.inherit("scripts/skills/magic_skill", {
	m = {},
	function create()
	{
		this.magic_skill.create();
		this.m.ID = "actives.negative_energy_hand";
		this.m.Name = "Negative Energy Hand";
		this.m.Description = "Transform your hand with negative energy, allowing it to pass through steel and flesh, and strike at your victim's soul.";
		this.m.KilledString = "Killed by Negative Energy Hand";
		this.m.Icon = "skills/deathtouch_square.png";
		this.m.IconDisabled = "skills/deathtouch_square_bw.png";
		this.m.Overlay = "deathtouch_square";
		this.m.SoundOnUse = [
			"sounds/enemies/ghastly_touch_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 4;
		this.m.ManaCost = 1;
		this.m.FatigueCost = 25;
		this.m.DamageInitiativeMin = 25;
		this.m.DamageInitiativeMax = 35;
	}

	function onUpdate()
	{
		local a = this.getContainer().getActor();
		if (a.getSkills().hasSkill("perk.partial_astral_projection"))
		{
			this.m.MaxRange = 3;
			local p = a.getCurrentProperties();
			if (p.RangedSkill > p.MeleeSkill) this.m.IsRanged = true;
			else this.m.IsRanged = false;
		}

		
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.magic_skill.onAnySkillUsed(_skill, _targetEntity, _properties);

		if (_skill == this)
		{
			_properties.DamageRegularMin = this.m.DamageInitiativeMin;
			_properties.DamageRegularMax = this.m.DamageInitiativeMax;
			_properties.IsIgnoringArmorOnAttack = true;

			local a = this.getContainer().getActor();
			if (a.getSkills().hasSkill("perk.partial_astral_projection"))
			{
				_properties.DamageRegularMin += 5;
				_properties.DamageRegularMax += 5;
			}
		}
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Costs " + this.m.ManaCost + " mana."
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Applies Drain. 3 turn duration. -30% Fat Recovery. -10X% Max Hitpoints, where X is duration."
		});
		
		return ret;
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

			this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_targetEntity) + " has been drained.");
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

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});

