this.shellshocked_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},
	function create()
	{
		this.m.ID = "effects.shellshocked";
		this.m.Name = "Shellshocked";
		this.m.Icon = "skills/status_effect_119.png";
		this.m.IconMini = "status_effect_119_mini";
		this.m.Overlay = "status_effect_119";
		this.m.SoundOnUse = [
			"sounds/combat/dlc6/shellshocked_01.wav",
			"sounds/combat/dlc6/shellshocked_02.wav",
			"sounds/combat/dlc6/shellshocked_03.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is shellshocked from being near a mortar explosion. Their ears are ringing, their vision is blurred and they\'re slightly disoriented. The effect will slowly wear off over [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 5 * this.m.TurnsLeft + "%[/color] Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 5 * this.m.TurnsLeft + "%[/color] Agility"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 5 * this.m.TurnsLeft + "%[/color] Will"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 5 * this.m.TurnsLeft + "%[/color] Attack"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 5 * this.m.TurnsLeft + "%[/color] Defense"
			},
		];
	}

	function onAdded()
	{
		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " resists being shellshocked thanks to his unnatural physiology");
			}

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 0.8, this.getContainer().getActor().getPos());
			}

			this.getContainer().getActor().checkMorale(-1, 0);
		}
	}

	function onRefresh()
	{
		this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.spawnIcon("status_effect_119", this.getContainer().getActor().getTile());

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 0.8, this.getContainer().getActor().getPos());
		}
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.DamageTotalMult *= 1.0 - 0.05 * this.m.TurnsLeft;
		_properties.InitiativeMult *= 1.0 - 0.05 * this.m.TurnsLeft;
		_properties.BraveryMult *= 1.0 - 0.05 * this.m.TurnsLeft;
		_properties.MeleeSkillMult *= 1.0 - 0.05 * this.m.TurnsLeft;
		_properties.MeleeDefenseMult *= 1.0 - 0.05 * this.m.TurnsLeft;
	}

	function onTurnStart()
	{
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

