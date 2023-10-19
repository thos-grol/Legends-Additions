this.perfect_focus <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.perfect_focus";
		this.m.Name = "Perfect Focus";
		this.m.Description = "Become one with your weapon and gain perfect focus as if time itself were to stand still.";
		this.m.Icon = "skills/perfectfocus_square.png";
		this.m.IconDisabled = "skills/perfectfocus_square_bw.png";
		this.m.Overlay = "perk_37_active";
		this.m.SoundOnUse = [
			"sounds/combat/perfect_focus_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.BeforeLast;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 0;
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
				text = "The Action Point cost for using skills is reduced by half for the remainder of this round, but at +75% fatigue cost"
			}
		];
		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.perfect_focus");
	}

	function onUse( _user, _targetTile )
	{
		if (!this.getContainer().hasSkill("effects.perfect_focus"))
		{
			this.m.Container.add(::new("scripts/skills/effects/perfect_focus_effect"));
			return true;
		}

		return false;
	}

});

