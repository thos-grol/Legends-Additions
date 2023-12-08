this.cultist_eldritch_blast <- this.inherit("scripts/skills/skill", {
	m = {
		BlastCount = 3,
		IsPull = false
	},
	function create()
	{
		this.m.ID = "actives.eldritch_blast";
		this.m.Name = "Eldritch Blast";
		this.m.Description = "Fire a eldritch blast of force to smash your foes.";
		this.m.KilledString = "Blasted";
		this.m.Icon = "skills/eldritch_blast.png";
		this.m.IconDisabled = "skills/eldritch_blast_bw.png";
		this.m.Overlay = "eldritch_blast";
		this.m.SoundOnUse = [];
		this.m.SoundOnHit = [];
		this.m.SoundOnHitShield = [];
		this.m.SoundOnMiss = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = ::Const.Injury.BluntBody;
		this.m.InjuriesOnHead = ::Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 40;
		this.m.MinRange = 1;
		this.m.MaxRange = 5;
		this.m.MaxLevelDifference = 6;
		this.m.ProjectileType = ::Const.ProjectileType.ELDRITCHBLAST;
		this.m.Delay = 750;
		this.m.ProjectileTimeScale = 1.0;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Fires " + getBlastCount() + " blasts, staggering the enemy and having a 44% chance to knockback."
		});
		if (actor.getFaction() == ::Const.Faction.Player && actor.getLevel() < 13)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Gains an extra blast at levels 5, 9, 13"
			});
		}
		if (actor.getFlags().has("AgonizingBlast"))
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Agonizing Blast: Blasts gain " + this.getAgonizingBlast() + " damage. Every 10 resolve becomes 1 damage added"
			});
		}

		if (actor.getSkills().hasSkill("injury.missing_finger"))
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Finger of Death: Eldritch blast now has a 44% chance to drain enemies"
			});
		}

		if (actor.getFlags().has("InstinctiveBlast"))
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Instinctive Blast: When dodging a melee attack, retaliate with a free blast"
			});
		}

		if(actor.isArmedWithShield())
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Cannot be used with a shield"
			});
		}
		return ret;
	}

	function isUsable()
	{
		return (!this.Tactical.isActive() || this.skill.isUsable()) && !this.getContainer().getActor().isArmedWithShield();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local buff = this.getContainer().getActor().getFlags().has("AgonizingBlast") ? this.getAgonizingBlast() : 0;
			_properties.DamageRegularMin = 20 + buff;
			_properties.DamageRegularMax = 45 + buff;
			_properties.RangedSkill += 20;
			_properties.HitChanceAdditionalWithEachTile += -5;
			_properties.DamageArmorMult = 0.8;
		}
	}

	function getBlastCount()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return this.m.BlastCount;
		else
		{
			local count = 1;
			if (actor.getLevel() >= 5) count++;
			if (actor.getLevel() >= 9) count++;
			if (actor.getLevel() >= 13) count++;
			return count;
		}
	}

	function getAgonizingBlast()
	{
		return this.Math.round(this.getContainer().getActor().getCurrentProperties().getBravery() / 10.0);
	}

    function onUse( _user, _targetTile )
	{
		this.Sound.play("sounds/cultist/eldritch_charge.wav", 200.0, _user.getPos(), this.Math.rand(95, 105) * 0.01);
		this.Sound.play("sounds/cultist/eldritch_charge.wav", 200.0, _user.getPos(), this.Math.rand(95, 105) * 0.01);
		this.Sound.play("sounds/cultist/eldritch_charge.wav", 200.0, _user.getPos(), this.Math.rand(95, 105) * 0.01);

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.getContainer().setBusy(true);
			local tag = {
				Skill = this,
				User = _user,
				Target = _targetTile.getEntity()
			};

			local delay = 0;

			for (local i = 0; i < getBlastCount(); i++)
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.Delay + delay, this.onPerformAttack, tag);
				delay += 750;
			}


			if (!_user.isPlayerControlled() && _targetTile.getEntity().isPlayerControlled())
			{
				_user.getTile().addVisibilityForFaction(::Const.Faction.Player);
			}

			return true;
		}
		else
		{
			for (local i = 0; i < getBlastCount(); i++)
			{
				this.attackEntity(_user, _targetTile.getEntity());
			}
			return true;
		}
	}

	function onPerformAttack( _tag )
	{
		if (_tag.Target == null) return false;
		if (!_tag.Target.isAlive()) return false;
		_tag.Skill.getContainer().setBusy(false);
		this.Sound.play("sounds/cultist/eldritch_blast.wav", 200, _tag.User.getPos());
		this.Sound.play("sounds/cultist/eldritch_blast.wav", 200, _tag.User.getPos());
		this.Sound.play("sounds/cultist/eldritch_blast.wav", 200, _tag.User.getPos());

		// this.Tactical.getCamera().quake(this.createVec(0, -1.0), 6.0, 0.16, 0.35);
		for( local i = 0; i < ::Const.Tactical.BlastParticles.len(); i = ++i )
		{
			local effect = ::Const.Tactical.BlastParticles[i];
			this.Tactical.spawnParticleEffect(false, effect.Brushes, _tag.Target.getTile(), effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 0));
		}
		return _tag.Skill.attackEntity(_tag.User, _tag.Target);
	}

	function onMissed( _attacker, _skill )
	{
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("InstinctiveBlast")) return;
		if (actor.isArmedWithShield()) return;

		if (_skill == null || !_skill.isAttack() || _skill.isRanged() || _attacker == null || _attacker.getID() == actor.getID()) return;
		if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == actor.getID()) return;

		local weapon = _attacker.getMainhandItem();
		if (weapon == null || this.isValidCounterAttack(weapon))
		{
			local _targetTile = _attacker.getTile();

			this.Sound.play("sounds/cultist/eldritch_charge.wav", 200.0, actor.getPos(), this.Math.rand(95, 105) * 0.01);
			this.Sound.play("sounds/cultist/eldritch_charge.wav", 200.0, actor.getPos(), this.Math.rand(95, 105) * 0.01);
			this.Sound.play("sounds/cultist/eldritch_charge.wav", 200.0, actor.getPos(), this.Math.rand(95, 105) * 0.01);


			if (!actor.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
			{
				this.getContainer().setBusy(true);
				local tag = {
					Skill = this,
					User = actor,
					Target = _attacker,
				};

				::logInfo("Performing counter blast.");
				this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.Delay, this.onPerformAttack, tag);

				if (!actor.isPlayerControlled() && _attacker.isPlayerControlled())
					actor.getTile().addVisibilityForFaction(::Const.Faction.Player);
			}
			else this.attackEntity(actor, _attacker);
		}

	}

	function isValidCounterAttack(weapon)
	{
		return weapon.isWeaponType(::Const.Items.WeaponType.Polearm)
		|| weapon.isWeaponType(::Const.Items.WeaponType.Dagger)
		|| weapon.isWeaponType(::Const.Items.WeaponType.Spear)
		|| weapon.isWeaponType(::Const.Items.WeaponType.Axe)
		|| weapon.isWeaponType(::Const.Items.WeaponType.Cleaver)
		|| weapon.isWeaponType(::Const.Items.WeaponType.Dagger)
		|| weapon.isWeaponType(::Const.Items.WeaponType.Sword)
		|| weapon.isWeaponType(::Const.Items.WeaponType.Flail)
		|| weapon.isWeaponType(::Const.Items.WeaponType.Hammer)
		|| weapon.isWeaponType(::Const.Items.WeaponType.Mace)
		|| weapon.isWeaponType(::Const.Items.WeaponType.Staff);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local actor = this.getContainer().getActor();
			_targetEntity.getSkills().add(::new("scripts/skills/effects/staggered_effect"));
			if (this.Math.rand(1,100) <= 44)
				this.doKnockback( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor );
			if (actor.getSkills().hasSkill("injury.missing_finger") && this.Math.rand(1,100) <= 44)
			{
				local drained = _targetEntity.getSkills().getSkillByID("effects.drained_effect");
				if (drained == null) _targetEntity.getSkills().add(::new("scripts/skills/effects/drained_effect"));
				else drained.incrementTime();
			}
		}
	}

	function doKnockback( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local targetTile = _targetEntity.getTile();
		local user = this.getContainer().getActor();

		if (_targetEntity.getCurrentProperties().IsImmuneToKnockBackAndGrab || _targetEntity.getCurrentProperties().IsRooted) return false;

		local knockToTile = this.findTileToKnockBackTo(user.getTile(), targetTile);
		if (knockToTile == null) return;


		if (!user.isHiddenToPlayer() && (targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
		{
			this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(user) + " has knocked back " + ::Const.UI.getColorizedEntityName(_targetEntity));
		}

		local skills = _targetEntity.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");

		_targetEntity.setCurrentMovementType(::Const.Tactical.MovementType.Involuntary);
		local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - targetTile.Level) - 1) * ::Const.Combat.FallingDamage;
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

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		if (this.m.IsPull) return this.getPulledToTile(_userTile, _targetTile);

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

	function getPulledToTile( _userTile, _targetTile )
	{
		local dir = _targetTile.getDirectionTo(_userTile);

		if (_targetTile.hasNextTile(dir))
		{
			local tile = _targetTile.getNextTile(dir);

			if (tile.Level <= _userTile.Level && tile.IsEmpty)
			{
				return tile;
			}
		}

		dir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(dir))
		{
			local tile = _targetTile.getNextTile(dir);

			if (tile.getDistanceTo(_userTile) == 1 && tile.Level <= _userTile.Level && tile.IsEmpty)
			{
				return tile;
			}
		}

		dir = _targetTile.getDirectionTo(_userTile);
		dir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(dir))
		{
			local tile = _targetTile.getNextTile(dir);

			if (tile.getDistanceTo(_userTile) == 1 && tile.Level <= _userTile.Level && tile.IsEmpty)
			{
				return tile;
			}
		}

		return null;
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getSkills().hasSkill("injury.missing_hand")) return;
		if (!actor.isPlayerControlled()) return;
		this.getContainer().add(::new("scripts/skills/actives/cultist_eldritch_blast_toggle"));
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled()) return;
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.EldritchBlast) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_cultist_eldritch_blast"));
			agent.finalizeBehaviors();
		}
	}
});

