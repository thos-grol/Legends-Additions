this.nachzerer_claws <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.nachzerer_claws";
		this.m.Name = "Nachzerer Claws";
		this.m.Description = "Long and sharp claws that can tear flesh with ease.";
		this.m.KilledString = "Ripped to shreds";
		this.m.Icon = "skills/active_21.png";
		this.m.IconDisabled = "skills/active_21_sw.png";
		this.m.Overlay = "active_21";
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
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 6;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 75;
		this.m.ChanceDisembowel = 75;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + p.DamageRegularMin + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + p.DamageRegularMax + "[/color] damage"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.DamageRegularMin += 25;
		_properties.DamageRegularMax += 40;
		_properties.DamageArmorMult *= 0.75;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectClaws);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

    function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity.getHitpoints() <= 0 || !_targetEntity.isAlive() || _targetEntity.getFlags().has("undead")) return;
        if (_targetEntity.getCurrentProperties().IsImmuneToBleeding || hp - _targetEntity.getHitpoints() < this.Const.Combat.MinDamageToApplyBleeding) return;

		if (!_targetEntity.isHiddenToPlayer()) this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " has been bled by the Nachzerer's sharp claws.");

        local effect = this.new("scripts/skills/effects/bleeding_effect");
        if (_user.getFaction() == this.Const.Faction.Player) effect.setActor(this.getContainer().getActor());
        effect.setDamage(15);
        target.getSkills().add(effect);

		//TODO: add overwhelm
	}

});

