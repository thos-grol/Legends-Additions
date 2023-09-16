this.indomitable <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.indomitable";
		this.m.Name = "Indomitable";
		this.m.Description = "Gather all this character\'s physical strength and willpower to become indomitable until next turn.";
		this.m.Icon = "ui/perks/perk_30_active.png";
		this.m.IconDisabled = "ui/perks/perk_30_active_sw.png";
		this.m.Overlay = "perk_30_active";
		this.m.SoundOnUse = [
			"sounds/combat/indomitable_01.wav",
			"sounds/combat/indomitable_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
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

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		local projected_hitpoints_pct = actor.getHitpoints() / actor.getHitpointsMax();
		return projected_hitpoints_pct <= 0.5;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		local projected_hitpoints_pct = (actor.getHitpoints() - _damageHitpoints) / actor.getHitpointsMax();
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.indomitable") && projected_hitpoints_pct > 0.5;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		if (!this.getContainer().hasSkill("effects.indomitable"))
		{
			this.m.Container.add(this.new("scripts/skills/effects/indomitable_effect"));
			return true;
		}

		return false;
	}

});

