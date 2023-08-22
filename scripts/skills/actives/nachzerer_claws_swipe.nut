this.nachzerer_claws_swipe <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 1,
		TilesUsed = []
	},
	function create()
	{
		this.m.ID = "actives.nachzerer_claws_swipe";
		this.m.Name = "Claw Swipe";
		this.m.Description = "Swing claws in a wide arc that hits three adjacent tiles in counter-clockwise order.";
		this.m.Icon = "skills/active_06.png";
		this.m.IconDisabled = "skills/active_06_sw.png";
		this.m.Overlay = "active_06";
		this.m.SoundOnUse = [
			"sounds/enemies/ghoul_claws_01.wav",
			"sounds/enemies/ghoul_claws_02.wav",
			"sounds/enemies/ghoul_claws_03.wav",
			"sounds/enemies/ghoul_claws_04.wav",
			"sounds/enemies/ghoul_claws_05.wav",
			"sounds/enemies/ghoul_claws_06.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAOE = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 35;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 75;
		this.m.ChanceDisembowel = 75;
		this.m.ChanceSmash = 0;
	}

	function onUpdate( _properties )
	{
		_properties.DamageRegularMin += 45;
		_properties.DamageRegularMax += 70;
		_properties.DamageArmorMult *= 0.75;
	}

	function onTurnStart()
	{
		this.m.Cooldown = this.Math.max(0, this.m.Cooldown - 1);
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.m.Cooldown == 0;
	}

	function onUse( _user, _targetTile )
	{
		this.m.TilesUsed = [];
		this.m.Cooldown = 1;
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSwing);
		local ret = false;
		local ownTile = _user.getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		local target = _targetTile.getEntity();
		ret = this.attackEntity(_user, target);

		if (!_user.isAlive() || _user.isDying()) return ret;
		if (ret && _targetTile.IsOccupiedByActor && target.isAlive() && !target.isDying()) 
			this.applyEffectToTarget(_user, target, _targetTile);
		local nextDir = dir - 1 >= 0 ? dir - 1 : this.Const.Direction.COUNT - 1;
		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);
			local success = false;

			if (nextTile.IsOccupiedByActor && nextTile.getEntity().isAttackable() && this.Math.abs(nextTile.Level - ownTile.Level) <= 1) success = this.attackEntity(_user, nextTile.getEntity());

			if (!_user.isAlive() || _user.isDying()) return success;
			if (success && nextTile.IsOccupiedByActor && nextTile.getEntity().isAlive() && !nextTile.getEntity().isDying()) this.applyEffectToTarget(_user, nextTile.getEntity(), nextTile);
			ret = success || ret;
		}

		nextDir = nextDir - 1 >= 0 ? nextDir - 1 : this.Const.Direction.COUNT - 1;
		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);
			local success = false;

			if (nextTile.IsOccupiedByActor && nextTile.getEntity().isAttackable() && this.Math.abs(nextTile.Level - ownTile.Level) <= 1) success = this.attackEntity(_user, nextTile.getEntity());
			if (!_user.isAlive() || _user.isDying()) return success;


			if (success && nextTile.IsOccupiedByActor && nextTile.getEntity().isAlive() && !nextTile.getEntity().isDying()) this.applyEffectToTarget(_user, nextTile.getEntity(), nextTile);
			ret = success || ret;
		}

		this.m.TilesUsed = [];
		return ret;
	}

	function onTargetSelected( _targetTile )
	{
		local ownTile = this.m.Container.getActor().getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, _targetTile, _targetTile.Pos.X, _targetTile.Pos.Y);
		local nextDir = dir - 1 >= 0 ? dir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);

			if (this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
			{
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, nextTile, nextTile.Pos.X, nextTile.Pos.Y);
			}
		}

		nextDir = nextDir - 1 >= 0 ? nextDir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);

			if (this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
			{
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, nextTile, nextTile.Pos.X, nextTile.Pos.Y);
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this) _properties.MeleeSkill -= 5;
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

	function applyEffectToTarget( _user, _target, _targetTile )
	{
		if (_target.getCurrentProperties().IsImmuneToKnockBackAndGrab || _target.getCurrentProperties().IsRooted) return;
		local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);
		if (knockToTile == null) return;

		this.m.TilesUsed.push(knockToTile.ID);

		if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer)) this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has knocked back " + this.Const.UI.getColorizedEntityName(_target));

		local skills = _target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");
		_target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - _targetTile.Level) - 1) * this.Const.Combat.FallingDamage;

		if (damage == 0) this.Tactical.getNavigator().teleport(_target, knockToTile, null, null, true);
		else
		{
			local p = this.getContainer().getActor().getCurrentProperties();
			local tag = {
				Attacker = _user,
				Skill = this,
				HitInfo = clone this.Const.Tactical.HitInfo
			};
			tag.HitInfo.DamageRegular = damage;
			tag.HitInfo.DamageDirect = 1.0;
			tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
			tag.HitInfo.BodyDamageMult = 1.0;
			tag.HitInfo.FatalityChanceMult = 1.0;
			this.Tactical.getNavigator().teleport(_target, knockToTile, this.onKnockedDown, tag, true);
		}
	}

	function onKnockedDown( _entity, _tag )
	{
		if (_tag.HitInfo.DamageRegular != 0)
		{
			_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
		}
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] chance to hit"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Knocks back on a hit"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can hit up to 3 targets"
			}
		]);

		return ret;
	}

});

