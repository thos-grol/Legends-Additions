::mods_hookBaseClass("entity/tactical/actor", function (o)
{
	while(!("onDiscovered" in o)) o = o[o.SuperName];
	o.onDiscovered = function() { if (!this.isPlayerControlled()) this.setDirty(true);}
	
	while(!("onDamageReceived" in o)) o = o[o.SuperName];	
	o.onDamageReceived = function( _attacker, _skill, _hitInfo )
	{
		if (!this.isAlive() || !this.isPlacedOnMap())
		{
			return 0;
		}

		if (_hitInfo.DamageRegular == 0 && _hitInfo.DamageArmor == 0)
		{
			return 0;
		}

		if (typeof _attacker == "instance")
		{
			_attacker = _attacker.get();
		}

		if (_attacker != null && _attacker.isAlive() && _attacker.isPlayerControlled() && !this.isPlayerControlled())
		{
			this.setDiscovered(true);
			this.getTile().addVisibilityForFaction(::Const.Faction.Player);
			this.getTile().addVisibilityForCurrentEntity();
		}

		if (this.m.Skills.hasSkill("perk.steel_brow"))
		{
			_hitInfo.BodyDamageMult = 1.0;
		}

		local p = this.m.Skills.buildPropertiesForBeingHit(_attacker, _skill, _hitInfo);
		this.m.Items.onBeforeDamageReceived(_attacker, _skill, _hitInfo, p);
		local dmgMult = p.DamageReceivedTotalMult;

		if (_skill != null)
		{
			dmgMult = dmgMult * (_skill.isRanged() ? p.DamageReceivedRangedMult : p.DamageReceivedMeleeMult);
		}

		_hitInfo.DamageRegular -= p.DamageRegularReduction;
		_hitInfo.DamageArmor -= p.DamageArmorReduction;
		_hitInfo.DamageRegular *= p.DamageReceivedRegularMult * dmgMult;
		_hitInfo.DamageArmor *= p.DamageReceivedArmorMult * dmgMult;
		local armor = 0;
		local armorDamage = 0;

		if (_hitInfo.DamageDirect < 1.0)
		{
			armor = p.Armor[_hitInfo.BodyPart] * p.ArmorMult[_hitInfo.BodyPart];
			armorDamage = this.Math.min(armor, _hitInfo.DamageArmor);
			armor = armor - armorDamage;
			_hitInfo.DamageInflictedArmor = this.Math.max(0, armorDamage);
		}

		_hitInfo.DamageFatigue *= p.FatigueEffectMult;
		this.m.Fatigue = this.Math.min(this.getFatigueMax(), this.Math.round(this.m.Fatigue + _hitInfo.DamageFatigue * p.FatigueReceivedPerHitMult * this.m.CurrentProperties.FatigueLossOnAnyAttackMult));
		local damage = 0;
		damage = damage + this.Math.maxf(0.0, _hitInfo.DamageRegular * _hitInfo.DamageDirect * p.DamageReceivedDirectMult - armor * ::Const.Combat.ArmorDirectDamageMitigationMult);

		if (armor <= 0 || _hitInfo.DamageDirect >= 1.0)
		{
			damage = damage + this.Math.max(0, _hitInfo.DamageRegular * this.Math.maxf(0.0, 1.0 - _hitInfo.DamageDirect * p.DamageReceivedDirectMult) - armorDamage);
		}

		damage = damage * _hitInfo.BodyDamageMult;
		damage = this.Math.max(0, this.Math.max(this.Math.round(damage), this.Math.min(this.Math.round(_hitInfo.DamageMinimum), this.Math.round(_hitInfo.DamageMinimum * p.DamageReceivedTotalMult))));
		_hitInfo.DamageInflictedHitpoints = damage;

		local prev_hitpoints = this.m.Hitpoints;
		
		this.m.Skills.onDamageReceived(_attacker, _hitInfo.DamageInflictedHitpoints, _hitInfo.DamageInflictedArmor);

		if (armorDamage > 0 && !this.isHiddenToPlayer() && _hitInfo.IsPlayingArmorSound)
		{
			local armorHitSound = this.m.Items.getAppearance().ImpactSound[_hitInfo.BodyPart];

			if (armorHitSound.len() > 0)
			{
				this.Sound.play(armorHitSound[this.Math.rand(0, armorHitSound.len() - 1)], ::Const.Sound.Volume.ActorArmorHit, this.getPos());
			}

			if (damage < ::Const.Combat.PlayPainSoundMinDamage)
			{
				this.playSound(::Const.Sound.ActorEvent.NoDamageReceived, ::Const.Sound.Volume.Actor * this.m.SoundVolume[::Const.Sound.ActorEvent.NoDamageReceived] * this.m.SoundVolumeOverall);
			}
		}

		if (damage > 0)
		{
			if (!this.m.IsAbleToDie && damage >= this.m.Hitpoints)
			{
				this.m.Hitpoints = 1;
			}
			else
			{
				this.m.Hitpoints = this.Math.round(this.m.Hitpoints - damage);
			}
		}

		if (this.m.Hitpoints <= 0)
		{
			local lorekeeperPotionEffect = this.m.Skills.getSkillByID("effects.lorekeeper_potion");

			if (lorekeeperPotionEffect != null && (!lorekeeperPotionEffect.isSpent() || lorekeeperPotionEffect.getLastFrameUsed() == this.Time.getFrame()))
			{
				this.getSkills().removeByType(::Const.SkillType.DamageOverTime);
				this.m.Hitpoints = this.getHitpointsMax();
				lorekeeperPotionEffect.setSpent(true);
				this.Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(this) + " is reborn by the power of the Lorekeeper!");
			}
			else
			{
				local nineLivesSkill = this.m.Skills.getSkillByID("perk.nine_lives");

				if (nineLivesSkill != null && (!nineLivesSkill.isSpent() || nineLivesSkill.getLastFrameUsed() == this.Time.getFrame()))
				{
					this.getSkills().removeByType(::Const.SkillType.DamageOverTime);
					this.m.Hitpoints = this.Math.rand(11, 15);
					nineLivesSkill.setSpent(true);
					::Z.Log.nine_lives(this);
				}
			}
		}

		local fatalityType = ::Const.FatalityType.None;

		if (this.m.Hitpoints <= 0)
		{
			this.m.IsDying = true;

			if (_skill != null)
			{
				if (_skill.getChanceDecapitate() >= 100 || _hitInfo.BodyPart == ::Const.BodyPart.Head && this.Math.rand(1, 100) <= _skill.getChanceDecapitate() * _hitInfo.FatalityChanceMult)
				{
					fatalityType = ::Const.FatalityType.Decapitated;
				}
				else if (_skill.getChanceSmash() >= 100 || _hitInfo.BodyPart == ::Const.BodyPart.Head && this.Math.rand(1, 100) <= _skill.getChanceSmash() * _hitInfo.FatalityChanceMult)
				{
					fatalityType = ::Const.FatalityType.Smashed;
				}
				else if (_skill.getChanceDisembowel() >= 100 || _hitInfo.BodyPart == ::Const.BodyPart.Body && this.Math.rand(1, 100) <= _skill.getChanceDisembowel() * _hitInfo.FatalityChanceMult)
				{
					fatalityType = ::Const.FatalityType.Disemboweled;
				}
			}
		}

		if (_hitInfo.DamageDirect < 1.0)
		{
			local overflowDamage = _hitInfo.DamageArmor;

			if (this.m.BaseProperties.Armor[_hitInfo.BodyPart] != 0)
			{
				overflowDamage = overflowDamage - this.m.BaseProperties.Armor[_hitInfo.BodyPart] * this.m.BaseProperties.ArmorMult[_hitInfo.BodyPart];
				this.m.BaseProperties.Armor[_hitInfo.BodyPart] = this.Math.max(0, this.m.BaseProperties.Armor[_hitInfo.BodyPart] * this.m.BaseProperties.ArmorMult[_hitInfo.BodyPart] - _hitInfo.DamageArmor);
				this.Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(this) + "\'s armor is hit for [b]" + this.Math.floor(_hitInfo.DamageArmor) + "[/b] damage");
			}

			if (overflowDamage > 0)
			{
				this.m.Items.onDamageReceived(overflowDamage, fatalityType, _hitInfo.BodyPart == ::Const.BodyPart.Body ? ::Const.ItemSlot.Body : ::Const.ItemSlot.Head, _attacker);
			}
		}

		if (this.getFaction() == ::Const.Faction.Player && _attacker != null && _attacker.isAlive())
		{
			this.Tactical.getCamera().quake(_attacker, this, 5.0, 0.16, 0.3);
		}

		if (damage <= 0 && armorDamage >= 0)
		{
			if ((this.m.IsFlashingOnHit || this.getCurrentProperties().IsStunned || this.getCurrentProperties().IsRooted) && !this.isHiddenToPlayer() && _attacker != null && _attacker.isAlive())
			{
				local layers = this.m.ShakeLayers[_hitInfo.BodyPart];
				local recoverMult = 1.0;
				this.Tactical.getShaker().cancel(this);
				this.Tactical.getShaker().shake(this, _attacker.getTile(), this.m.IsShakingOnHit ? 2 : 3, ::Const.Combat.ShakeEffectArmorHitColor, ::Const.Combat.ShakeEffectArmorHitHighlight, ::Const.Combat.ShakeEffectArmorHitFactor, ::Const.Combat.ShakeEffectArmorSaturation, layers, recoverMult);
			}

			this.m.Skills.update();
			this.setDirty(true);
			return 0;
		}

		if (damage >= ::Const.Combat.SpawnBloodMinDamage)
		{
			this.spawnBloodDecals(this.getTile());
		}

		if (this.m.Hitpoints <= 0)
		{
			this.spawnBloodDecals(this.getTile());
			this.kill(_attacker, _skill, fatalityType);
		}
		else
		{
			if (damage >= ::Const.Combat.SpawnBloodEffectMinDamage)
			{
				local mult = this.Math.maxf(0.75, this.Math.minf(2.0, damage / this.getHitpointsMax() * 3.0));
				this.spawnBloodEffect(this.getTile(), mult);
			}

			if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode && _attacker != null && _attacker.getID() != this.getID())
			{
				local mult = damage / this.getHitpointsMax();

				if (mult >= 0.75)
				{
					this.Sound.play(::Const.Sound.ArenaBigHit[this.Math.rand(0, ::Const.Sound.ArenaBigHit.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
				}
				else if (mult >= 0.25 || this.Math.rand(1, 100) <= 20)
				{
					this.Sound.play(::Const.Sound.ArenaHit[this.Math.rand(0, ::Const.Sound.ArenaHit.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
				}
			}

			if (this.m.CurrentProperties.IsAffectedByInjuries && this.m.IsAbleToDie && damage >= ::Const.Combat.InjuryMinDamage && this.m.CurrentProperties.ThresholdToReceiveInjuryMult != 0 && _hitInfo.InjuryThresholdMult != 0 && _hitInfo.Injuries != null)
			{
				local potentialInjuries = [];
				local bonus = _hitInfo.BodyPart == ::Const.BodyPart.Head ? 1.25 : 1.0;

				foreach( inj in _hitInfo.Injuries )
				{
					if (inj.Threshold * _hitInfo.InjuryThresholdMult * ::Const.Combat.InjuryThresholdMult * this.m.CurrentProperties.ThresholdToReceiveInjuryMult * bonus <= damage / (this.getHitpointsMax() * 1.0))
					{
						if (!this.m.Skills.hasSkill(inj.ID) && this.m.ExcludedInjuries.find(inj.ID) == null)
						{
							potentialInjuries.push(inj.Script);
						}
					}
				}

				local appliedInjury = false;

				while (potentialInjuries.len() != 0)
				{
					local r = this.Math.rand(0, potentialInjuries.len() - 1);
					local injury = this.new("scripts/skills/" + potentialInjuries[r]);

					if (injury.isValid(this))
					{
						this.m.Skills.add(injury);

						if (this.isPlayerControlled() && this.isKindOf(this, "player"))
						{
							this.worsenMood(::Const.MoodChange.Injury, "Suffered an injury");

							if (("State" in this.World) && this.World.State != null && this.World.Ambitions.hasActiveAmbition() && this.World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_sacrifice")
							{
								this.World.Statistics.getFlags().increment("OathtakersInjuriesSuffered");
							}
						}

						if (this.isPlayerControlled() || !this.isHiddenToPlayer())
						{
							::Z.Log.damage_body(this, ::Const.Strings.BodyPartName[_hitInfo.BodyPart], this.m.Hitpoints, prev_hitpoints, damage);
							::Z.Log.suffer_injury(this, injury.getNameOnly());
						}

						appliedInjury = true;
						break;
					}
					else
					{
						potentialInjuries.remove(r);
					}
				}

				if (!appliedInjury)
				{
					if (damage > 0 && !this.isHiddenToPlayer())
					{
						::Z.Log.damage_body(this, ::Const.Strings.BodyPartName[_hitInfo.BodyPart], this.m.Hitpoints, prev_hitpoints, damage);
					}
				}
			}
			else if (damage > 0 && !this.isHiddenToPlayer())
			{
				::Z.Log.damage_body(this, ::Const.Strings.BodyPartName[_hitInfo.BodyPart], this.m.Hitpoints, prev_hitpoints, damage);
			}

			if (this.m.MoraleState != ::Const.MoraleState.Ignore && damage >= ::Const.Morale.OnHitMinDamage && this.getCurrentProperties().IsAffectedByLosingHitpoints)
			{
				if (!this.isPlayerControlled() || !this.m.Skills.hasSkill("effects.berserker_mushrooms"))
				{
					this.checkMorale(-1, ::Const.Morale.OnHitBaseDifficulty * (1.0 - this.getHitpoints() / this.getHitpointsMax()) - (_attacker != null && _attacker.getID() != this.getID() ? _attacker.getCurrentProperties().ThreatOnHit : 0), ::Const.MoraleCheckType.Default, "", true);
				}
			}

			this.m.Skills.onAfterDamageReceived();

			if (damage >= ::Const.Combat.PlayPainSoundMinDamage && this.m.Sound[::Const.Sound.ActorEvent.DamageReceived].len() > 0)
			{
				local volume = 1.0;

				if (damage < ::Const.Combat.PlayPainVolumeMaxDamage)
				{
					volume = damage / ::Const.Combat.PlayPainVolumeMaxDamage;
				}

				this.playSound(::Const.Sound.ActorEvent.DamageReceived, ::Const.Sound.Volume.Actor * this.m.SoundVolume[::Const.Sound.ActorEvent.DamageReceived] * this.m.SoundVolumeOverall * volume, this.m.SoundPitch);
			}

			this.m.Skills.update();
			this.onUpdateInjuryLayer();

			if ((this.m.IsFlashingOnHit || this.getCurrentProperties().IsStunned || this.getCurrentProperties().IsRooted) && !this.isHiddenToPlayer() && _attacker != null && _attacker.isAlive())
			{
				local layers = this.m.ShakeLayers[_hitInfo.BodyPart];
				local recoverMult = this.Math.minf(1.5, this.Math.maxf(1.0, damage * 2.0 / this.getHitpointsMax()));
				this.Tactical.getShaker().cancel(this);
				this.Tactical.getShaker().shake(this, _attacker.getTile(), this.m.IsShakingOnHit ? 2 : 3, ::Const.Combat.ShakeEffectHitpointsHitColor, ::Const.Combat.ShakeEffectHitpointsHitHighlight, ::Const.Combat.ShakeEffectHitpointsHitFactor, ::Const.Combat.ShakeEffectHitpointsSaturation, layers, recoverMult);
			}

			this.setDirty(true);
		}

		return damage;
	}

	while(!("kill" in o)) o = o[o.SuperName];
	o.kill <- function ( _killer = null, _skill = null, _fatalityType = ::Const.FatalityType.None, _silent = false )
	{
		if (!this.isAlive())
		{
			return;
		}

		if (_killer != null && !_killer.isAlive())
		{
			_killer = null;
		}

		if (this.m.IsMiniboss && !this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("GiveMeThat", 1, 1);

			if (!this.Tactical.State.isScenarioMode() && this.World.Retinue.hasFollower("follower.bounty_hunter"))
			{
				this.World.Retinue.getFollower("follower.bounty_hunter").onChampionKilled(this);
			}
		}

		this.m.IsDying = true;
		local isReallyDead = this.isReallyKilled(_fatalityType);

		if (!isReallyDead)
		{
			this.TherianthropeInfection(_killer);
			_fatalityType = ::Const.FatalityType.Unconscious;
			this.logDebug(this.getName() + " is unconscious.");
		}
		else
		{
			this.logDebug(this.getName() + " has died.");
		}

		if (!_silent)
		{
			this.playSound(::Const.Sound.ActorEvent.Death, ::Const.Sound.Volume.Actor * this.m.SoundVolume[::Const.Sound.ActorEvent.Death] * this.m.SoundVolumeOverall, this.m.SoundPitch);
		}

		local myTile = this.isPlacedOnMap() ? this.getTile() : null;
		local tile = this.findTileToSpawnCorpse(_killer);
		this.m.Skills.onDeath(_fatalityType);
		this.onDeath(_killer, _skill, tile, _fatalityType);

		if (!this.Tactical.State.isFleeing() && _killer != null)
		{
			_killer.onActorKilled(this, tile, _skill);
		}

		if (_killer != null && !_killer.isHiddenToPlayer() && !this.isHiddenToPlayer())
		{
			if (isReallyDead)
			{
				if (_killer.getID() != this.getID())
				{
					::Z.Log.kill(this);
				}
				else
				{
					::Z.Log.kill(this);
				}
			}
			else if (_killer.getID() != this.getID())
			{
				::Z.Log.kill(this);
			}
			else
			{
				::Z.Log.kill(this);
			}
		}

		if (!this.Tactical.State.isFleeing() && myTile != null)
		{
			local actors = this.Tactical.Entities.getAllInstances();

			foreach( i in actors )
			{
				foreach( a in i )
				{
					if (a.getID() != this.getID())
					{
						a.onOtherActorDeath(_killer, this, _skill);
					}
				}
			}
		}

		if (!this.isHiddenToPlayer())
		{
			if (tile != null)
			{
				if (_fatalityType == ::Const.FatalityType.Decapitated)
				{
					this.spawnDecapitateSplatters(tile, 1.0 * this.m.DecapitateBloodAmount);
				}
				else if (_fatalityType == ::Const.FatalityType.Smashed && (this.getFlags().has("human") || this.getFlags().has("zombie_minion")))
				{
					this.spawnSmashSplatters(tile, 1.0);
				}
				else
				{
					this.spawnBloodSplatters(tile, ::Const.Combat.BloodSplattersAtDeathMult * this.m.DeathBloodAmount);

					if (!this.getTile().isSameTileAs(tile))
					{
						this.spawnBloodSplatters(this.getTile(), ::Const.Combat.BloodSplattersAtOriginalPosMult);
					}
				}
			}
			else if (myTile != null)
			{
				this.spawnBloodSplatters(this.getTile(), ::Const.Combat.BloodSplattersAtDeathMult * this.m.DeathBloodAmount);
			}
		}

		if (tile != null)
		{
			this.spawnBloodPool(tile, this.Math.rand(::Const.Combat.BloodPoolsAtDeathMin, ::Const.Combat.BloodPoolsAtDeathMax));
		}

		this.m.IsTurnDone = true;
		this.m.IsAlive = false;

		if (this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null && !this.m.WorldTroop.Party.isNull())
		{
			this.m.WorldTroop.Party.removeTroop(this.m.WorldTroop);
		}

		if (!this.Tactical.State.isScenarioMode())
		{
			this.World.Contracts.onActorKilled(this, _killer, this.Tactical.State.getStrategicProperties().CombatID);
			this.World.Events.onActorKilled(this, _killer, this.Tactical.State.getStrategicProperties().CombatID);
			this.World.Assets.getOrigin().onActorKilled(this, _killer, this.Tactical.State.getStrategicProperties().CombatID);

			if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode)
			{
				if (_killer == null || _killer.getID() == this.getID())
				{
					this.Sound.play(::Const.Sound.ArenaFlee[this.Math.rand(0, ::Const.Sound.ArenaFlee.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
				}
				else
				{
					this.Sound.play(::Const.Sound.ArenaKill[this.Math.rand(0, ::Const.Sound.ArenaKill.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
				}
			}
		}

		if (this.isPlayerControlled())
		{
			if (isReallyDead)
			{
				if (this.isGuest())
				{
					this.World.getGuestRoster().remove(this);
				}
				else
				{
					this.World.getPlayerRoster().remove(this);
				}
			}

			if (this.Tactical.Entities.getHostilesNum() != 0)
			{
				this.Tactical.Entities.setLastCombatResult(::Const.Tactical.CombatResult.PlayerDestroyed);
			}
			else
			{
				this.Tactical.Entities.setLastCombatResult(::Const.Tactical.CombatResult.EnemyDestroyed);
			}
		}
		else
		{
			if (!this.Tactical.State.isAutoRetreat())
			{
				this.Tactical.Entities.setLastCombatResult(::Const.Tactical.CombatResult.EnemyDestroyed);
			}

			if (_killer != null && _killer.isPlayerControlled() && !this.Tactical.State.isScenarioMode() && this.World.FactionManager.getFaction(this.getFaction()) != null && !this.World.FactionManager.getFaction(this.getFaction()).isTemporaryEnemy())
			{
				this.World.FactionManager.getFaction(this.getFaction()).addPlayerRelation(::Const.World.Assets.RelationUnitKilled);
			}
		}

		if (isReallyDead)
		{
			if (!this.Tactical.State.isScenarioMode() && this.isPlayerControlled() && !this.isGuest())
			{
				local roster = this.World.getPlayerRoster().getAll();

				foreach( bro in roster )
				{
					if (bro.isAlive() && !bro.isDying() && bro.getCurrentProperties().IsAffectedByDyingAllies)
					{
						if (this.World.Assets.getOrigin().getID() != "scenario.manhunters" || this.getBackground().getID() != "background.slave")
						{
							bro.worsenMood(::Const.MoodChange.BrotherDied, this.getName() + " died in battle");
						}
					}
				}
			}

			this.die();
		}
		else
		{
			this.removeFromMap();
		}

		if (this.m.Items != null)
		{
			this.m.Items.onActorDied(tile);

			if (isReallyDead)
			{
				this.m.Items.setActor(null);
			}
		}

		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.getFaction() == ::Const.Faction.PlayerAnimals && _skill != null && _skill.getID() == "actives.wardog_bite")
		{
			this.updateAchievement("WhoLetTheDogsOut", 1, 1);
		}

		this.onAfterDeath(myTile);
	};

	while(!("changeMorale" in o)) o = o[o.SuperName];
	o.changeMorale <- function ( _change, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		local oldMoraleState = this.m.MoraleState;
		this.m.MoraleState = _change;
		this.m.FleeingRounds = 0;

		if (this.m.MoraleState == ::Const.MoraleState.Confident && oldMoraleState != ::Const.MoraleState.Confident && ("State" in this.World) && this.World.State != null && this.World.Ambitions.hasActiveAmbition() && this.World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_camaraderie")
		{
			this.World.Statistics.getFlags().increment("OathtakersBrosConfident");
		}

		if (oldMoraleState == ::Const.MoraleState.Fleeing && this.m.IsActingEachTurn)
		{
			this.setZoneOfControl(this.getTile(), this.hasZoneOfControl());

			if (this.isPlayerControlled() || !this.isHiddenToPlayer())
			{
				if (_noNewLine)
				{
					::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(this) + " has rallied");
				}
				else
				{
					::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(this) + " has rallied");
				}
			}
		}
		else if (this.m.MoraleState == ::Const.MoraleState.Fleeing)
		{
			this.setZoneOfControl(this.getTile(), this.hasZoneOfControl());
			this.m.Skills.removeByID("effects.shieldwall");
			this.m.Skills.removeByID("effects.spearwall");
			this.m.Skills.removeByID("effects.riposte");
			this.m.Skills.removeByID("effects.return_favor");
			this.m.Skills.removeByID("effects.indomitable");
		}

		local morale = this.getSprite("morale");

		if (::Const.MoraleStateBrush[this.m.MoraleState].len() != 0 && morale != null)
		{
			if (this.m.MoraleState == ::Const.MoraleState.Confident)
			{
				morale.setBrush(this.m.ConfidentMoraleBrush);
			}
			else
			{
				morale.setBrush(::Const.MoraleStateBrush[this.m.MoraleState]);
			}

			morale.Visible = true;
		}
		else
		{
			morale.Visible = false;
		}

		if (this.isPlayerControlled() || !this.isHiddenToPlayer())
		{
			if (_noNewLine)
			{
				::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(this) + ::Const.MoraleStateEvent[this.m.MoraleState]);
			}
			else
			{
				::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(this) + ::Const.MoraleStateEvent[this.m.MoraleState]);
			}

			if (_showIconBeforeMoraleIcon != "")
			{
				this.Tactical.spawnIconEffect(_showIconBeforeMoraleIcon, this.getTile(), ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
			}

			if (_change > 0)
			{
				this.Tactical.spawnIconEffect(::Const.Morale.MoraleUpIcon, this.getTile(), ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
			}
			else
			{
				this.Tactical.spawnIconEffect(::Const.Morale.MoraleDownIcon, this.getTile(), ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
			}
		}

		this.m.Skills.update();
		this.setDirty(true);

		if (this.m.MoraleState == ::Const.MoraleState.Fleeing && this.Tactical.TurnSequenceBar.getActiveEntity() != this)
		{
			this.Tactical.TurnSequenceBar.pushEntityBack(this.getID());
		}

		if (this.m.MoraleState == ::Const.MoraleState.Fleeing)
		{
			local actors = this.Tactical.Entities.getInstancesOfFaction(this.getFaction());

			if (actors != null)
			{
				foreach( a in actors )
				{
					if (a.getID() != this.getID())
					{
						a.onOtherActorFleeing(this);
					}
				}
			}
		}
	};

	while(!("setMoraleState" in o)) o = o[o.SuperName];
	o.setMoraleState = function ( _m )
	{
		if (this.m.Skills.hasSkill("effects.ancient_priest_potion")) return;
		if (this.m.Skills.hasSkill("trait.boss_fearless") && this.getHitpointsPct() > 0.25) return;
		if (this.m.MoraleState == _m) return;
		

		if (_m == ::Const.MoraleState.Fleeing)
		{
			this.m.Skills.removeByID("effects.shieldwall");
			this.m.Skills.removeByID("effects.spearwall");
			this.m.Skills.removeByID("effects.riposte");
			this.m.Skills.removeByID("effects.return_favor");
			this.m.Skills.removeByID("effects.indomitable");
		}

		this.m.MoraleState = _m;
		local morale = this.getSprite("morale");

		if (::Const.MoraleStateBrush[this.m.MoraleState].len() != 0)
		{
			if (this.m.MoraleState == ::Const.MoraleState.Confident)
			{
				morale.setBrush(this.m.ConfidentMoraleBrush);
			}
			else
			{
				morale.setBrush(::Const.MoraleStateBrush[this.m.MoraleState]);
			}

			morale.Visible = true;
		}
		else
		{
			morale.Visible = false;
		}

		this.m.Skills.update();
	}
});