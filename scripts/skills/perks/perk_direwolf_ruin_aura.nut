::Const.Strings.PerkName.DirewolfRuinAura <- "Ruin Knight";
::Const.Strings.PerkDescription.DirewolfRuinAura <- ::MSU.Text.color(::Z.Log.Color.Purple, "Class")
+ "\nBring tragedy and ruin to those around you... The remnant power of the God of Ruin"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\nF Class Vitality: " + ::MSU.Text.colorGreen("+50") + " Hitpoints"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Turn start, 20% chance:")
+ "\n• Inflict an injury on all units within 2 tiles";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.DirewolfRuinAura].Name = ::Const.Strings.PerkName.DirewolfRuinAura;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.DirewolfRuinAura].Tooltip = ::Const.Strings.PerkDescription.DirewolfRuinAura;

this.perk_direwolf_ruin_aura <- this.inherit("scripts/skills/skill", {
	m = {
	},
	function create()
	{
		this.m.ID = "perk.direwolf_ruin_aura";
		this.m.Name = ::Const.Strings.PerkName.DirewolfRuinAura;
		this.m.Description = ::Const.Strings.PerkDescription.DirewolfRuinAura;
		this.m.Icon = "ui/perks/perk_29.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += 50;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Only receive [color=" + ::Const.UI.Color.PositiveValue + "] 0%[/color] of any damage to hitpoints for " + this.m.Charges + " attacks. Bone plating takes precedence over this effect."
		});

		return tooltip;
	}

	function onTurnStart()
	{
		//local count_melee_enemies = actor.getTile().getZoneOfControlCountOtherThan(actor.getAlliedFactions());
		if (::Math.rand(1, 100) > 20) return;
		local actor = this.getContainer().getActor();
		this.Sound.play("sounds/monster/direwolf_ruin.wav", 300.0, actor.getPos());

		::Tactical.EventLog.log(
			"\n" + ::Const.UI.getColorizedEntityName(actor) + ::MSU.Text.color(::Z.Log.Color.BloodRed, "'s aura of ruin flares.")
		);

		local tag = {
			Skill = this,
			User = actor,
			TargetTile = actor.getTile()
		};

		for( local i = 0; i < ::Const.Tactical.RuinAuraParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(false, ::Const.Tactical.RuinAuraParticles[i].Brushes, actor.getTile(), ::Const.Tactical.RuinAuraParticles[i].Delay, ::Const.Tactical.RuinAuraParticles[i].Quantity, ::Const.Tactical.RuinAuraParticles[i].LifeTimeQuantity, ::Const.Tactical.RuinAuraParticles[i].SpawnRate, ::Const.Tactical.RuinAuraParticles[i].Stages);
		}

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onDelayedEffect.bindenv(this), tag);
	}

	function onDelayedEffect( _tag )
	{
		local user = _tag.User;
		local targetTile = _tag.TargetTile;
		local myTile = user.getTile();
		local dir = myTile.getDirectionTo(targetTile);
		_tag.Targets <- this.getAffectedTiles(targetTile);

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, this.applyEffectToTargets.bindenv(this), _tag);
		return true;
	}

	function applyEffectToTargets( _tag )
	{
		local user = _tag.User;
		local targets = _tag.Targets;

		foreach( t in targets )
		{
			if (!t.IsOccupiedByActor) continue;
			if (!t.getEntity().isAttackable()) continue;

			for( local i = 0; i < ::Const.Tactical.RuinAuraParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, ::Const.Tactical.RuinAuraParticles[i].Brushes, t, ::Const.Tactical.RuinAuraParticles[i].Delay, ::Const.Tactical.RuinAuraParticles[i].Quantity, ::Const.Tactical.RuinAuraParticles[i].LifeTimeQuantity, ::Const.Tactical.RuinAuraParticles[i].SpawnRate, ::Const.Tactical.RuinAuraParticles[i].Stages);
			}

			local target = t.getEntity();
			if (!target.isAlive()) continue;
			if (!target.m.CurrentProperties.IsAffectedByInjuries) continue;
			if (!target.m.IsAbleToDie) continue;
			
			local potentialInjuries = [];
			foreach( inj in ::Const.Injury.All)
			{
				if (!target.m.Skills.hasSkill(inj.ID) && target.m.ExcludedInjuries.find(inj.ID) == null)
				{
					potentialInjuries.push(inj.Script);
				}
			}

			local appliedInjury = false;
			while (potentialInjuries.len() != 0)
			{
				local r = ::Math.rand(0, potentialInjuries.len() - 1);
				local injury = ::new("scripts/skills/" + potentialInjuries[r]);

				if (injury.isValid(target))
				{
					target.m.Skills.add(injury);

					if (!target.isHiddenToPlayer())
						::Z.Log.suffer_injury(target, injury.getNameOnly());


					appliedInjury = true;

					if (target.m.Sound[::Const.Sound.ActorEvent.DamageReceived].len() > 0)
					{
						local volume = 1.0;
						target.playSound(::Const.Sound.ActorEvent.DamageReceived, ::Const.Sound.Volume.Actor * target.m.SoundVolume[::Const.Sound.ActorEvent.DamageReceived] * target.m.SoundVolumeOverall * volume, target.m.SoundPitch);
					}

					break;
				}
				else potentialInjuries.remove(r);
			}
		}
		this.Sound.play("sounds/monster/direwolf_ruin_end.wav", 300.0, user.getPos());
	}

	function getAffectedTiles( _targetTile )
	{
		local ret = [];
		this.Tactical.queryTilesInRange(_targetTile, 1, 2, false, [], this.onQueryTilesHit, ret);
		return ret;
	}

	function onQueryTilesHit( _tile, _ret )
	{
		_ret.push(_tile);
	}

});

