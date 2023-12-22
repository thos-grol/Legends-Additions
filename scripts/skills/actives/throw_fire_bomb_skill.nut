this.throw_fire_bomb_skill <- this.inherit("scripts/skills/_alchemy_active", {
	m = {},
	function create()
	{
		this._alchemy_active.create();
		this.m.ID = "actives.throw_fire_bomb";
		this.m.Name = "Throw Fire Pot";
		this.m.Description = "Ignite and throw a pot filled with highly flammable liquids towards a target, where it will shatter and set the area ablaze. Anyone ending their turn inside the burning area will catch fire and take damage - friend and foe alike.";
		this.m.Icon = "skills/active_209.png";
		this.m.IconDisabled = "skills/active_209_sw.png";
		this.m.Overlay = "active_209";
		this.m.SoundOnUse = [
			"sounds/combat/throw_ball_01.wav",
			"sounds/combat/throw_ball_02.wav",
			"sounds/combat/throw_ball_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/dlc6/fire_pot_01.wav",
			"sounds/combat/dlc6/fire_pot_02.wav",
			"sounds/combat/dlc6/fire_pot_03.wav",
			"sounds/combat/dlc6/fire_pot_04.wav"
		];
		this.m.SoundOnHitDelay = 0;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsAttack = true;
		this.m.IsOffensiveToolSkill = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = true;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 3;
		this.m.ProjectileType = ::Const.ProjectileType.Bomb1;
		this.m.ProjectileTimeScale = 1.5;
		this.m.IsProjectileRotated = false;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Set an area of [color=" + ::Const.UI.Color.DamageValue + "]7[/color] tiles ablaze with fire for 2 rounds. Water and snow can not burn."
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Burns away existing tile effects like Smoke or Miasma"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This damage shown only occurs when an enemy ends turn inside of the area, it does not affect the enemy when thrown"
		});
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_originTile.Level + 1 < _targetTile.Level)
		{
			return false;
		}

		return true;
	}

	function onTargetSelected( _targetTile )
	{
		local affectedTiles = [];
		affectedTiles.push(_targetTile);

		for( local i = 0; i != 6; i = i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);
				affectedTiles.push(tile);
			}

			i = ++i;
		}

		foreach( t in affectedTiles )
		{
			this.Tactical.getHighlighter().addOverlayIcon(::Const.Tactical.Settings.AreaOfEffectIcon, t, t.Pos.X, t.Pos.Y);
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		consumeAmmo();
		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
		{
			local flip = !this.m.IsProjectileRotated && _targetTile.Pos.X > _user.getPos().X;

			if (_user.getTile().getDistanceTo(_targetTile) >= ::Const.Combat.SpawnProjectileMinDist)
			{
				this.Tactical.spawnProjectileEffect(::Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}

		this.Time.scheduleEvent(this.TimeUnit.Real, 250, this.onApply.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});
	}

	function onApply( _data )
	{
		local targets = [];
		targets.push(_data.TargetTile);

		for( local i = 0; i != 6; i = i )
		{
			if (!_data.TargetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _data.TargetTile.getNextTile(i);
				targets.push(tile);
			}

			i = ++i;
		}

		this.Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], 1.0, _data.TargetTile.Pos);
		local p = {
			Type = "fire",
			Tooltip = "Fire rages here, melting armor and flesh alike",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = _data.User.isPlayerControlled(),
			Timeout = this.Time.getRound() + 2,
			Callback = ::Const.Tactical.Common.onApplyFire,
			function Applicable( _a )
			{
				return true;
			}

		};

		foreach( tile in targets )
		{
			if (tile.Subtype != ::Const.Tactical.TerrainSubtype.Snow && tile.Subtype != ::Const.Tactical.TerrainSubtype.LightSnow && tile.Type != ::Const.Tactical.TerrainType.ShallowWater && tile.Type != ::Const.Tactical.TerrainType.DeepWater)
			{
				if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "fire")
				{
					tile.Properties.Effect.Timeout = this.Time.getRound() + 2;
				}
				else
				{
					if (tile.Properties.Effect != null)
					{
						this.Tactical.Entities.removeTileEffect(tile);
					}

					tile.Properties.Effect = clone p;
					local particles = [];

					for( local i = 0; i < ::Const.Tactical.FireParticles.len(); i = i )
					{
						particles.push(this.Tactical.spawnParticleEffect(true, ::Const.Tactical.FireParticles[i].Brushes, tile, ::Const.Tactical.FireParticles[i].Delay, ::Const.Tactical.FireParticles[i].Quantity, ::Const.Tactical.FireParticles[i].LifeTimeQuantity, ::Const.Tactical.FireParticles[i].SpawnRate, ::Const.Tactical.FireParticles[i].Stages));
						i = ++i;
					}

					this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
					tile.clear(::Const.Tactical.DetailFlag.Scorchmark);
					tile.spawnDetail("impact_decal", ::Const.Tactical.DetailFlag.Scorchmark, false, true);
				}
			}

			if (tile.IsOccupiedByActor)
			{
				::Const.Tactical.Common.onApplyFire(tile, tile.getEntity());
			}
		}
	}

});

