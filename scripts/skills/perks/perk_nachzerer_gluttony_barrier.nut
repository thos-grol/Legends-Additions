this.perk_nachzerer_gluttony_barrier <- this.inherit("scripts/skills/skill", {
	m = {
		Charges = 1,
		Charges_Max = 5
	},
	function create()
	{
		this.m.ID = "perk.nachzerer_gluttony_barrier";
		this.m.Name = this.Const.Strings.PerkName.NachzererGluttonyBarrier;
		this.m.Description = this.Const.Strings.PerkDescription.NachzererGluttonyBarrier;
		this.m.Icon = "ui/perks/perk_29.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.direwolf_blizzard"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/direwolf_blizzard"));
		}
		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled()) return;
		actor.addSprite("sprite_gluttony_shield");
		actor.getSprite("sprite_gluttony_shield").setHorizontalFlipping(true);
		actor.getSprite("sprite_gluttony_shield").setBrush("gluttony_shield");
		actor.getSprite("sprite_gluttony_shield").Visible = true;
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.direwolf_blizzard");
	}

	function onCombatStarted()
	{
		this.m.Charges = 1;
		local actor = this.getContainer().getActor();
		if (!actor.isPlayerControlled()) return;
		actor.addSprite("sprite_gluttony_shield");
		actor.getSprite("sprite_gluttony_shield").setHorizontalFlipping(true);
		actor.getSprite("sprite_gluttony_shield").setBrush("gluttony_shield");
		actor.getSprite("sprite_gluttony_shield").Visible = true;
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();
		actor.removeSprite("sprite_gluttony_shield");
	}

	function onTurnStart()
	{
		if (this.m.Charges > 0)
		{
			local actor = this.getContainer().getActor();
			actor.getSprite("sprite_gluttony_shield").Visible = true;
		}
		
	}

	function onCombatFinished()
	{
		this.m.Charges = 1;
	}

	function isHidden()
	{
		return this.m.Charges == 0;
	}

	function addCharges( _amount )
	{
		::logInfo("Adding charges");
		this.m.Charges = this.Math.min(this.m.Charges_Max, this.m.Charges + _amount);
		if (this.m.Charges > 0)
		{
			local actor = this.getContainer().getActor();
			actor.getSprite("sprite_gluttony_shield").Visible = true;
		}
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

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (this.m.Charges == 0) return;
		local actor = this.getContainer().getActor();
		if (_attacker != null && _attacker.getID() == actor.getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance()) return;
		//if (actor.getSkills().getSkillByID("effects.bone_plating") != null) return; //TODO: boneplating checks for this

		_properties.DamageReceivedRegularMult *= 0;
		_properties.DamageReceivedArmorMult *= 0;
		this.m.Charges = this.Math.max(0, this.m.Charges - 1);
		::Tactical.EventLog.logIn("[" + ::MSU.Text.colorRed("Hair Armor") + "] nullified damage. ( " + this.m.Charges + "/5 charges left)");

		if (this.m.Charges == 0) actor.getSprite("sprite_gluttony_shield").Visible = false;
		// Play feast sounds Bloodbath
		local feast_sounds = [
			"sounds/enemies/gruesome_feast_01.wav",
			"sounds/enemies/gruesome_feast_02.wav",
			"sounds/enemies/gruesome_feast_03.wav"
		];
		this.Sound.play(::MSU.Array.rand(feast_sounds), 0.5, actor.getPos(), this.Math.rand(95, 105) * 0.01);
		this.Sound.play("sounds/general/shield_crack.wav", 200.0, actor.getPos());
		spawnEffect();

	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("la_nachzerer"))
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 45;
			_properties.DamageArmorMult *= 0.75;
		}
	}

	function spawnEffect()
	{
		local owntile = this.getContainer().getActor().getTile();
		
		local effect = {
			Delay = 0,
			Quantity = 12,
			LifeTimeQuantity = 12,
			SpawnRate = 100,
			Brushes = [
				"bust_lich_aura_01_red"
			],
			Stages = [
				{
					LifeTimeMin = 0.5,
					LifeTimeMax = 0.5,
					ColorMin = ::createColor("ffffff5f"),
					ColorMax = ::createColor("ffffff5f"),
					ScaleMin = 1.0,
					ScaleMax = 1.0,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = ::createVec(-1.0, -1.0),
					DirectionMax = ::createVec(1.0, 1.0),
					SpawnOffsetMin = ::createVec(-10, -10),
					SpawnOffsetMax = ::createVec(10, 10),
					ForceMin = ::createVec(0, 0),
					ForceMax = ::createVec(0, 0)
				},
				{
					LifeTimeMin = 0.5,
					LifeTimeMax = 0.5,
					ColorMin = ::createColor("ffffff2f"),
					ColorMax = ::createColor("ffffff2f"),
					ScaleMin = 0.9,
					ScaleMax = 0.9,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = ::createVec(-1.0, -1.0),
					DirectionMax = ::createVec(1.0, 1.0),
					ForceMin = ::createVec(0, 0),
					ForceMax = ::createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = ::createColor("ffffff00"),
					ColorMax = ::createColor("ffffff00"),
					ScaleMin = 0.1,
					ScaleMax = 0.1,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = ::createVec(-1.0, -1.0),
					DirectionMax = ::createVec(1.0, 1.0),
					ForceMin = ::createVec(0, 0),
					ForceMax = ::createVec(0, 0)
				}
			]
		};
		::Tactical.spawnParticleEffect(false, effect.Brushes, owntile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, ::createVec(0, 40));
	}

});

