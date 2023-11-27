this.inspire_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.inspire";
		this.m.Name = "Command";
		this.m.Description = "Command a unit to strike, granting them additional Action Points. Targets can only be inspired once per turn.";
		this.m.Icon = "skills/inspire.png";
		this.m.IconDisabled = "skills/inspire_bw.png";
		this.m.Overlay = "perk_28_active";
		this.m.SoundOnUse = [
			"sounds/combat/inspire_01.wav",
			"sounds/combat/inspire_02.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 4;
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
				text = "Grants the target 4 additional Action Points for their next turn."
			}
		];
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (!this.m.Container.getActor().isAlliedWith(_targetTile.getEntity()))
		{
			return false;
		}

		if (_targetTile.getEntity().getSkills().hasSkill("effects.inspired"))
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		target.getSkills().add(::new("scripts/skills/effects/inspired_effect"));
		return true;
	}

});

