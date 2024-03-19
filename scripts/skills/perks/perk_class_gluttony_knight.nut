::Const.Strings.PerkName.GluttonyKnight <- "Knight of Gluttony";
::Const.Strings.PerkDescription.GluttonyKnight <- ::MSU.Text.color(::Z.Color.Purple, "Class")
+ "\nConsume, ravage, red... The remnant power of the Shub-Niggurath, the Mother Tree of Desire..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\nE Class Melee: " + ::MSU.Text.colorGreen("+20") + " Attack"
+ "\nF Class Defense: " + ::MSU.Text.colorGreen("+10") + " Defense"
+ "\n• At the start of battle, gain 1 charge of shielding."
+ "\n• Each charge can nullify an attack. Gain more charges through consuming enemies or corpses.";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.GluttonyKnight].Name = ::Const.Strings.PerkName.GluttonyKnight;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.GluttonyKnight].Tooltip = ::Const.Strings.PerkDescription.GluttonyKnight;

this.perk_class_gluttony_knight <- this.inherit("scripts/skills/skill", {
	m = {
		Charges = 1,
		Charges_Max = 5,
		Immunity = true
	},
	function create()
	{
		this.m.ID = "perk.class.gluttony_knight";
		this.m.Name = ::Const.Strings.PerkName.GluttonyKnight;
		this.m.Description = ::Const.Strings.PerkDescription.GluttonyKnight;
		this.m.Icon = "ui/perks/perk_29.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled()) return;
		actor.addSprite("sprite_gluttony_shield");
		actor.getSprite("sprite_gluttony_shield").setHorizontalFlipping(true);
		actor.getSprite("sprite_gluttony_shield").setBrush("gluttony_shield");
		actor.getSprite("sprite_gluttony_shield").Visible = true;
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
		this.m.Charges = ::Math.min(this.m.Charges_Max, this.m.Charges + _amount);
		if (this.m.Charges > 0)
		{
			local actor = this.getContainer().getActor();
			actor.getSprite("sprite_gluttony_shield").Visible = true;
			this.m.Immunity = true;
		}
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

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (this.m.Charges == 0)
		{
			this.m.Immunity = false;
			return;
		}

		local actor = this.getContainer().getActor();
		if (_attacker != null && _attacker.getID() == actor.getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance()) return;

		local the_strongest = this.m.Container.getSkillByID("perk.stance.the_strongest");
        if (the_strongest != null && the_strongest.m.Active) return;

		_properties.DamageReceivedRegularMult *= 0;
		_properties.DamageReceivedArmorMult *= 0;
		this.m.Charges = ::Math.max(0, this.m.Charges - 1);
		::Tactical.EventLog.logIn("[" + ::MSU.Text.colorRed("Hair Armor") + "] nullified damage. ( " + this.m.Charges + "/5 charges left)");

		if (this.m.Charges == 0) actor.getSprite("sprite_gluttony_shield").Visible = false;
		// Play feast sounds Bloodbath
		local feast_sounds = [
			"sounds/enemies/gruesome_feast_01.wav",
			"sounds/enemies/gruesome_feast_02.wav",
			"sounds/enemies/gruesome_feast_03.wav"
		];
		this.Sound.play(::MSU.Array.rand(feast_sounds), 0.5, actor.getPos(), ::Math.rand(95, 105) * 0.01);
		this.Sound.play("sounds/general/shield_crack.wav", 200.0, actor.getPos());
		spawnEffect();

	}


	function onUpdate( _properties )
	{
		_properties.MeleeSkill += 20;
		_properties.MeleeDefense += 10;

		if (this.m.Immunity)
		{
			_properties.IsImmuneToStun = true;
			_properties.IsImmuneToDaze = true;
			_properties.IsImmuneToBleeding = true;
			_properties.IsImmuneToPoison = true;
		}

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

