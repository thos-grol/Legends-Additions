this.shoot_stake <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = -3
	},
	function onItemSet()
	{
		this.m.MaxRange = this.m.Item.getRangeMax();
	}

	function create()
	{
		this.m.ID = "actives.shoot_stake";
		this.m.Name = "Shoot Heavy Bolt";
		this.m.Description = "A quick pull of the trigger to loose a heavy bolt. Must be reloaded after each shot to be able to fire again. Knocks targets back. Deals +100 damage to vampires \n\nCrossbows excel in accuracy, damage, and armor piercing but have a slow fire rate";
		this.m.KilledString = "Shot";
		this.m.Icon = "skills/active_81.png";
		this.m.IconDisabled = "skills/active_81_sw.png";
		this.m.Overlay = "active_81";
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
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 7;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = ::Const.ProjectileType.Arrow;
	}

	function getTooltip()
	{
		local ret = this.getRangedTooltip(this.getDefaultTooltip());
		local ammo = this.getAmmo();

		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/ammo.png",
			text = "+" + getBonus() + " Ranged Skill. Effect diminshes the closer this unit has to 100 ranged skill"
		});

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + ::Const.UI.Color.PositiveValue + "]" + ammo + "[/color] bolts left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Needs a non-empty quiver of bolts equipped[/color]"
			});
		}

		if (!this.getItem().isLoaded())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Must be reloaded before firing again[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.getItem().isLoaded();
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Ammo);

		if (item == null)
		{
			return 0;
		}

		if (item.getAmmoType() == ::Const.Items.AmmoType.Bolts)
		{
			return item.getAmmo();
		}
	}

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		local dir = _userTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local knockToTile = _targetTile.getNextTile(dir);

			if (knockToTile.IsEmpty && knockToTile.Level - _userTile.Level <= 1)
			{
				return knockToTile;
			}
		}

		return null;
	}

	function getBonus()
	{
		local ranged_skill = this.getContainer().getActor().getCurrentProperties().RangedSkill;
		return ::Math.round(::Math.max(100 - ranged_skill, 0) / 2.0);
	}

	function onAfterUpdate( _properties )
	{
		this.m.AdditionalAccuracy = getBonus() + this.m.Item.getAdditionalAccuracy();
		// this.m.DirectDamageMult = _properties.IsSpecializedInCrossbows ? 0.7 : 0.5;
	}

	function onUse( _user, _targetTile )
	{
		local ret = this.attackEntity(_user, _targetTile.getEntity());
		this.getItem().setLoaded(false);
		local skillToAdd = this.new("scripts/skills/actives/reload_bolt");
		skillToAdd.setItem(this.getItem());
		skillToAdd.setFatigueCost(::Math.max(0, skillToAdd.getFatigueCostRaw() + this.getItem().m.FatigueOnSkillUse));
		this.getContainer().add(skillToAdd);
		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return;
		}

		if (_targetEntity == null)
		{
			return;
		}

		_properties.RangedSkill += this.m.AdditionalAccuracy;
		_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

		if (_targetEntity.getType() == ::Const.EntityType.Vampire || _targetEntity.getType() == ::Const.EntityType.LegendVampireLord)
		{
			_properties.DamageRegularMin += 100;
			_properties.DamageRegularMax += 105;
		}

		if (_properties.IsSharpshooter)
		{
			_properties.DamageDirectMult += 0.05;
		}
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.reload_bolt");
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();

			if (_targetEntity.getCurrentProperties().IsImmuneToKnockBackAndGrab || _targetEntity.getCurrentProperties().IsRooted)
			{
				return false;
			}

			local knockToTile = this.findTileToKnockBackTo(user.getTile(), targetTile);

			if (knockToTile == null)
			{
				return;
			}

			if (!user.isHiddenToPlayer() && (targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(user) + " has knocked back " + ::Const.UI.getColorizedEntityName(_targetEntity));
			}

			local skills = _targetEntity.getSkills();
			skills.removeByID("effects.shieldwall");
			skills.removeByID("effects.spearwall");
			skills.removeByID("effects.riposte");
			local damage = ::Math.max(0, ::Math.abs(knockToTile.Level - targetTile.Level) - 1) * ::Const.Combat.FallingDamage;

			if (damage == 0)
			{
				this.Tactical.getNavigator().teleport(_targetEntity, knockToTile, null, null, true);
			}
			else
			{
				local p = this.getContainer().getActor().getCurrentProperties();
				local tag = {
					Attacker = user,
					Skill = this,
					HitInfo = clone ::Const.Tactical.HitInfo,
					HitInfoBash = null
				};
				tag.HitInfo.DamageRegular = damage;
				tag.HitInfo.DamageFatigue = ::Const.Combat.FatigueReceivedPerHit;
				tag.HitInfo.DamageDirect = 1.0;
				tag.HitInfo.BodyPart = ::Const.BodyPart.Body;
				tag.HitInfo.BodyDamageMult = 1.0;
				tag.HitInfo.FatalityChanceMult = 1.0;
				this.Tactical.getNavigator().teleport(_targetEntity, knockToTile, this.onKnockedDown, tag, true);
			}
		}
	}

	function onKnockedDown( _entity, _tag )
	{
		if (_tag.HitInfo.DamageRegular != 0)
		{
			_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
		}
	}

});

