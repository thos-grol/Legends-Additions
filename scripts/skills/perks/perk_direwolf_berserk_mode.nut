::Const.Strings.PerkName.DirewolfBerserkMode <- "Berserk Mode";
::Const.Strings.PerkDescription.DirewolfBerserkMode <- "Unstoppable rage..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "When reduced to 50% hp:")
+ "\n• Triggers an aoe magic blizzard that damages and stun hit units for 2 turns."
+ "\n• Become immune to stuns and displacement for 2 turns."
+ "\n• Gain increased damage, initiative, and defenses for 2 turns.";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.DirewolfBerserkMode].Name = ::Const.Strings.PerkName.DirewolfBerserkMode;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.DirewolfBerserkMode].Tooltip = ::Const.Strings.PerkDescription.DirewolfBerserkMode;

this.perk_direwolf_berserk_mode <- this.inherit("scripts/skills/skill", {
	m = {
		Charges = 1,
		Berserk_Turns = 0,
		Berserk_Mode = false,
		SnowTiles = []
	},
	function create()
	{
		this.m.ID = "perk.direwolf_berserk_mode";
		this.m.Name = this.Const.Strings.PerkName.DirewolfBerserkMode;
		this.m.Description = this.Const.Strings.PerkDescription.DirewolfBerserkMode;
		this.m.Icon = "ui/perks/perk_29.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;

		for( local i = 1; i <= 3; i = ++i )
		{
			this.m.SnowTiles.push(this.MapGen.get("tactical.tile.snow" + i));
		}
	}

	function onCombatStarted()
	{
		this.m.Charges = 1;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Only receive [color=" + this.Const.UI.Color.PositiveValue + "] 0%[/color] of any damage to hitpoints for " + this.m.Charges + " attacks. Bone plating takes precedence over this effect."
		});

		return tooltip;
	}

	function onTurnEnd()
	{
		if (!this.m.Berserk_Mode) return;

		this.m.Berserk_Turns = ::Math.max(0, this.m.Berserk_Turns - 1);

		if (this.m.Berserk_Turns != 0) return;

		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("la_direwolf_frenzy_attacks"))
			actor.getFlags().remove("la_direwolf_frenzy_attacks");

		if (actor.getFlags().has("la_direwolf"))
			actor.removeSprite("head_berserk");

		this.m.Berserk_Mode = false;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("la_direwolf_frenzy_attacks") && !this.getContainer().hasSkill("effects.indomitable"))
			this.m.Container.add(this.new("scripts/skills/effects/indomitable_effect"));
	}

	function onUpdate( _properties )
	{
		if (this.m.Berserk_Turns > 0)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 45;
			_properties.Initiative += 100;
			_properties.MeleeSkill += 15;
            _properties.MeleeDefense += 15;
            _properties.RangedDefense += 15;
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.Charges <= 0) return;
		local actor = this.getContainer().getActor();
		local projected_hitpoints_pct = (actor.getHitpoints() - _damageHitpoints) / actor.getHitpointsMax();
		if (projected_hitpoints_pct > 0.5) return;

		this.m.Charges = 0;
		this.m.Berserk_Mode = true;
		this.m.Berserk_Turns = 3;
		actor.getFlags().set("la_direwolf_frenzy_attacks", true);

		if (actor.getFlags().has("la_direwolf"))
		{
			actor.addSprite("head_berserk");
			actor.getSprite("head_berserk").setBrush("bust_direwolf_03_berserk");
			actor.getSprite("head_berserk").Scale = 1.25;
			actor.getSprite("head_berserk").Visible = true;
		}

		if (!this.getContainer().hasSkill("effects.indomitable"))
			this.m.Container.add(this.new("scripts/skills/effects/indomitable_effect"));

		this.Sound.play("sounds/monster/direwolf_berserk.wav", 300.0, actor.getPos());
		this.Sound.play("sounds/winter/blizzard_buildup.wav", 200.0, actor.getPos());

		::Tactical.EventLog.log(
			"\n" + ::Const.UI.getColorizedEntityName(actor) + ::MSU.Text.color(::Z.Log.Color.BloodRed, " has gone berserk.") + "\n"
		);

		local tag = {
			Skill = this,
			User = actor,
			TargetTile = actor.getTile()
		};

		for( local i = 0; i < this.Const.Tactical.SpiritWalkStartParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.SpiritWalkStartParticles[i].Brushes, actor.getTile(), this.Const.Tactical.SpiritWalkStartParticles[i].Delay, this.Const.Tactical.SpiritWalkStartParticles[i].Quantity, this.Const.Tactical.SpiritWalkStartParticles[i].LifeTimeQuantity, this.Const.Tactical.SpiritWalkStartParticles[i].SpawnRate, this.Const.Tactical.SpiritWalkStartParticles[i].Stages);
		}
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onDelayedEffect.bindenv(this), tag);
	}

	function onDelayedEffect( _tag )
	{
		local user = _tag.User;
		local targetTile = _tag.TargetTile;
		local myTile = user.getTile();
		local dir = myTile.getDirectionTo(targetTile);
		local affectedTiles = this.getAffectedTiles(targetTile);
		local tag = {
			Skill = _tag.Skill,
			User = user,
			Targets = affectedTiles,
			HitInfo = clone this.Const.Tactical.HitInfo
		};
		tag.HitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit;
		tag.HitInfo.DamageDirect = 1.0;
		tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
		tag.HitInfo.BodyDamageMult = 1.0;
		tag.HitInfo.FatalityChanceMult = 1.0;
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, this.applyEffectToTargets.bindenv(this), tag);
		return true;
	}

	function applyEffectToTargets( _tag )
	{
		local user = _tag.User;
		local targets = _tag.Targets;

		foreach( t in targets )
		{
			for( local i = 0; i < this.Const.Tactical.SpiritWalkEndParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, this.Const.Tactical.SpiritWalkEndParticles[i].Brushes, t, this.Const.Tactical.SpiritWalkEndParticles[i].Delay, this.Const.Tactical.SpiritWalkEndParticles[i].Quantity, this.Const.Tactical.SpiritWalkEndParticles[i].LifeTimeQuantity, this.Const.Tactical.SpiritWalkEndParticles[i].SpawnRate, this.Const.Tactical.SpiritWalkEndParticles[i].Stages);
			}

			if (t.Subtype != this.Const.Tactical.TerrainSubtype.Snow && t.Subtype != this.Const.Tactical.TerrainSubtype.LightSnow)
			{
				t.clear();
				t.Type = 0;
				_tag.Skill.m.SnowTiles[this.Math.rand(0, _tag.Skill.m.SnowTiles.len() - 1)].onFirstPass({
					X = t.SquareCoords.X,
					Y = t.SquareCoords.Y,
					W = 1,
					H = 1,
					IsEmpty = true,
					SpawnObjects = false
				});
			}

			if (!t.IsOccupiedByActor || !t.getEntity().isAttackable())
			{
				continue;
			}

			local target = t.getEntity();

			_tag.HitInfo.DamageRegular = ::Math.rand(15, 30);
			local superCurrent = target.getCurrentProperties().getClone();
			target.onDamageReceived(user, _tag.Skill, _tag.HitInfo);

			if (target.isAlive())
			{
				target.getSkills().add(this.new("scripts/skills/effects/chilled_effect"));
				local stun = this.new("scripts/skills/effects/stunned_effect");
				target.getSkills().add(stun);
				stun.setTurns(3);

				if (!user.isHiddenToPlayer() && target.getTile().IsVisibleForPlayer)
				::Tactical.EventLog.logIn(
					::Const.UI.getColorizedEntityName(target) + ::MSU.Text.color(::Z.Log.Color.BloodRed, " is stunned (3 turns).")
				);
			}
		}
		this.Sound.play("sounds/winter/blizzard_impact.wav", 300.0, user.getPos());
	}

	function getAffectedTiles( _targetTile )
	{
		local ret = [];
		this.Tactical.queryTilesInRange(_targetTile, 1, 1, false, [], this.onQueryTilesHit, ret);
		this.Tactical.queryTilesInRange(_targetTile, 2, 4, false, [], this.onQueryTilesHitRandom, ret);
		return ret;
	}

	function onQueryTilesHit( _tile, _ret )
	{
		_ret.push(_tile);
	}

	function onQueryTilesHitRandom( _tile, _ret )
	{
		if (::Math.rand(1,100) <= 75) _ret.push(_tile);
	}

});