::Const.ProjectileType.ELDRITCHBLAST <- ::Const.ProjectileType.COUNT;
::Const.ProjectileType.COUNT = ::Const.ProjectileType.COUNT + 1;

local decals = [];
::Const.ProjectileDecals.push(decals);
::Const.ProjectileSprite.push("projectile_blast");

::Const.Tactical.BlastParticles <- [
	{
		Delay = 0,
		Quantity = 250,
		LifeTimeQuantity = 250,
		SpawnRate = 512,
		Brushes = [
			"effect_fire_01",
			"effect_fire_02",
			"effect_fire_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("eb64f0ff"),
				ColorMax = this.createColor("eb64f0ff"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 500,
				VelocityMax = 600,
				DirectionMin = this.createVec(-1.0, 0.25),
				DirectionMax = this.createVec(1.0, 1.0),
				SpawnOffsetMin = this.createVec(-20, -60),
				SpawnOffsetMax = this.createVec(20, -20),
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("eb64f0ff"),
				ColorMax = this.createColor("eb64f0ff"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 500,
				VelocityMax = 600,
				DirectionMin = this.createVec(-1.0, 0.25),
				DirectionMax = this.createVec(1.0, 1.0),
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("52fc9cf0"),
				ColorMax = this.createColor("52fce0f0"),
				ScaleMin = 1.0,
				ScaleMax = 1.25,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 500,
				VelocityMax = 600,
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("eb64f0ff"),
				ColorMax = this.createColor("eb64f0ff"),
				ScaleMin = 1.15,
				ScaleMax = 1.4,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 500,
				VelocityMax = 600,
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			}
		]
	},
	{
		Delay = 0,
		Quantity = 80,
		LifeTimeQuantity = 80,
		SpawnRate = 512,
		Brushes = [
			"explosion_01",
			"explosion_01",
			"explosion_02"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("32fafa00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				DirectionMin = this.createVec(-1.0, 0.25),
				DirectionMax = this.createVec(1.0, 1.0),
				SpawnOffsetMin = this.createVec(-20, -60),
				SpawnOffsetMax = this.createVec(20, -20),
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("32fafaff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				DirectionMin = this.createVec(-1.0, 0.25),
				DirectionMax = this.createVec(1.0, 1.0),
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("39fa32f0"),
				ColorMax = this.createColor("fffffff0"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.3,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("00d88200"),
				ColorMax = this.createColor("00d88200"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			}
		]
	},
	{
		Delay = 0,
		Quantity = 12,
		LifeTimeQuantity = 12,
		SpawnRate = 512,
		Brushes = [
			"explosion_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				DirectionMin = this.createVec(-1.25, 0.25),
				DirectionMax = this.createVec(1.25, 0.25),
				SpawnOffsetMin = this.createVec(-10, -50),
				SpawnOffsetMax = this.createVec(10, -30),
				ForceMin = this.createVec(0, 10),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("ffffff30"),
				ColorMax = this.createColor("ffffff30"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				DirectionMin = this.createVec(-1.25, 0.25),
				DirectionMax = this.createVec(1.25, 0.25),
				ForceMin = this.createVec(0, 10),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("00d8d800"),
				ColorMax = this.createColor("00d8d800"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				ForceMin = this.createVec(0, 10),
				ForceMax = this.createVec(0, 10)
			}
		]
	}
];