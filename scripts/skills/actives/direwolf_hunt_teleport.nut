this.direwolf_hunt_teleport <- this.inherit("scripts/skills/skill", {
	m = {
		TilesUsed = [],
		Cooldown = 2,
		Cooldown_Max = 3,
		HuntTile = null,
	},
	function create()
	{
		this.m.ID = "actives.direwolf_hunt_teleport";
		this.m.Name = "Hunt";
		this.m.Description = "";
		this.m.Icon = "skills/active_167.png";
		this.m.IconDisabled = "skills/active_167.png";
		// this.m.Overlay = "active_167";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc4/thing_teleport_01.wav",
			"sounds/enemies/dlc4/thing_teleport_02.wav",
			"sounds/enemies/dlc4/thing_teleport_03.wav",
			"sounds/enemies/dlc4/thing_teleport_04.wav"
		];
		this.m.SoundOnHit = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 3;
		this.m.MaxRange = 7;
		this.m.MaxLevelDifference = 4;

		this.m.IsSpearwallRelevant = false;
		this.m.InjuriesOnBody = ::Const.Injury.BluntBody;
		this.m.InjuriesOnHead = ::Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 25;
		this.m.ChanceSmash = 25;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
	}

	function onTurnStart()
	{
		this.m.Cooldown = this.Math.max(0, this.m.Cooldown - 1);
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		return this.skill.isUsable() && (this.m.Cooldown == 0 || actor.getFlags().has("la_direwolf_frenzy_attacks"));
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsEmpty)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.TilesUsed = [];
		this.m.Cooldown = this.m.Cooldown_Max;
		local actor = this.getContainer().getActor();

		this.Sound.play("sounds/monster/direwolf_howl.wav", 500.0, actor.getPos());
		
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile,
			OnDone = this.onTeleportDone.bindenv(this),
			OnFadeIn = this.onFadeIn.bindenv(this),
			OnFadeDone = this.onFadeDone.bindenv(this),
			OnTeleportStart = this.onTeleportStart.bindenv(this),
			OnStrike = this.onStrike.bindenv(this),
			OnStrikeTeleportDone = this.onStrikeTeleportDone.bindenv(this),
			OnKnockedDown = this.onKnockedDown.bindenv(this),
			IgnoreColors = false
		};

		if (_user.getTile().IsVisibleForPlayer)
		{
			if (::Const.Tactical.SpiritWalkStartParticles.len() != 0)
			{
				for( local i = 0; i < ::Const.Tactical.SpiritWalkStartParticles.len() - 1; i = ++i )
				{
					this.Tactical.spawnParticleEffect(false, ::Const.Tactical.SpiritWalkStartParticles[i].Brushes, _user.getTile(), ::Const.Tactical.SpiritWalkStartParticles[i].Delay, ::Const.Tactical.SpiritWalkStartParticles[i].Quantity, ::Const.Tactical.SpiritWalkStartParticles[i].LifeTimeQuantity, ::Const.Tactical.SpiritWalkStartParticles[i].SpawnRate, ::Const.Tactical.SpiritWalkStartParticles[i].Stages);
				}
			}

			_user.storeSpriteColors();
			_user.fadeTo(this.createColor("4cccf300"), 900);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 900, this.onTeleportStart, tag);
		}
		else if (_targetTile.IsVisibleForPlayer)
		{
			_user.storeSpriteColors();
			_user.fadeTo(this.createColor("4cccf300"), 0);
			this.onTeleportStart(tag);
		}
		else
		{
			tag.IgnoreColors = true;
			this.onTeleportStart(tag);
		}

		return true;
	}

	function onTeleportStart( _tag )
	{
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, _tag.OnDone, _tag, false, 3.0);
	}

	function onTeleportDone( _entity, _tag )
	{
		if (!_entity.isHiddenToPlayer())
		{
			if (::Const.Tactical.SpiritWalkEndParticles.len() != 0)
			{
				for( local i = 0; i < ::Const.Tactical.SpiritWalkEndParticles.len() - 1; i = ++i )
				{
					this.Tactical.spawnParticleEffect(false, ::Const.Tactical.SpiritWalkEndParticles[i].Brushes, _entity.getTile(), ::Const.Tactical.SpiritWalkEndParticles[i].Delay, ::Const.Tactical.SpiritWalkEndParticles[i].Quantity, ::Const.Tactical.SpiritWalkEndParticles[i].LifeTimeQuantity, ::Const.Tactical.SpiritWalkEndParticles[i].SpawnRate, ::Const.Tactical.SpiritWalkEndParticles[i].Stages);
				}
			}

			this.Time.scheduleEvent(this.TimeUnit.Virtual, 300, _tag.OnFadeIn, _tag);

			if (_entity.getTile().IsVisibleForPlayer && _tag.Skill.m.SoundOnHit.len() > 0)
			{
				this.Sound.play(_tag.Skill.m.SoundOnHit[this.Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, _entity.getPos());
			}
		}
		else
		{
			_tag.OnFadeIn(_tag);
		}
	}

	function onFadeIn( _tag )
	{
		if (!_tag.IgnoreColors)
		{
			if (_tag.User.isHiddenToPlayer())
			{
				_tag.User.restoreSpriteColors();
			}
			else
			{
				_tag.User.fadeToStoredColors(900);
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 900, _tag.OnFadeDone, _tag);
			}
		}
	}

	function onFadeDone( _tag )
	{
		_tag.User.restoreSpriteColors();
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 300, _tag.OnStrike, _tag);
	}

