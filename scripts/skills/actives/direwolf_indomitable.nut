this.direwolf_indomitable <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 2,
		Cooldown_Max = 2
	},
	function create()
	{
		this.m.ID = "actives.direwolf_indomitable";
		this.m.Name = "Indomitable";
		this.m.Description = "Gather all this character\'s physical strength and willpower to become indomitable until next turn.";
		this.m.Icon = "ui/perks/perk_30_active.png";
		this.m.IconDisabled = "ui/perks/perk_30_active_sw.png";
		this.m.Overlay = "perk_30_active";
		this.m.SoundOnUse = [
			"sounds/monster/direwolf_ruin_end.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only receive [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] of any damage"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Become immune to being stunned"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Become immune to being knocked back or grabbed"
			}
		];
	}

	function onTurnStart()
	{
		this.m.Cooldown = this.Math.max(0, this.m.Cooldown - 1);
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		return this.skill.isUsable() 
			&& !this.getContainer().hasSkill("effects.indomitable") 
			&& this.m.Cooldown == 0
			&& !actor.getFlags().has("la_direwolf_frenzy_attacks");
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = this.m.Cooldown_Max;

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			::Tactical.EventLog.logEx(
				::Z.Log.display_basic(_user, null, "Indomitable", false)
			);
			::Z.Log.HasActed = true;
		}

		if (!this.getContainer().hasSkill("effects.indomitable"))
		{
			this.m.Container.add(this.new("scripts/skills/effects/indomitable_effect"));
			return true;
		}
		
		return false;
	}

});

