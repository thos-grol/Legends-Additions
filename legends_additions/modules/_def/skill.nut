::mods_hookBaseClass("skills/skill", function (o)
{
	while(!("attackEntity" in o)) o = o[o.SuperName];
	o.attackEntity = function( _user, _targetEntity, _allowDiversion = true )
	{
		if (_targetEntity.isRock())
		{
			if (_user.getSkills().hasSkill("perk.legend_specialist_pickaxe_damage"))
			{helper_log_skill
				local r = this.Math.rand(0, 99);

				if (r == 99)
				{
					local loot = this.new("scripts/items/trade/uncut_gems_item");
					loot.drop(_targetEntity().getTile());
				}
				else if (r <= 5)
				{
					local loot = this.new("scripts/items/trade/salt_item");
					loot.drop(_targetEntity().getTile());
				}
				else if (r <= 15 && r > 5)
				{
					local loot = this.new("scripts/items/trade/peat_bricks_item");
					loot.drop(_targetEntity().getTile());
				}
			}

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.SoundOnHitDelay, this.onPlayHitSound.bindenv(this), {
					Sound = this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)],
					Pos = _targetEntity.getPos()
				});
			}

			local tile = _targetEntity.getTile();
			local x = tile.X;
			local y = tile.Y;
			this.Tactical.getTile(x, y).removeObject();
			return true;
		}

		if (_targetEntity.isSticks())
		{
			local r = this.Math.rand(0, 4);

			if (r == 1 && _user.getSkills().hasSkill("perk.legend_specialist_woodaxe_damage"))
			{
				local loot = this.new("scripts/items/trade/legend_raw_wood_item");
				loot.drop(_targetEntity.getTile());
			}

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.SoundOnHitDelay, this.onPlayHitSound.bindenv(this), {
					Sound = this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)],
					Pos = _targetEntity.getPos()
				});
			}

			local tile = _targetEntity.getTile();
			local x = tile.X;
			local y = tile.Y;
			this.Tactical.getTile(x, y).removeObject();
			return true;
		}

		if (_targetEntity.isSupplies())
		{
			local r = this.Math.rand(1, 100);

			if (r == 1)
			{
				local loot = this.new("scripts/items/supplies/ammo_small_item");
				loot.drop(_targetEntity.getTile());
			}

			if (r == 2)
			{
				local loot = this.new("scripts/items/supplies/armor_parts_small_item");
				loot.drop(_targetEntity.getTile());
			}

			if (r == 3)
			{
				local loot = this.new("scripts/items/supplies/medicine_small_item");
				loot.drop(_targetEntity.getTile());
			}

			if (r >= 4 && r < 6)
			{
				local loot = this.new("scripts/items/supplies/ground_grains_item");
				loot.drop(_targetEntity.getTile());
			}

			if (r >= 7 && r < 9)
			{
				if (this.Math.rand(1, 8) == 8)
				{
					local loot = this.new("scripts/items/supplies/legend_cooking_spices_item");
					loot.drop(_targetEntity.getTile());
				}
			}

			if (r == 10)
			{
				local loot = this.new("scripts/items/supplies/legend_fresh_fruit_item");
				loot.drop(_targetEntity.getTile());
			}

			if (r == 11)
			{
				local loot = this.new("scripts/items/supplies/strange_meat_item");
				loot.drop(_targetEntity.getTile());
			}

			if (r == 12)
			{
				local loot = this.new("scripts/items/supplies/legend_human_parts");
				loot.drop(_targetEntity.getTile());
			}

			if (r == 13)
			{
				local loot = this.new("scripts/items/supplies/legend_fresh_meat_item");
				loot.drop(_targetEntity.getTile());
			}

			if (r == 14)
			{
				local loot = this.new("scripts/items/supplies/beer_item");
				loot.drop(_targetEntity.getTile());
			}

			if (r == 15)
			{
				local loot = this.new("scripts/items/supplies/bandage_item");
				loot.drop(_targetEntity.getTile());
			}

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.SoundOnHitDelay, this.onPlayHitSound.bindenv(this), {
					Sound = this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)],
					Pos = _targetEntity.getPos()
				});
			}

			local tile = _targetEntity.getTile();
			local x = tile.X;
			local y = tile.Y;
			this.Tactical.getTile(x, y).removeObject();
			return false;
		}

		if (_targetEntity.isTree())
		{
			if (this.m.SoundOnHit.len() != 0)
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.SoundOnHitDelay, this.onPlayHitSound.bindenv(this), {
					Sound = this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)],
					Pos = _targetEntity.getPos()
				});
			}

			local tile = _targetEntity.getTile();
			local x = tile.X;
			local y = tile.Y;
			this.Tactical.getTile(x, y).removeObject();
			this.Tactical.getTile(x, y).spawnObject("entity/tactical/objects/tree_sticks");
			return true;
		}

		if (_targetEntity.isBush())
		{
			local r = this.Math.rand(0, 99);

			if (r <= 25 && _user.getSkills().hasSkill("perk.legend_specialist_sickle_damage"))
			{
				local loot = this.new("scripts/items/supplies/roots_and_berries_item");
				loot.drop(_targetEntity.getTile());
			}

			if (r == 99 && _user.getSkills().hasSkill("perk.legend_specialist_sickle_damage"))
			{
				local loot = this.new("scripts/items/misc/mysterious_herbs_item");
				loot.drop(_targetEntity.getTile());
			}

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.SoundOnHitDelay, this.onPlayHitSound.bindenv(this), {
					Sound = this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)],
					Pos = _targetEntity.getPos()
				});
			}

			local tile = _targetEntity.getTile();
			local x = tile.X;
			local y = tile.Y;
			this.Tactical.getTile(x, y).removeObject();
			return false;
		}

		if (_targetEntity != null && !_targetEntity.isAlive())
		{
			return false;
		}

		local properties = this.m.Container.buildPropertiesForUse(this, _targetEntity);
		local userTile = _user.getTile();
		local astray = false;

		if (_allowDiversion && this.m.IsRanged && userTile.getDistanceTo(_targetEntity.getTile()) > 1)
		{
			local blockedTiles = ::Const.Tactical.Common.getBlockedTiles(userTile, _targetEntity.getTile(), _user.getFaction());

			if (blockedTiles.len() != 0 && this.Math.rand(1, 100) <= this.Math.ceil(::Const.Combat.RangedAttackBlockedChance * properties.RangedAttackBlockedChanceMult * 100))
			{
				_allowDiversion = false;
				astray = true;
				_targetEntity = blockedTiles[this.Math.rand(0, blockedTiles.len() - 1)].getEntity();
			}
		}

		if (!_targetEntity.isAttackable())
		{
			if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
			{
				local flip = !this.m.IsProjectileRotated && _targetEntity.getPos().X > _user.getPos().X;

				if (_user.getTile().getDistanceTo(_targetEntity.getTile()) >= ::Const.Combat.SpawnProjectileMinDist)
				{
					this.Tactical.spawnProjectileEffect(::Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetEntity.getTile(), 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
				}
			}

			return false;
		}

		local defenderProperties = _targetEntity.getSkills().buildPropertiesForDefense(_user, this);
		local defense = _targetEntity.getDefense(_user, this, defenderProperties);
		local levelDifference = _targetEntity.getTile().Level - _user.getTile().Level;
		local distanceToTarget = _user.getTile().getDistanceTo(_targetEntity.getTile());
		local toHit = 0;
		local skill = this.m.IsRanged ? properties.RangedSkill * properties.RangedSkillMult : properties.MeleeSkill * properties.MeleeSkillMult;
		toHit = toHit + skill;
		toHit = toHit - defense;

		if (this.m.IsRanged)
		{
			toHit = toHit + (distanceToTarget - this.m.MinRange) * properties.HitChanceAdditionalWithEachTile * properties.HitChanceWithEachTileMult;
		}

		if (levelDifference < 0)
		{
			toHit = toHit + ::Const.Combat.LevelDifferenceToHitBonus;
		}
		else
		{
			toHit = toHit + ::Const.Combat.LevelDifferenceToHitMalus * levelDifference;
		}

		local shieldBonus = 0;
		local shield = _targetEntity.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		if (shield != null && shield.isItemType(::Const.Items.ItemType.Shield))
		{
			shieldBonus = (this.m.IsRanged ? shield.getRangedDefense() : shield.getMeleeDefense());

			if (!this.m.IsShieldRelevant)
			{
				toHit = toHit + shieldBonus;
			}

			if (_targetEntity.getSkills().hasSkill("effects.shieldwall"))
			{
				if (!this.m.IsShieldwallRelevant)
				{
					toHit = toHit + shieldBonus;
				}

				shieldBonus = shieldBonus * 2;
			}
		}

		toHit = toHit * properties.TotalAttackToHitMult;
		toHit = toHit + this.Math.max(0, 100 - toHit) * (1.0 - defenderProperties.TotalDefenseToHitMult);

		if (this.m.IsRanged && !_allowDiversion && this.m.IsShowingProjectile)
		{
			toHit = toHit - 15;
			properties.DamageTotalMult *= 0.75;
		}

		if (defense > -100 && skill > -100)
		{
			toHit = this.Math.max(5, this.Math.min(95, toHit));
		}

		_targetEntity.onAttacked(_user);

		if (this.m.IsDoingAttackMove && !_user.isHiddenToPlayer() && !_targetEntity.isHiddenToPlayer())
		{
			this.Tactical.getShaker().cancel(_user);

			if (this.m.IsDoingForwardMove)
			{
				this.Tactical.getShaker().shake(_user, _targetEntity.getTile(), 5);
			}
			else
			{
				local otherDir = _targetEntity.getTile().getDirectionTo(_user.getTile());

				if (_user.getTile().hasNextTile(otherDir))
				{
					this.Tactical.getShaker().shake(_user, _user.getTile().getNextTile(otherDir), 6);
				}
			}
		}

		if (!_targetEntity.isAbleToDie() && _targetEntity.getHitpoints() == 1)
		{
			toHit = 0;
		}

		if (!this.isUsingHitchance())
		{
			toHit = 100;
		}

		//perfectionist hitchance changes
        local r = this.Math.rand(_targetEntity.getSkills().hasSkill("perk.legend_perfect_focus") ? 6 : 1, _user.getSkills().hasSkill("perk.legend_perfect_focus") ? 95 : 100);

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == 0)
		{
			if (_user.isPlayerControlled())
			{
				r = this.Math.max(1, r - 5);
			}
			else if (_targetEntity.isPlayerControlled())
			{
				r = this.Math.min(100, r + 5);
			}
		}

		local isHit = r <= toHit;

		if (!_user.isHiddenToPlayer() && !_targetEntity.isHiddenToPlayer())
		{
			local rolled = r;
			this.Tactical.EventLog.log_newline();

			if (astray)
			{
				if (this.isUsingHitchance())
				{
					if (isHit)
					{
						::Z.Log.skill(_user, _targetEntity, getName(), rolled, toHit, "ASTRAY][HIT", false);
					}
					else
					{
						::Z.Log.skill(_user, _targetEntity, getName(), rolled, toHit, "ASTRAY][MISS", false);
					}
				}
				else
				{
					::Z.Log.skill(_user, _targetEntity, getName(), rolled, toHit, "ASTRAY][HIT", false, false);
				}
			}
			else if (this.isUsingHitchance())
			{
				if (isHit)
				{
					::Z.Log.skill(_user, _targetEntity, getName(), rolled, toHit, "");
				}
				else
				{
					::Z.Log.skill(_user, _targetEntity, getName(), rolled, toHit, "", false);
				}
			}
			else
			{
				::Z.Log.skill(_user, _targetEntity, getName(), rolled, toHit, "", true, false);
			}
		}

		local roll_2 = this.Math.rand(1, 100);
		if (isHit && roll_2 <= _targetEntity.getCurrentProperties().RerollDefenseChance)
		{
			r = this.Math.rand(1, 100);
			isHit = r <= toHit;

			if (!isHit)
			{
				::Z.Log.skill(_user, null, r, toHit, "REROLL (" + roll_2 + " vs " + _targetEntity.getCurrentProperties().RerollDefenseChance + ")][DODGE");
			}
			else
			{
				::Z.Log.skill(_user, null, r, toHit, "REROLL (" + roll_2 + " vs " + _targetEntity.getCurrentProperties().RerollDefenseChance + ")][FAIL", false);
			}
		}

		if (isHit)
		{
			this.getContainer().setBusy(true);
			local info = {
				Skill = this,
				Container = this.getContainer(),
				User = _user,
				TargetEntity = _targetEntity,
				Properties = properties,
				DistanceToTarget = distanceToTarget
			};

			if (this.m.IsShowingProjectile && this.m.ProjectileType != 0 && _user.getTile().getDistanceTo(_targetEntity.getTile()) >= ::Const.Combat.SpawnProjectileMinDist && (!_user.isHiddenToPlayer() || !_targetEntity.isHiddenToPlayer()))
			{
				local flip = !this.m.IsProjectileRotated && _targetEntity.getPos().X > _user.getPos().X;
				local time = this.Tactical.spawnProjectileEffect(::Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetEntity.getTile(), 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
				this.Time.scheduleEvent(this.TimeUnit.Virtual, time, this.onScheduledTargetHit, info);

				if (this.m.SoundOnHit.len() != 0)
				{
					this.Time.scheduleEvent(this.TimeUnit.Virtual, time + this.m.SoundOnHitDelay, this.onPlayHitSound.bindenv(this), {
						Sound = this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)],
						Pos = _targetEntity.getPos()
					});
				}
			}
			else
			{
				if (this.m.SoundOnHit.len() != 0)
				{
					this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, _targetEntity.getPos());
				}

				if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode && toHit <= 15)
				{
					this.Sound.play(::Const.Sound.ArenaShock[this.Math.rand(0, ::Const.Sound.ArenaShock.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
				}

				this.onScheduledTargetHit(info);
			}

			return true;
		}
		else
		{
			local distanceToTarget = _user.getTile().getDistanceTo(_targetEntity.getTile());
			_targetEntity.onMissed(_user, this, this.m.IsShieldRelevant && shield != null && r <= toHit + shieldBonus * 2);
			this.m.Container.onTargetMissed(this, _targetEntity);
			local prohibitDiversion = false;

			if (_allowDiversion && this.m.IsRanged && !_user.isPlayerControlled() && this.Math.rand(1, 100) <= 25 && distanceToTarget > 2)
			{
				local targetTile = _targetEntity.getTile();

				for( local i = 0; i < ::Const.Direction.COUNT; i = i )
				{
					if (!targetTile.hasNextTile(i))
					{
					}
					else
					{
						local tile = targetTile.getNextTile(i);

						if (tile.IsEmpty)
						{
						}
						else if (tile.IsOccupiedByActor && tile.getEntity().isAlliedWith(_user))
						{
							prohibitDiversion = true;
							break;
						}
					}

					i = ++i;
				}
			}

			if (_allowDiversion && this.m.IsRanged && !(this.m.IsShieldRelevant && shield != null && r <= toHit + shieldBonus * 2) && !prohibitDiversion && distanceToTarget > 2)
			{
				this.divertAttack(_user, _targetEntity);
			}
			else if (this.m.IsShieldRelevant && shield != null && r <= toHit + shieldBonus * 2)
			{
				local info = {
					Skill = this,
					User = _user,
					TargetEntity = _targetEntity,
					Shield = shield
				};

				if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
				{
					local divertTile = _targetEntity.getTile();
					local flip = !this.m.IsProjectileRotated && _targetEntity.getPos().X > _user.getPos().X;
					local time = 0;

					if (_user.getTile().getDistanceTo(divertTile) >= ::Const.Combat.SpawnProjectileMinDist)
					{
						time = this.Tactical.spawnProjectileEffect(::Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), divertTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
					}

					this.Time.scheduleEvent(this.TimeUnit.Virtual, time, this.onShieldHit, info);
				}
				else
				{
					this.onShieldHit(info);
				}
			}
			else
			{
				if (this.m.SoundOnMiss.len() != 0)
				{
					this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, _targetEntity.getPos());
				}

				if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
				{
					local divertTile = _targetEntity.getTile();
					local flip = !this.m.IsProjectileRotated && _targetEntity.getPos().X > _user.getPos().X;

					if (_user.getTile().getDistanceTo(divertTile) >= ::Const.Combat.SpawnProjectileMinDist)
					{
						this.Tactical.spawnProjectileEffect(::Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), divertTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
					}
				}

				if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode)
				{
					if (toHit >= 90 || _targetEntity.getHitpointsPct() <= 0.1)
					{
						this.Sound.play(::Const.Sound.ArenaMiss[this.Math.rand(0, ::Const.Sound.ArenaBigMiss.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
					}
					else if (this.Math.rand(1, 100) <= 20)
					{
						this.Sound.play(::Const.Sound.ArenaMiss[this.Math.rand(0, ::Const.Sound.ArenaMiss.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
					}
				}
			}

			return false;
		}
	}
});

::mods_hookExactClass("skills/skill", function (o)
{
	o.onShieldHit = function( _info )
	{
		local shield = _info.Shield;
		local user = _info.User;
		local targetEntity = _info.TargetEntity;

		if (_info.Skill.m.SoundOnHitShield.len() != 0)
		{
			this.Sound.play(_info.Skill.m.SoundOnHitShield[this.Math.rand(0, _info.Skill.m.SoundOnHitShield.len() - 1)], this.Const.Sound.Volume.Skill * this.m.SoundVolume, user.getPos());
		}

		shield.applyShieldDamage(this.Const.Combat.BasicShieldDamage, _info.Skill.m.SoundOnHitShield.len() == 0);

		if (shield.getCondition() == 0)
		{
			if (!user.isHiddenToPlayer()) this.Tactical.EventLog.logIn(this.Const.UI.getColorizedEntityName(targetEntity) + "\'s shield has destroyed ");
		}
		else
		{
			if (!this.Tactical.getNavigator().isTravelling(targetEntity))
			{
				this.Tactical.getShaker().shake(targetEntity, user.getTile(), 2, this.Const.Combat.ShakeEffectSplitShieldColor, this.Const.Combat.ShakeEffectSplitShieldHighlight, this.Const.Combat.ShakeEffectSplitShieldFactor, 1.0, [
					"shield_icon"
				], 1.0);
			}
		}

		_info.TargetEntity.getItems().onShieldHit(_info.User, this);
	}

	o.getHitchance = function( _targetEntity )
	{
		if (!_targetEntity.isAttackable() && !_targetEntity.isRock() && !_targetEntity.isTree() && !_targetEntity.isBush() && !_targetEntity.isSupplies())
		{
			return 0;
		}

		local user = this.m.Container.getActor();
		local properties = this.factoringOffhand(this.m.Container.buildPropertiesForUse(this, _targetEntity));

		if (!this.isUsingHitchance())
		{
			return 100;
		}

		local allowDiversion = this.m.IsRanged && this.m.MaxRangeBonus > 1;
		local defenderProperties = _targetEntity.getSkills().buildPropertiesForDefense(user, this);
		local skill = this.m.IsRanged ? properties.RangedSkill * properties.RangedSkillMult : properties.MeleeSkill * properties.MeleeSkillMult;
		local defense = _targetEntity.getDefense(user, this, defenderProperties);
		local levelDifference = _targetEntity.getTile().Level - user.getTile().Level;
		local distanceToTarget = user.getTile().getDistanceTo(_targetEntity.getTile());
		local toHit = skill - defense;

		if (this.m.IsRanged)
		{
			toHit = toHit + (distanceToTarget - this.m.MinRange) * properties.HitChanceAdditionalWithEachTile * properties.HitChanceWithEachTileMult;
		}

		if (levelDifference < 0)
		{
			toHit = toHit + this.Const.Combat.LevelDifferenceToHitBonus;
		}
		else
		{
			toHit = toHit + this.Const.Combat.LevelDifferenceToHitMalus * levelDifference;
		}

		if (!this.m.IsShieldRelevant)
		{
			local shield = _targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (shield != null && shield.isItemType(this.Const.Items.ItemType.Shield))
			{
				local shieldBonus = (this.m.IsRanged ? shield.getRangedDefense() : shield.getMeleeDefense());
				toHit = toHit + shieldBonus;

				if (!this.m.IsShieldwallRelevant && _targetEntity.getSkills().hasSkill("effects.shieldwall"))
				{
					toHit = toHit + shieldBonus;
				}
			}
		}

		toHit = toHit * properties.TotalAttackToHitMult;
		toHit = toHit + this.Math.max(0, 100 - toHit) * (1.0 - defenderProperties.TotalDefenseToHitMult);
		local userTile = user.getTile();

		if (allowDiversion && this.m.IsRanged && userTile.getDistanceTo(_targetEntity.getTile()) > 1)
		{
			local blockedTiles = this.Const.Tactical.Common.getBlockedTiles(userTile, _targetEntity.getTile(), user.getFaction(), true);

			if (blockedTiles.len() != 0)
			{
				local blockChance = this.Const.Combat.RangedAttackBlockedChance * properties.RangedAttackBlockedChanceMult;
				toHit = this.Math.floor(toHit * (1.0 - blockChance));
			}
		}

		return this.Math.max(5, this.Math.min(95, toHit));
	}

	o.modGetHitFactors = function( ret, _targetTile )
	{
		if (!ret)
		{
			return ret;
		}

		local retCount = ret.len();
		local green = function ( text )
		{
			if (!text)
			{
				return "";
			}

			return "[color=" + this.Const.UI.Color.PositiveValue + "]" + text + "[/color]";
		};
		local red = function ( text )
		{
			if (!text)
			{
				return "";
			}

			return "[color=" + this.Const.UI.Color.NegativeValue + "]" + text + "[/color]";
		};
		local isIn = function ( pattern, text )
		{
			if (!pattern || !text)
			{
				return false;
			}

			return this.regexp(pattern).search(text);
		};
		local user = this.m.Container.getActor();
		local myTile = user.getTile();
		local targetEntity = _targetTile.IsOccupiedByActor ? _targetTile.getEntity() : null;
		local getBadTerrainFactor = function ( attributeIcon )
		{
			if (!attributeIcon)
			{
				return false;
			}

			local badTerrains = [
				"terrain.swamp"
			];

			for( local i = 0; i < badTerrains.len(); i++ )
			{
				local terrainEffect = targetEntity.getSkills().getSkillByID(badTerrains[i]);

				if (!(terrainEffect && "getTooltip" in terrainEffect))
				{
				}
				else
				{
					local tooltip = terrainEffect.getTooltip();

					foreach( i, r in tooltip )
					{
						if (("type" in r) && r.type == "text" && ("icon" in r) && "text" in r)
						{
							if (isIn(attributeIcon, r.icon))
							{
								return r.text;
							}
						}
					}
				}
			}

			return null;
		};
		local attackingEntity = user;
		local thisSkill = this;
		local modifier = {};
		local skillName = this.getName();
		local skillHitChanceBonus = this.m.HitChanceBonus;
		modifier[skillName] <- function ( row, description )
		{
			if (!("icon" in row))
			{
				return;
			}

			local icon = row.icon;

			if (icon == "ui/tooltips/positive.png")
			{
				row.text = green("" + skillHitChanceBonus + "%") + " " + description;
			}
			else if (icon == "ui/tooltips/negative.png")
			{
				row.text = red(-skillHitChanceBonus + "%") + " " + description;
			}
		};
		modifier.Surrounded <- function ( row, description )
		{
			if (targetEntity.m.CurrentProperties.IsImmuneToSurrounding)
			{
				return;
			}

			local malus = this.Math.max(0, attackingEntity.getCurrentProperties().SurroundedBonus - targetEntity.getCurrentProperties().SurroundedDefense) * targetEntity.getSurroundedCount();

			if (malus)
			{
				row.text = green(malus + "%") + " " + description;
			}
		};
		modifier["Height advantage"] <- function ( row, description )
		{
			row.text = green(this.Const.Combat.LevelDifferenceToHitBonus + "%") + " " + description;
		};
		modifier["Height disadvantage"] <- function ( row, description )
		{
			local levelDifference = myTile.Level - _targetTile.Level;
			local malus = this.Const.Combat.LevelDifferenceToHitMalus * levelDifference;
			row.text = red(malus + "%") + " " + description;
		};
		modifier["Target on bad terrain"] <- function ( row, description )
		{
			local defenseIcon = thisSkill.m.IsRanged ? "ranged_defense" : "melee_defense";
			local terrainFactor = getBadTerrainFactor(defenseIcon);

			if (terrainFactor)
			{
				row.text = description + " (" + terrainFactor + ")";
			}
		};
		modifier["On bad terrain"] <- function ( row, description )
		{
			local attackIcon = thisSkill.m.IsRanged ? "ranged_skill" : "melee_skill";
			local terrainFactor = getBadTerrainFactor(attackIcon);

			if (terrainFactor)
			{
				row.text = description + " (" + terrainFactor + ")";
			}
		};
		modifier["Fast Adaption"] <- function ( row, description )
		{
			local fast_adaption = thisSkill.m.Container.getSkillByID("perk.fast_adaption");
			local bonus = 10 * fast_adaption.m.Stacks;
			row.text = green(bonus + "%") + " " + description;
		};
		modifier["Too close"] <- function ( row, description )
		{
			row.text = red(-skillHitChanceBonus + "%") + " " + description;
		};
		local getShieldBonus = function ()
		{
			local shield = targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			local shieldBonus = (thisSkill.m.IsRanged ? shield.getRangedDefense() : shield.getMeleeDefense());
			return this.Math.floor(shieldBonus);
		};
		modifier["Armed with shield"] <- function ( row, description )
		{
			row.text = red(getShieldBonus() + "%") + " " + description;
		};
		modifier.Shieldwall <- function ( row, description )
		{
			local shieldwallEffect = targetEntity.getSkills().getSkillByID("effects.shieldwall");
			local adjacencyBonus = shieldwallEffect.getBonus();
			row.text = red(getShieldBonus() + adjacencyBonus + "%") + " " + description;
		};
		local isRangedRelevant = function ()
		{
			return thisSkill.m.IsRanged && myTile.getDistanceTo(_targetTile) > this.m.MinRange && _targetTile.IsOccupiedByActor;
		};

		if (isRangedRelevant())
		{
			local distanceToTarget = _targetTile.getDistanceTo(user.getTile());
			local propertiesWithSkill = this.factoringOffhand(thisSkill.m.Container.buildPropertiesForUse(thisSkill, targetEntity));
			modifier["Distance of " + distanceToTarget] <- function ( row, description )
			{
				local hitDistancePenalty = (distanceToTarget - thisSkill.m.MinRange) * propertiesWithSkill.HitChanceAdditionalWithEachTile * propertiesWithSkill.HitChanceWithEachTileMult;
				row.text = (hitDistancePenalty > 0 ? green(hitDistancePenalty + "%") : red(-hitDistancePenalty + "%")) + " " + description;
			};
			modifier["Line of fire blocked"] <- function ( row, description )
			{
				local blockChance = this.Const.Combat.RangedAttackBlockedChance * propertiesWithSkill.RangedAttackBlockedChanceMult;
				blockChance = this.Math.ceil(blockChance * 100);
				row.text = description + "\n(" + red("-" + blockChance + "%") + " Total hit chance)";
			};
			  // [082]  OP_CLOSE          0     18    0    0
		}

		modifier.Nighttime <- function ( row, description )
		{
			local night = user.getSkills().getSkillByID("special.night");
			local attributeIcon = "ranged_skill";

			if (!(night && "getTooltip" in night))
			{
				return;
			}

			local tooltip = night.getTooltip();

			foreach( _, r in tooltip )
			{
				if (("type" in r) && r.type == "text" && ("icon" in r) && "text" in r)
				{
					if (isIn(attributeIcon, r.icon))
					{
						row.text = description + "\n(" + r.text + ")";
						return;
					}
				}
			}
		};
		local getDamageResistance = function ()
		{
			if (!targetEntity)
			{
				return null;
			}

			local racialSkills = [
				"racial.skeleton",
				"racial.golem",
				"racial.serpent",
				"racial.alp",
				"racial.schrat"
			];
			local racialSkill;

			for( local i = 0; i < racialSkills.len(); i++ )
			{
				racialSkill = targetEntity.getSkills().getSkillByID(racialSkills[i]);

				if (racialSkill)
				{
					break;
				}
			}

			if (!racialSkill)
			{
				return null;
			}

			local propertiesBefore = targetEntity.getCurrentProperties();

			if (!("DamageReceivedRegularMult" in propertiesBefore))
			{
				return null;
			}

			local hitInfo = clone this.Const.Tactical.HitInfo;
			local propertiesAfter = propertiesBefore.getClone();
			racialSkill.onBeforeDamageReceived(attackingEntity, thisSkill, hitInfo, propertiesAfter);
			local diff = propertiesBefore.DamageReceivedRegularMult - propertiesAfter.DamageReceivedRegularMult;
			return this.Math.ceil(diff * 100);
		};
		local flagResistanceExists = false;
		modifier["Resistance against ranged weapons"] <- function ( row, description )
		{
			flagResistanceExists = true;
			local damageResistance = getDamageResistance();

			if (damageResistance == null)
			{
				return;
			}

			row.text = description + "\n(" + red("-" + damageResistance + "%") + " Total HP damage using " + thisSkill.getName() + ")";
		};
		modifier["Resistance against piercing attacks"] <- function ( row, description )
		{
			flagResistanceExists = true;
			local damageResistance = getDamageResistance();

			if (damageResistance == null)
			{
				return;
			}

			row.text = description + "\n(" + red("-" + damageResistance + "%") + " Total HP damage using " + thisSkill.getName() + ")";
		};

		for( local i = 0; i < retCount; i++ )
		{
			local row = ret[i];

			if ("text" in row)
			{
				local description = row.text;

				if (description in modifier)
				{
					modifier[description](row, description);
				}
			}
		}

		local getDifferenceInProperty = function ( _property, _targetEntity )
		{
			local props = user.getCurrentProperties();

			if (!(_property in props))
			{
				return null;
			}

			local propsWithSkill = props.getClone();
			thisSkill.onAnySkillUsed(thisSkill, _targetEntity, propsWithSkill);
			return propsWithSkill[_property] - props[_property];
		};

		if (!thisSkill.m.HitChanceBonus && isRangedRelevant())
		{
			local diff = getDifferenceInProperty("RangedSkill", targetEntity);

			if (diff != null)
			{
				if (diff > 0)
				{
					ret.insert(0, {
						icon = "ui/tooltips/positive.png",
						text = green(diff + "%") + " " + thisSkill.getName()
					});
				}
				else if (diff < 0)
				{
					ret.insert(0, {
						icon = "ui/tooltips/negative.png",
						text = red(diff + "%") + " " + thisSkill.getName()
					});
				}
			}
		}

		local addDamageResistanceRow = function ()
		{
			if (!flagResistanceExists && thisSkill.m.IsAttack && _targetTile.IsOccupiedByActor)
			{
				local damageResistance = getDamageResistance();

				if (!damageResistance)
				{
					return;
				}

				local icon = damageResistance > 0 ? "ui/tooltips/negative.png" : "ui/tooltips/positive.png";
				local desc = damageResistance > 0 ? "Resistance against" : "Susceptible to";
				local sign = damageResistance > 0 ? "-" : "+";
				local colorize = damageResistance > 0 ? red : green;

				if (damageResistance < 0)
				{
					damageResistance = damageResistance * -1;
				}

				ret.push({
					icon = icon,
					text = desc + " " + thisSkill.getName() + "\n(" + colorize(sign + damageResistance + "%") + " Total HP damage)"
				});
			}
		};
		local addLungeDamageRow = function ()
		{
			if (!thisSkill.m.IsAttack || thisSkill.m.ID != "actives.lunge" || !_targetTile.IsOccupiedByActor)
			{
				return;
			}

			local diff = getDifferenceInProperty("DamageTotalMult", null);

			if (!diff)
			{
				return;
			}

			local icon = diff > 0 ? "ui/tooltips/positive.png" : "ui/tooltips/negative.png";
			local desc = diff > 0 ? "High initiative" : "Low initiative";
			local sign = diff > 0 ? "+" : "-";
			local colorize = diff > 0 ? green : red;

			if (diff < 0)
			{
				diff = diff * -1;
			}

			diff = this.Math.floor(diff * 100);
			ret.push({
				icon = icon,
				text = desc + " " + "\n(" + colorize(sign + diff + "%") + " Lunge damage)"
			});
		};
		addDamageResistanceRow();
		addLungeDamageRow();
		return ret;
	}

});


