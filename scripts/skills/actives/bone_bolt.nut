this.bone_bolt <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = -3
	},
	function create()
	{
		this.m.ID = "actives.bone_bolt";
		this.m.Name = "Bone Bolt";
		this.m.Description = "Self propelled bone shards";
		this.m.KilledString = "Shot";
		this.m.Icon = "skills/active_17.png";
		this.m.IconDisabled = "skills/active_17_sw.png";
		this.m.Overlay = "active_17"; //FEATURE_0: HOME SOUND bone bolt sounds
		this.m.SoundOnUse = [
			"sounds/combat/bolt_shot_01.wav",
			"sounds/combat/bolt_shot_02.wav",
			"sounds/combat/bolt_shot_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/bolt_shot_hit_01.wav",
			"sounds/combat/bolt_shot_hit_02.wav",
			"sounds/combat/bolt_shot_hit_03.wav"
		];
		this.m.SoundOnHitShield = [
			"sounds/combat/shield_hit_arrow_01.wav",
			"sounds/combat/shield_hit_arrow_02.wav",
			"sounds/combat/shield_hit_arrow_03.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/bolt_shot_miss_01.wav",
			"sounds/combat/bolt_shot_miss_02.wav",
			"sounds/combat/bolt_shot_miss_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 100;
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
		this.m.InjuriesOnBody = ::Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = ::Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.45;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = ::Const.ProjectileType.Arrow; //FEATURE_0: ART custom arrow
	}

	function getTooltip()
	{
		local ret = this.getRangedTooltip(this.getDefaultTooltip());
		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable();
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

			if (_properties.IsSharpshooter)
			{
				_properties.DamageDirectMult += 0.05;
			}
		}
	}

	function onUpdate( _properties )
	{
		_properties.DamageRegularMin += 40;
		_properties.DamageRegularMax += 60;
		_properties.DamageArmorMult *= 0.75;
	}

});

