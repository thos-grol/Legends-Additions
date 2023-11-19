this.berserker_rage_effect <- this.inherit("scripts/skills/skill", {
	m = {
		RageStacks = 0,
		LastRageSoundTime = 0
	},
	function create()
	{
		this.m.ID = "effects.berserker_rage";
		this.m.Name = "Rage";
		this.m.Icon = "skills/status_effect_34.png";
		this.m.IconMini = "status_effect_34_mini";
		this.m.Overlay = "status_effect_34";
		this.m.SoundOnUse = [
			"sounds/enemies/orc_rage_01.wav",
			"sounds/enemies/orc_rage_02.wav",
			"sounds/enemies/orc_rage_03.wav",
			"sounds/enemies/orc_rage_04.wav",
			"sounds/enemies/orc_rage_05.wav",
			"sounds/enemies/orc_rage_06.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
	}

	function getDescription()
	{
		return "The smell of blood and death sends you into an uncontrollable rage. Every taste of blood your weapon takes and every kill you make embolderns you and increases your lethality. Once in a rage, you must continuously feed it to keep it going";
	}

	function addRage( _r )
	{
		this.m.RageStacks += _r;
		local actor = this.getContainer().getActor();

		if (!actor.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0 && this.Time.getVirtualTimeF() - this.m.LastRageSoundTime > 5.0)
			{
				this.m.LastRageSoundTime = this.Time.getVirtualTimeF();
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * (this.Math.rand(75, 100) * 0.01), actor.getPos(), this.Math.rand(75, 100) * 0.01);
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " gains rage!");
		}

		if (!this.getContainer().getActor().getFlags().has("abomination"))
			this.getContainer().getActor().updateRageVisuals(this.m.RageStacks);
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = this.m.RageStacks == 0;
		_properties.DamageReceivedTotalMult *= this.Math.maxf(0.3, 1.0 - 0.02 * this.m.RageStacks);
		_properties.Bravery += 1 * this.m.RageStacks;
		_properties.DamageRegularMin += 1 * this.m.RageStacks;
		_properties.DamageRegularMax += 1 * this.m.RageStacks;
		_properties.Initiative += 1 * this.m.RageStacks;
	}

	function onTurnStart()
	{
		this.m.RageStacks = this.Math.max(0, this.m.RageStacks - 2);

		if (!this.getContainer().getActor().getFlags().has("abomination"))
			this.getContainer().getActor().updateRageVisuals(this.m.RageStacks);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.addRage(1);
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		this.addRage(3);
	}

});

