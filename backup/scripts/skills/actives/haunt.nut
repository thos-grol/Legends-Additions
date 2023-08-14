this.haunt <- this.inherit("scripts/skills/magic_skill", {
	m = {},
	function create()
	{
		//FEATURE_5: Haunt skill
		//FEATURE_5: Haunt perk
		this.magic_skill.create();
		this.m.ID = "actives.haunt";
		this.m.Name = "Haunt";
		this.m.Description = "Summons Geists to haunt the target.";
		this.m.Icon = "ui/perks/haunt.png";
		this.m.IconDisabled = "ui/perks/haunt_bw.png";
		this.m.Overlay = "deathtouch_square";
		this.m.SoundOnUse = [
			"sounds/enemies/ghastly_touch_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.MinRange = 1;
		this.m.MaxRange = 7;
		this.m.MaxLevelDifference = 4;
		this.m.Cooldown_Max = 4,
		this.m.ActionPointCost = 6;
		this.m.ManaCost = 4;
		this.m.FatigueCost = 40;
	}

	function onUpdate()
	{
		local a = this.getContainer().getActor();
		if (a.getSkills().hasSkill("perk.meditation_underworld_thoughts"))
		{
			this.m.ManaCost = this.Math.min(1, this.m.ManaCost - 1);
		}
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Costs " + this.m.ManaCost + " mana."
		});
		if (this.m.Cooldown > 0)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Usable in " + this.m.Cooldown + " turns."
			});
		}
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local _target =_targetTile.getEntity();

		local HIT_CHANCE = getHitchance(_target);
		local ROLL = this.Math.rand(1, 100);

		if (ROLL > HIT_CHANCE) return false;

		local effect = _target.getSkills().getSkillByID("effects.anguish");
		if (effect == null)
		{
			_target.getSkills().add(::new("scripts/skills/effects/anguish_effect"));
			effect = _target.getSkills().getSkillByID("effects.anguish");
			local a = this.getContainer().getActor();
			if (a.getSkills().hasSkill("perk.spreading_anguish")) effect.m.SpreadingAnguish = true;
			if (a.getSkills().hasSkill("perk.torment_soul")) effect.m.TormentSoul = true;
		}
		effect.m.TurnsLeft = this.m.Duration;
		//FEATURE_5: Haunt fx
		//Make blue temporary fire fx on spawn

		return true;
	}

	function getHitchance( _targetEntity )
	{
		local WILL = _targetEntity.getBravery();
		if (WILL > 200) return 0;
		else if (WILL > 150) return 25;
		else if (WILL > 100) return 50;
		else return 100;
	}

});

