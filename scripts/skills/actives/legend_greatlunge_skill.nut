this.legend_greatlunge_skill <- this.inherit("scripts/skills/skill", {
	m = {
		SoundOnAttack = [
			"sounds/combat/dlc2/lunge_attack_01.wav",
			"sounds/combat/dlc2/lunge_attack_02.wav",
			"sounds/combat/dlc2/lunge_attack_03.wav",
			"sounds/combat/dlc2/lunge_attack_04.wav"
		]
	},
	function create()
	{
		this.m.ID = "actives.legend_greatlunge";
		this.m.Name = "Great Lunge";
		this.m.Description = "A stronger lunge towards a target 2 tiles away, followed by a precise thrusting attack to catch them unprepared. The faster you are, the more damage you do.";
		this.m.KilledString = "Sliced up";
		this.m.Icon = "skills/active_135.png";
		this.m.IconDisabled = "skills/active_135_sw.png";
		this.m.Overlay = "active_135";
		this.m.SoundOnUse = [
			"sounds/combat/dlc2/lunge_move_01.wav",
			"sounds/combat/dlc2/lunge_move_02.wav",
			"sounds/combat/dlc2/lunge_move_03.wav",
			"sounds/combat/dlc2/lunge_move_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/dlc2/lunge_attack_hit_01.wav",
			"sounds/combat/dlc2/lunge_attack_hit_02.wav",
			"sounds/combat/dlc2/lunge_attack_hit_03.wav",
			"sounds/combat/dlc2/lunge_attack_hit_04.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = ::Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = ::Const.Injury.PiercingHead;
		this.m.HitChanceBonus = 0;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 30;
		this.m.MinRange = 2;
		this.m.MaxRange = 2;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Moves the user next to the target, ignoring Zone of Control"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts additional damage, the higher the user\'s current Initiative"
			}
		]);

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Can not be used while rooted[/color]"
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] chance to hit due to greatsword specialisation"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local myTile = this.getContainer().getActor().getTile();
		local hasTile = false;

		for( local i = 0; i < 6; i = i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);

				if (tile.IsEmpty && tile.getDistanceTo(myTile) == 1 && ::Math.abs(myTile.Level - tile.Level) <= 1 && ::Math.abs(_targetTile.Level - tile.Level) <= 1)
				{
					hasTile = true;
					break;
				}
			}

			i = ++i;
		}

		return hasTile;
	}

	function addResources()
	{
		this.skill.addResources();

		foreach( r in this.m.SoundOnAttack )
		{
			this.Tactical.addResource(r);
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInSwords ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local destTile;

		for( local i = 0; i < 6; i = i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);

				if (tile.IsEmpty && tile.getDistanceTo(myTile) == 1 && ::Math.abs(myTile.Level - tile.Level) <= 1 && ::Math.abs(_targetTile.Level - tile.Level) <= 1)
				{
					destTile = tile;
					break;
				}
			}

			i = ++i;
		}

		if (destTile == null)
		{
			return false;
		}

		this.getContainer().setBusy(true);
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile,
			OnRepelled = this.onRepelled
		};
		_user.spawnTerrainDropdownEffect(myTile);
		this.Tactical.getNavigator().teleport(_user, destTile, this.onTeleportDone.bindenv(this), tag, false, 3.0);
		return true;
	}

	function onTeleportDone( _entity, _tag )
	{
		local myTile = _entity.getTile();
		local ZOC = [];
		this.getContainer().setBusy(false);

		for( local i = 0; i != 6; i = i )
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

					if (actor.isAlliedWith(_entity) || actor.getCurrentProperties().IsStunned)
					{
					}
					else
					{
						ZOC.push(actor);
					}
				}
			}

			i = ++i;
		}

		foreach( actor in ZOC )
		{
			if (!actor.onMovementInZoneOfControl(_entity, true))
			{
				continue;
			}

			if (actor.onAttackOfOpportunity(_entity, true))
			{
				if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_entity) + " lunges and is repelled");
				}

				if (!_entity.isAlive() || _entity.isDying())
				{
					return;
				}

				local dir = myTile.getDirectionTo(_tag.OldTile);

				if (myTile.hasNextTile(dir))
				{
					local tile = myTile.getNextTile(dir);

					if (tile.IsEmpty && ::Math.abs(tile.Level - myTile.Level) <= 1 && tile.getDistanceTo(actor.getTile()) > 1)
					{
						_tag.TargetTile = tile;
						this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
						return;
					}
				}
			}
		}

		this.spawnAttackEffect(_tag.TargetTile, ::Const.Tactical.AttackEffectThrust);
		local s = this.m.SoundOnUse;
		this.m.SoundOnUse = this.m.SoundOnAttack;
		this.attackEntity(_entity, _tag.TargetTile.getEntity());
		this.m.SoundOnUse = s;
	}

	function onRepelled( _tag )
	{
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, null, null, false);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local a = this.getContainer().getActor();
			local s = ::Math.minf(2.0, 2.0 * (::Math.max(0, a.getInitiative() + (_targetEntity != null ? this.getFatigueCost() * a.getCurrentProperties().FatigueToInitiativeRate : 0)) / 175.0));
			_properties.DamageTotalMult *= s;

			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill += 5;
			}
		}
	}

});

