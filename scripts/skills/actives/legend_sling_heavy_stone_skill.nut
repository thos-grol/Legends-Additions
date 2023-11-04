this.legend_sling_heavy_stone_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = -10,
		AdditionalHitChance = -5
	},
	function create()
	{
		this.m.ID = "actives.legend_sling_heavy_stone";
		this.m.Name = "Sling Heavy Stone";
		this.m.Description = "Hurl a stone towards a target with your sling. Hard to aim and very unwieldy, but stones are everywhere so you never run out of ammunition. Is very exhausting but has good armor damage. Can not be used while engaged in melee. Higher hitpoints will increase damage. Has lower accuracy";
		this.m.KilledString = "Stoned";
		this.m.Icon = "skills/active_12.png";
		this.m.IconDisabled = "skills/active_12_sw.png";
		this.m.Overlay = "active_12";
		this.m.SoundOnUse = [
			"sounds/combat/dlc4/sling_use_01.wav",
			"sounds/combat/dlc4/sling_use_02.wav",
			"sounds/combat/dlc4/sling_use_03.wav",
			"sounds/combat/dlc4/sling_use_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/dlc4/sling_hit_01.wav",
			"sounds/combat/dlc4/sling_hit_02.wav",
			"sounds/combat/dlc4/sling_hit_03.wav",
			"sounds/combat/dlc4/sling_hit_04.wav"
		];
		this.m.SoundOnHitShield = [
			"sounds/combat/dlc4/sling_shield_hit_01.wav",
			"sounds/combat/dlc4/sling_shield_hit_02.wav",
			"sounds/combat/dlc4/sling_shield_hit_03.wav",
			"sounds/combat/dlc4/sling_shield_hit_04.wav",
			"sounds/combat/dlc4/sling_shield_hit_05.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/dlc4/sling_miss_01.wav",
			"sounds/combat/dlc4/sling_miss_02.wav",
			"sounds/combat/dlc4/sling_miss_03.wav",
			"sounds/combat/dlc4/sling_miss_04.wav",
			"sounds/combat/dlc4/sling_miss_05.wav",
			"sounds/combat/dlc4/sling_miss_06.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 500;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsWeaponSkill = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = ::Const.Injury.BluntBody;
		this.m.InjuriesOnHead = ::Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.75;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 35;
		this.m.MinRange = 2;
		this.m.MaxRange = 7;
		this.m.MaxLevelDifference = 8;
		this.m.ProjectileType = ::Const.ProjectileType.Stone;
		this.m.ProjectileTimeScale = 1.2;
		this.m.IsProjectileRotated = true;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 25;
	}

	function getTooltip()
	{
		local ret = this.getRangedTooltip(this.getDefaultTooltip());

		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text =  getBonus() + "x Damage. 200 HP caps damage at 1.5x"
		});

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Staggers on hit. Headshots will daze"
		});

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}


		return ret;
	}

	function getBonus()
	{
		local bonus = 1.0 + ::Math.min(this.getContainer().getActor().getHitpointsMax(), 200) / 400.0;
		return (this.getContainer().getSkillByID("perk.stance.david") != null) ? bonus * 1.33 : bonus;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onAfterUpdate( _properties )
	{
		this.m.AdditionalAccuracy =  -10;
		this.m.AdditionalHitChance = -5;
		this.m.FatigueCostMult = _properties.IsSpecializedInBows ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.getContainer().setBusy(true);
			local tag = {
				Skill = this,
				User = _user,
				TargetTile = _targetTile
			};
			this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.Delay, this.onPerformAttack, tag);

			if (!_user.isPlayerControlled() && _targetTile.getEntity().isPlayerControlled())
			{
				_user.getTile().addVisibilityForFaction(::Const.Faction.Player);
			}

			return true;
		}
		else
		{
			return this.attackEntity(_user, _targetTile.getEntity());
		}
	}

	function onPerformAttack( _tag )
	{
		_tag.Skill.getContainer().setBusy(false);
		return _tag.Skill.attackEntity(_tag.User, _tag.TargetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
			_properties.DamageRegularMult *= getBonus();
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill != this || !_targetEntity.isAlive() || _targetEntity.isDying()) return;
		if (_bodyPart != ::Const.BodyPart.Head) return;

		local targetTile = _targetEntity.getTile();
		local user = this.getContainer().getActor();

		_targetEntity.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
		if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
				this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + " is staggered");

		if (user.getSkills().getSkillByID("perk.stance.david") != null && !_targetEntity.getCurrentProperties().IsImmuneToStun && !_targetEntity.getSkills().hasSkill("effects.stunned"))
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));
			if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
				this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + " is stunned for 1 turn");
		}
		else if (!_targetEntity.getCurrentProperties().IsImmuneToDaze)
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
			if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
				this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + " is dazed");
		}
	}

});

