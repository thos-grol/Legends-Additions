this.legend_kick <- this.inherit("scripts/skills/skill", {
	m = {
		Backgrounds = [
			"background.legend_commander_druid",
			"background.legend_druid",
			"background.brawler",
			"background.legend_commander_berserker",
			"background.legend_berserker"
		]
	},
	function create()
	{
		this.m.ID = "actives.legend_kick";
		this.m.Name = "Kick";
		this.m.Description = "Kick a target to break their balance. Targets hit will be staggered, lowering initiative and defenses. Cancels Shieldwall, Spearwall, Return Favor, and Riposte.";
		this.m.Icon = "skills/kick_square.png";
		this.m.IconDisabled = "skills/kick_square_bw.png";
		this.m.Overlay = "active_kick";
		this.m.SoundOnUse = [
			"sounds/combat/knockback_01.wav",
			"sounds/combat/knockback_02.wav",
			"sounds/combat/knockback_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 3;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsSerialized = false;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 14;
		this.m.HitChanceBonus = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local p = this.getContainer().getActor().getCurrentProperties();
		local ret = [
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
			}
		];

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] chance to hit"
		});

		if (("IsSpecializedInFists" in _properties) && _properties.IsSpecializedInFists)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+"+ getBonus() +"[/color] from armor (Unarmed Mastery)"
			});
		}

		return ret;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			if (target.getFlags().has("StaggerImmunity"))
			{
				::Tactical.EventLog.logIn(this.Const.UI.getColorizedEntityName(target) + ::MSU.Text.colorRed(" is immune to stagger"));
				return true;
			}

			target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
			::Tactical.EventLog.logIn(this.Const.UI.getColorizedEntityName(target) + ::MSU.Text.colorRed(" has been staggered"));
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this) return;

		local actor = this.getContainer().getActor();

		_properties.MeleeSkill -= 25;
		this.m.HitChanceBonus = -25;
		_properties.DamageRegularMin += 5;
		_properties.DamageRegularMax += 10;
		_properties.DamageArmorMult = 0.5;
		_properties.FatigueDealtPerHitMult += 1.0;

		local mhand = actor.getMainhandItem();
		if (mhand != null)
		{
			_properties.DamageRegularMin -= mhand.m.RegularDamage;
			_properties.DamageRegularMax -= mhand.m.RegularDamageMax;
		}

		//Calculate damage
		if (("IsSpecializedInFists" in _properties) && _properties.IsSpecializedInFists)
		{
			_properties.DamageRegularMin += getBonus();
			_properties.DamageRegularMax += getBonus();
		}

		foreach( bg in this.m.Backgrounds )
		{
			if (actor.getSkills().hasSkill(bg))
			{
				_properties.DamageTotalMult *= 1.25;
				break;
			}
		}
	}

	function onAfterUpdate( _properties )
	{
		if ("IsSpecializedInFists" in _properties)
			this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function getBonus()
    {
        local total_weight = this.getContainer().getActor().getItems().getStaminaModifier([
            ::Const.ItemSlot.Body,
            ::Const.ItemSlot.Head
        ]) * -1;

		return ::Math.round(2 * ::Math.pow(total_weight, 0.5))
    }

});

