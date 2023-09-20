this.throw_dirt_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Charges = 1
	},
	function create()
	{
		this.m.ID = "actives.throw_dirt";
		this.m.Name = "Throw Dirt";
		this.m.Description = "Throws dirt to stun the enemy. This trick does not work more than once on the same enemy";
		this.m.Icon = "skills/active_215.png";
		this.m.IconDisabled = "skills/active_215_sw.png";
		this.m.Overlay = "active_215";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc6/throw_dirt_01.wav",
			"sounds/enemies/dlc6/throw_dirt_02.wav",
			"sounds/enemies/dlc6/throw_dirt_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.IsUsingHitchance = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
	}

	function isUsable()
	{
		if (this.m.Charges <= 0) return false;
		return this.skill.isUsable();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) return false;
		if (this.m.Container.getActor().isAlliedWith(_targetTile.getEntity())) return false;
		if (_targetTile.getEntity().getSkills().hasSkill("effects.stunned")) return false;
		if (_targetTile.getEntity().getSkills().hasSkill("effects.legend_threw_sand_effect")) return false;
		if (_targetTile.getEntity().getSkills().hasSkill("perk.pocket_dirt")) return false;
		if (_targetTile.getEntity().getFlags().has("perk.DirtImmune")) return false;

		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Charges = 0;

		local target = _targetTile.getEntity();
		if (target.isAlliedWithPlayer())
		{
			local effect = {
				Delay = 0,
				Quantity = 20,
				LifeTimeQuantity = 20,
				SpawnRate = 400,
				Brushes = [
					"sand_dust_01"
				],
				Stages = [
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.2,
						ColorMin = this.createColor("eeeeee00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.5,
						ScaleMax = 0.5,
						RotationMin = 0,
						RotationMax = 359,
						VelocityMin = 60,
						VelocityMax = 100,
						DirectionMin = this.createVec(-0.7, -0.6),
						DirectionMax = this.createVec(-0.6, -0.6),
						SpawnOffsetMin = this.createVec(-35, -15),
						SpawnOffsetMax = this.createVec(35, 20)
					},
					{
						LifeTimeMin = 0.75,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("eeeeeeee"),
						ColorMax = this.createColor("ffffffff"),
						ScaleMin = 0.5,
						ScaleMax = 0.75,
						VelocityMin = 60,
						VelocityMax = 100,
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.2,
						ColorMin = this.createColor("eeeeee00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.75,
						ScaleMax = 1.0,
						VelocityMin = 0,
						VelocityMax = 0,
						ForceMin = this.createVec(0, -100),
						ForceMax = this.createVec(0, -100)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect.Brushes, _targetTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(30, 70));
		}
		else
		{
			local effect = {
				Delay = 0,
				Quantity = 20,
				LifeTimeQuantity = 20,
				SpawnRate = 400,
				Brushes = [
					"sand_dust_01"
				],
				Stages = [
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.2,
						ColorMin = this.createColor("eeeeee00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.5,
						ScaleMax = 0.5,
						RotationMin = 0,
						RotationMax = 359,
						VelocityMin = 60,
						VelocityMax = 100,
						DirectionMin = this.createVec(0.6, -0.6),
						DirectionMax = this.createVec(0.7, -0.6),
						SpawnOffsetMin = this.createVec(-35, -15),
						SpawnOffsetMax = this.createVec(35, 20)
					},
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.25,
						ColorMin = this.createColor("eeeeeeee"),
						ColorMax = this.createColor("ffffffff"),
						ScaleMin = 0.5,
						ScaleMax = 0.75,
						VelocityMin = 60,
						VelocityMax = 100,
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.2,
						ColorMin = this.createColor("eeeeee00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.75,
						ScaleMax = 1.0,
						VelocityMin = 0,
						VelocityMax = 0,
						ForceMin = this.createVec(0, -100),
						ForceMax = this.createVec(0, -100)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect.Brushes, _targetTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(-30, 70));
		}
	
		if (!target.getSkills().hasSkill("effects.stunned")
			&& !target.getSkills().hasSkill("effects.legend_threw_sand_effect")
			&& !target.getSkills().hasSkill("perk.pocket_dirt")
			&& !target.getFlags().has("DirtImmune")
		)
		{
			target.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));
			target.getSkills().add(::new("scripts/skills/effects/legend_threw_sand_effect"));
			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				this.Tactical.EventLog.logIn(this.Const.UI.getColorizedEntityName(target) + ::MSU.Text.colorRed(" is stunned"));
		}
		this.Tactical.getShaker().shake(target, _user.getTile(), 4);
		return true;
	}

	function onCombatStarted()
	{
		this.m.Charges = 1;
	}

	function onCombatFinished()
	{
		this.m.Charges = 1;
	}

});