::Const.Tactical.RuinAuraParticles <- [
	{
		Delay = 0,
		Quantity = 3,
		LifeTimeQuantity = 3,
		SpawnRate = 3,
		Brushes = [
			"ruin"
		],
		Stages = [
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("4cccf300"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.8,
				ScaleMax = 1.00,
				RotationMin = 0,
				RotationMax = 0,
				TorqueMin = -10,
				TorqueMax = 10,
				VelocityMin = 50,
				VelocityMax = 100,
				DirectionMin = this.createVec(0.0, 1.0),
				DirectionMax = this.createVec(0.1, 1.0),
				SpawnOffsetMin = this.createVec(-50, 50),
				SpawnOffsetMax = this.createVec(50, 50),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 1.0,
				LifeTimeMax = 1.5,
				ColorMin = this.createColor("4cccf39d"),
				ColorMax = this.createColor("ffffff9d"),
				ScaleMin = 0.8,
				ScaleMax = 1.00,
				VelocityMin = 50,
				VelocityMax = 100,
				DirectionMin = this.createVec(0.0, 1.0),
				DirectionMax = this.createVec(0.1, 1.0),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("4cccf300"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.8,
				ScaleMax = 1.00,
				VelocityMin = 50,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			}
		]
	},
	{
		Delay = 100,
		Quantity = 3,
		LifeTimeQuantity = 3,
		SpawnRate = 3,
		Brushes = [
			"ruin"
		],
		Stages = [
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("4cccf300"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.8,
				ScaleMax = 1.00,
				RotationMin = 0,
				RotationMax = 0,
				TorqueMin = -10,
				TorqueMax = 10,
				VelocityMin = 50,
				VelocityMax = 100,
				DirectionMin = this.createVec(0.0, 1.0),
				DirectionMax = this.createVec(0.1, 1.0),
				SpawnOffsetMin = this.createVec(-50, -50),
				SpawnOffsetMax = this.createVec(50, 50),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 1.0,
				LifeTimeMax = 1.5,
				ColorMin = this.createColor("4cccf39d"),
				ColorMax = this.createColor("ffffff9d"),
				ScaleMin = 0.8,
				ScaleMax = 1.00,
				VelocityMin = 50,
				VelocityMax = 100,
				DirectionMin = this.createVec(0.0, 1.0),
				DirectionMax = this.createVec(0.1, 1.0),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("4cccf300"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.8,
				ScaleMax = 1.00,
				VelocityMin = 50,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			}
		]
	},
	{
		Delay = 200,
		Quantity = 3,
		LifeTimeQuantity = 3,
		SpawnRate = 3,
		Brushes = [
			"ruin"
		],
		Stages = [
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("4cccf300"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.8,
				ScaleMax = 1.00,
				RotationMin = 0,
				RotationMax = 0,
				TorqueMin = -10,
				TorqueMax = 10,
				VelocityMin = 50,
				VelocityMax = 100,
				DirectionMin = this.createVec(0.0, 1.0),
				DirectionMax = this.createVec(0.1, 1.0),
				SpawnOffsetMin = this.createVec(50, 0),
				SpawnOffsetMax = this.createVec(50, 50),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 1.0,
				LifeTimeMax = 1.5,
				ColorMin = this.createColor("4cccf39d"),
				ColorMax = this.createColor("ffffff9d"),
				ScaleMin = 0.8,
				ScaleMax = 1.00,
				VelocityMin = 50,
				VelocityMax = 100,
				DirectionMin = this.createVec(0.0, 1.0),
				DirectionMax = this.createVec(0.1, 1.0),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("4cccf300"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.8,
				ScaleMax = 1.00,
				VelocityMin = 50,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			}
		]
	},
	{
		Delay = 300,
		Quantity = 3,
		LifeTimeQuantity = 3,
		SpawnRate = 3,
		Brushes = [
			"ruin"
		],
		Stages = [
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("4cccf300"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.8,
				ScaleMax = 1.00,
				RotationMin = 0,
				RotationMax = 0,
				TorqueMin = -10,
				TorqueMax = 10,
				VelocityMin = 50,
				VelocityMax = 100,
				DirectionMin = this.createVec(0.0, 1.0),
				DirectionMax = this.createVec(0.1, 1.0),
				SpawnOffsetMin = this.createVec(-50, 0),
				SpawnOffsetMax = this.createVec(-50, 50),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 1.0,
				LifeTimeMax = 1.5,
				ColorMin = this.createColor("4cccf39d"),
				ColorMax = this.createColor("ffffff9d"),
				ScaleMin = 0.8,
				ScaleMax = 1.00,
				VelocityMin = 50,
				VelocityMax = 100,
				DirectionMin = this.createVec(0.0, 1.0),
				DirectionMax = this.createVec(0.1, 1.0),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("4cccf300"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.8,
				ScaleMax = 1.00,
				VelocityMin = 50,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			}
		]
	}
];