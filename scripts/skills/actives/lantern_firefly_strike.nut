//Lantern
//Firefly Strike
//Fantasy Bro's code
this.lantern_firefly_strike <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0
	},
	function onItemSet()
	{
		this.m.MaxRange = this.m.Item.getRangeMax();
	}

	function create()
	{
		this.m.ID = "actives.lantern_firefly_strike";
		this.m.Name = "Firefly strike";
		this.m.Description = "Unleash powerful arcane energy at the target";
		this.m.Icon = "skills/active_202.png";
		this.m.IconDisabled = "skills/active_202_sw.png";
		this.m.Overlay = "active_202";
		this.m.SoundOnUse = [
			"sounds/combat/bolt_shot_01.wav",
			"sounds/combat/bolt_shot_02.wav",
			"sounds/combat/bolt_shot_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];
		this.m.SoundVolume = 0.9;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 200;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsWeaponSkill = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsDoingForwardMove = false;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 15;
		this.m.MinRange = 2;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 4;
		this.m.InjuriesOnBody = ::Const.Injury.BurningBody;
		this.m.InjuriesOnHead = ::Const.Injury.BurningHead;
		this.m.ProjectileType = ::Const.ProjectileType.xxprojectile_05; //TODO: port over brush
		this.m.ProjectileTimeScale = 0.9;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + this.getMaxRange() + " tiles"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has " + (15 + this.m.AdditionalAccuracy) + "% chance to hit, and " + (-2 + this.m.AdditionalHitChance) + "% per tile of distance"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Ignores obstacles and only attacks selected target."
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

	function isUsable()
	{
		return !this.Tactical.isActive() || !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			this.Tactical.spawnSpriteEffect("sparkleflare_1", this.createColor("#ccf1ff"), _targetEntity.getTile(), 0, 40, 1.5, 1.5, -10, 400, 300);
			this.Tactical.spawnSpriteEffect("sparkleflare_2", this.createColor("#ccf1ff"), _targetEntity.getTile(), 0, 40, 1, 0.5, 10, 150, 350);
		}
	}

	function onUse( _user, _targetTile )
	{
		local flip = !this.m.IsProjectileRotated && _targetTile.Pos.X > _user.getPos().X;
		local myTile = _user.getTile();
		local dir = _targetTile.getDirectionTo(myTile);
		local xxtile = [];
		local xxtileE;
		this.m.IsDoingAttackMove = false;
		this.getContainer().setBusy(true);
		if (myTile.hasNextTile(dir))
		{
			local boltTile = myTile.getNextTile(dir);
			if (this.Math.abs(boltTile.Level - myTile.Level) <= this.m.MaxLevelDifference)
			{
				xxtile.push(boltTile);
				xxtile.push(boltTile);
			}
		}
		local left = dir - 1 < 0 ? 5 : dir - 1;
		if (myTile.hasNextTile(left))
		{
			local boltTile = myTile.getNextTile(left);
			if (this.Math.abs(boltTile.Level - myTile.Level) <= this.m.MaxLevelDifference)
			{
				xxtile.push(boltTile);
				xxtile.push(boltTile);
			}
		}
		local right = dir + 1 > 5 ? 0 : dir + 1;
		if (myTile.hasNextTile(right))
		{
			local boltTile = myTile.getNextTile(right);
			if (this.Math.abs(boltTile.Level - myTile.Level) <= this.m.MaxLevelDifference)
			{
				xxtile.push(boltTile);
				xxtile.push(boltTile);
			}
		}
		xxtile.push(myTile);
		for( local i = 0; i < xxtile.len(); i = ++i )
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 0 + (i * 80), function ( _skill )
			{
				xxtileE = xxtile.remove(this.Math.rand(0, xxtile.len() - 1));
				if (_user.getTile().getDistanceTo(_targetTile) >= ::Const.Combat.SpawnProjectileMinDist)
				{
					this.Sound.play("sounds/combat/strike_down_hit_0" + this.Math.rand(1, 2) + ".wav", ::Const.Sound.Volume.Skill * 1.2, this.getContainer().getActor().getPos());
					this.Tactical.spawnSpriteEffect("sparkleflare_1", this.createColor("#ccf1ff"), xxtileE, 0, 10, 1.2, 0.2, -10, 200, 400);
					this.Tactical.spawnProjectileEffect(::Const.ProjectileSprite[this.m.ProjectileType], xxtileE, _targetTile, 0.7 + (this.Math.rand(0, 5) * 0.1), this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
				}
			}.bindenv(this), this);
		}

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 700, function ( _skill )
		{
			if ( _targetTile.getEntity().isAlive())
			{
				_skill.attackEntity(_user, _targetTile.getEntity(), false);
			}
			_skill.m.IsDoingAttackMove = true;
			_skill.getContainer().setBusy(false);
		}.bindenv(this), this);
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += 15 + this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile -= 2 + this.m.AdditionalHitChance;
		}
	}

});