//////////////////////////////////////////////////////////////////////////////
// Hunt Strike
//////////////////////////////////////////////////////////////////////////////

	function onStrike( _tag )
	{		
		_tag.TargetTile = this.m.HuntTile;

		local s = [
			"sounds/enemies/wolf_bite_01.wav",
			"sounds/enemies/wolf_bite_02.wav",
			"sounds/enemies/wolf_bite_03.wav",
			"sounds/enemies/wolf_bite_04.wav"
		];
		this.Sound.play(::MSU.Array.rand(s), 100.0, _tag.User.getPos());

		if (_tag.OldTile.IsVisibleForPlayer || _tag.TargetTile.IsVisibleForPlayer )
		{
			local myPos = _tag.User.getPos();
			local targetPos = _tag.TargetTile.Pos;
			local distance = _tag.OldTile.getDistanceTo(_tag.TargetTile);

			local Dx = (targetPos.X - myPos.X) / distance;
			local Dy = (targetPos.Y - myPos.Y) / distance;

			for( local i = 0; i < distance; i = ++i )
			{
				local x = myPos.X + Dx * i;
				local y = myPos.Y + Dy * i;
				local tile = this.Tactical.worldToTile(this.createVec(x, y));

				if (this.Tactical.isValidTile(tile.X, tile.Y) && ::Const.Tactical.DustParticles.len() != 0)
				{
					for( local i = 0; i < ::Const.Tactical.DustParticles.len(); i = ++i )
					{
						this.Tactical.spawnParticleEffect(false, ::Const.Tactical.DustParticles[i].Brushes, this.Tactical.getTile(tile), ::Const.Tactical.DustParticles[i].Delay, ::Const.Tactical.DustParticles[i].Quantity * 0.5, ::Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, ::Const.Tactical.DustParticles[i].SpawnRate, ::Const.Tactical.DustParticles[i].Stages);
					}
				}
			}
		}

		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, _tag.OnStrikeTeleportDone, _tag, false, 3.0);
		return true;
	}

	function onStrikeTeleportDone(  _entity, _tag )
	{
		local myTile = _entity.getTile();
		local potentialVictims = [];
		local betterThanNothing;
		local dirToTarget = _tag.OldTile.getDirectionTo(myTile);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = myTile.getNextTile(i);

				if (!tile.IsOccupiedByActor)
				{
				}
				else
				{
					local actor = tile.getEntity();

					if (actor.isAlliedWith(_entity))
					{
					}
					else
					{
						if (betterThanNothing == null)
						{
							betterThanNothing = actor;
						}

						potentialVictims.push(actor);
					}
				}
			}
		}

		if (potentialVictims.len() == 0 && betterThanNothing != null)
		{
			potentialVictims.push(betterThanNothing);
		}

		foreach( victim in potentialVictims )
		{
			if (_tag.Skill.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(_tag.Skill.m.SoundOnHit[this.Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, victim.getPos());
			}

			this.spawnAttackEffect(victim.getTile(), ::Const.Tactical.AttackEffectClaws);
			this.attackEntity(_entity, victim);

			local s = [
				"sounds/enemies/werewolf_claw_hit_01.wav",
				"sounds/enemies/werewolf_claw_hit_02.wav",
				"sounds/enemies/werewolf_claw_hit_03.wav"
			];
			this.Sound.play(::MSU.Array.rand(s), 100.0, _tag.User.getPos());

			if (victim.isAlive())
			{
				_tag.Skill.applyEffectToTarget(_tag, _entity, victim, victim.getTile());
			}
		}
	}

	function applyEffectToTarget( _tag, _user, _target, _targetTile )
	{
		if (_target.isNonCombatant()) return;

		if (!_target.getSkills().hasSkill("effects.staggered")) 
				_target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
		
		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) ::Z.Log.status(_target, "staggered (1 turn)");

		if (!_target.getCurrentProperties().IsImmuneToKnockBackAndGrab && !_target.getCurrentProperties().IsRooted)
		{
			local knockToTile = _tag.Skill.findTileToKnockBackTo(_user.getTile(), _targetTile);

			if (knockToTile == null)
			{
				return;
			}

			this.m.TilesUsed.push(knockToTile.ID);

			if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer)) 
				::Z.Log.status(_target, "knocked back");

			local skills = _target.getSkills();
			skills.removeByID("effects.shieldwall");
			skills.removeByID("effects.spearwall");
			skills.removeByID("effects.riposte");
			_target.setCurrentMovementType(::Const.Tactical.MovementType.Involuntary);
			local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - _targetTile.Level) - 1) * ::Const.Combat.FallingDamage;

			if (damage == 0)
			{
				this.Tactical.getNavigator().teleport(_target, knockToTile, null, null, true);
			}
			else
			{
				local p = this.getContainer().getActor().getCurrentProperties();
				local tag = {
					Attacker = _user,
					Skill = this,
					HitInfo = clone ::Const.Tactical.HitInfo
				};
				tag.HitInfo.DamageRegular = damage;
				tag.HitInfo.DamageDirect = 1.0;
				tag.HitInfo.BodyPart = ::Const.BodyPart.Body;
				tag.HitInfo.BodyDamageMult = 1.0;
				tag.HitInfo.FatalityChanceMult = 1.0;
				this.Tactical.getNavigator().teleport(_target, knockToTile, _tag.OnKnockedDown, tag, true);
			}
		}
	}

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		local dir = _userTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local knockToTile = _targetTile.getNextTile(dir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1 && this.m.TilesUsed.find(knockToTile.ID) == null)
			{
				return knockToTile;
			}
		}

		local altdir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1 && this.m.TilesUsed.find(knockToTile.ID) == null)
			{
				return knockToTile;
			}
		}

		altdir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1 && this.m.TilesUsed.find(knockToTile.ID) == null)
			{
				return knockToTile;
			}
		}

		return null;
	}

	function onKnockedDown( _entity, _tag )
	{
		if (_tag.HitInfo.DamageRegular != 0) _entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
	}

	

	

});

