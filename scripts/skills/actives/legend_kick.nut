this.legend_kick <- this.inherit("scripts/skills/skill", {
	m = {
		StaggerChance = 30
	},
	function create()
	{
		this.m.ID = "actives.legend_kick";
		this.m.Name = "Kick";
		this.m.Description = "Kick a target to break their balance. Targets hit will receive fatigue, get staggered, and a chance of daze. Shieldwall, Spearwall, Return Favor, and Riposte will be canceled for a target that is successfully hit.";
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
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 14;
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
			text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] chance to hit"
		});

		if (p.IsSpecializedInFists)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]60%[/color] chance to stagger on a hit"
			});
			
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]30%[/color] chance to stagger on a hit"
			});
		}

		ret.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + this.Const.Combat.FatigueReceivedPerHit * 2 + "[/color] fatigue on hit"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local hasFistMastery = _user.getSkills().hasSkill("perk.mastery_fist");
		local skills = target.getSkills();

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		if (this.Math.rand(1, 100) > this.getHitchance(target))
		{
			target.onMissed(this.getContainer().getActor(), this);
			return false;
		}

		this.applyFatigueDamage(target, 10);
		::Tactical.EventLog.logIn(this.Const.UI.getColorizedEntityName(target) + ::MSU.Text.colorRed(" suffers 10 fatigue damage"));
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");
		skills.removeByID("effects.return_favor");

		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		if (target.getFlags().has("StaggerImmunity"))
		{
			::Tactical.EventLog.logIn(this.Const.UI.getColorizedEntityName(target) + ::MSU.Text.colorRed(" is immune to stagger"));
			return true;
		}

		if (hasFistMastery) this.m.StaggerChance = 60;
		if (this.Math.rand(1, 100) <= this.m.StaggerChance)
		{
			target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
			::Tactical.EventLog.logIn(this.Const.UI.getColorizedEntityName(target) + ::MSU.Text.colorRed(" has been staggered"));
		}

		return true;
	}

	function onAfterUpdate( _properties )
	{
		if ("IsSpecializedInFists" in _properties)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += 5;
		}
	}

});

