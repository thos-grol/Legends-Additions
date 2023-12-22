::Const.Strings.PerkName.ContinuanceKnight <- "Knight of Continuance ";
::Const.Strings.PerkDescription.ContinuanceKnight <- ::MSU.Text.color(::Z.Color.Purple, "Class")
+ "\nWho can hear this and remain sleeping? The living? The dead? The earth and the sky?... The heart relentless beats preserving the world's skin..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\nB Class Vitality: " + ::MSU.Text.colorGreen("+50") + " Hitpoints"
+ "\nE Class Endurance: " + ::MSU.Text.colorGreen("+10") + " Fatigue"
+ "\n• Grants the effect of Seismic Slam without any requirements or downsides"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Turn start")
+ "\n• Heal for 15% of Max Hitpoints";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ContinuanceKnight].Name = ::Const.Strings.PerkName.ContinuanceKnight;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ContinuanceKnight].Tooltip = ::Const.Strings.PerkDescription.ContinuanceKnight;

this.perk_class_continuance_knight <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.class.continuance_knight";
		this.m.Name = ::Const.Strings.PerkName.ContinuanceKnight;
		this.m.Description = ::Const.Strings.PerkDescription.ContinuanceKnight;
		this.m.Icon = "ui/perks/seismic_slam.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.SoundOnUse = [
			"sounds/enemies/unhold_regenerate_01.wav",
			"sounds/enemies/unhold_regenerate_02.wav",
			"sounds/enemies/unhold_regenerate_03.wav"
		];
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Stance", true);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.m.IsAttack)
		{
			_properties.DamageTotalMult *= 1.25;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity.isAlive() && !_targetEntity.isDying() && _skill.m.IsAttack)
		{
			if (!_targetEntity.getSkills().hasSkill("effects.staggered"))
			{
				_targetEntity.getSkills().add(::new("scripts/skills/effects/staggered_effect"));
				if (!_targetEntity.isHiddenToPlayer()) this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + " has been staggered");
			}

			if (!_targetEntity.getSkills().hasSkill("effects.seal"))
			{
				_targetEntity.getSkills().add(::new("scripts/skills/effects/seal_effect"));
				if (!_targetEntity.isHiddenToPlayer()) this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + "\'s movements have been sealed");
			}

		}
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += 50;
		_properties.Stamina += 10;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = ::Math.min(healthMissing, ::Math.floor(actor.getHitpointsMax() * 0.15));

		if (healthAdded <= 0) return;

		if (!actor.getSkills().hasSkill("effects.legend_redback_spider_poison"))
		{
			actor.setHitpoints(actor.getHitpoints() + healthAdded);
			actor.setDirty(true);

			if (!actor.isHiddenToPlayer())
			{
				this.spawnIcon("status_effect_79", actor.getTile());

				if (this.m.SoundOnUse.len() != 0)
				{
					this.Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
				}

				this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
			}
		}
	}

});

