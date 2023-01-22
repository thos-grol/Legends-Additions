this.battle_meditation <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.battle_meditation";
		this.m.Name = "Battle Meditation";
		this.m.Description = "Take a deep breath and rest for a turn in order to recover your strength.";
		this.m.Icon = "skills/active_legend_vala_chanting.png";
		this.m.IconDisabled = "skills/active_legend_vala_chanting_sw.png";
		this.m.Overlay = "perk_54_active";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.BeforeLast;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
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
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Current Fatigue is reduced by [color=" + this.Const.UI.Color.PositiveValue + "]" + fatReduc + "%[/color] of maximum fatigue"
			}
		];
		return ret;
	}

	function onTurnStart()
	{
		this.m.CanRecover = true;
		this.m.AP = 0;
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.m.CanRecover;
	}

	function getActionPointCost()
	{
		local actor = this.getContainer().getActor();
		return actor.getActionPoints();
	}

	function onBeforeUse( _user, _targetTile )
	{
		this.m.AP = _user.getActionPoints();
	}

	function onUse( _user, _targetTile )
	{
		local actor = this.getContainer().getActor();
		local fatMult = this.m.AP * 0.055;
		_user.setFatigue(_user.getFatigue() - fatMult * _user.getFatigueMax());

		local CHANCE = 3;
		local mana_pool = _user.getSkills().getSkillByID("trait.mana_pool");
		local total = 0;
		for( local i = 0; i < this.m.AP;  i = ++i )
		{
			local ROLL = this.Math.rand(1, 10);
			if (ROLL <= CHANCE)
			{
				mana_pool.add_mana(1);
				total += 1;
			}
		}

		if (!_user.isHiddenToPlayer())
		{
			_user.playSound(this.Const.Sound.ActorEvent.Fatigue, this.Const.Sound.Volume.Actor * _user.getSoundVolume(this.Const.Sound.ActorEvent.Fatigue));
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " recovers " + total + "mana.");
		}

		return true;
	}

});

