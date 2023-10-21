this.strike_down_skill <- this.inherit("scripts/skills/skill", {
	m = {
		StunChance = 75
	},
	function create()
	{
		this.m.ID = "actives.strike_down";
		this.m.Name = "Strike Down";
		this.m.Description = "Strike a heavy blow intended to incapacitate and stun your target for two turns, but not to do the most damage. Stunned targets can not keep up their Shieldwall, Spearwall or similar defensive skills.";
		this.m.KilledString = "Cudgeled to death";
		this.m.Icon = "skills/active_134.png";
		this.m.IconDisabled = "skills/active_134_sw.png";
		this.m.Overlay = "active_134";
		this.m.SoundOnUse = [
			"sounds/combat/strike_down_01.wav",
			"sounds/combat/strike_down_02.wav",
			"sounds/combat/strike_down_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/strike_down_hit_01.wav",
			"sounds/combat/strike_down_hit_02.wav",
			"sounds/combat/strike_down_hit_03.wav",
			"sounds/combat/strike_down_hit_04.wav"
		];
		this.m.SoundVolume = 1.25;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = ::Const.Injury.BluntBody;
		this.m.InjuriesOnHead = ::Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 66;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + ::Const.UI.Color.DamageValue + "]" + ::Const.Combat.FatigueReceivedPerHit * 4 + "[/color] extra fatigue"
		});

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + ::Const.UI.Color.PositiveValue + "]100%[/color] chance to severely stun on a hit"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + ::Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color] chance to stun for two turns on a hit"
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInHammers ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, target);

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && target.isAlive())
		{
			if ((_user.getCurrentProperties().IsSpecializedInHammers || this.Math.rand(1, 100) <= this.m.StunChance) && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasSkill("effects.stunned"))
			{
				local stun = this.new("scripts/skills/effects/stunned_effect");
				target.getSkills().add(stun);
				stun.setTurns(2);

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has stunned " + ::Const.UI.getColorizedEntityName(target) + " for two turns");
				}
			}
		}

		return success;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.FatigueDealtPerHitMult += 4.0;
			_properties.DamageTotalMult *= 0.5;
		}
	}

});

