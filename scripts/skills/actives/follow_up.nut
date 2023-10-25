this.follow_up <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.follow_up";
		this.m.Name = "Follow Up";
		this.m.Icon = "skills/follow_up.png";
		this.m.IconDisabled = "skills/follow_up_bw.png";
		this.m.Overlay = "follow_up";
		this.m.SoundOnUse = [
			"sounds/combat/indomitable_01.wav",
			"sounds/combat/indomitable_02.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 30;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getDescription()
	{
		return "Prepare to attack any target in your attack range who gets hit by an ally.";
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		local actor = this.getContainer().getActor();
		if (actor.isEngagedInMelee())
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Not usable when engaged in melee."
			});
		}

		local weapon = actor.getMainhandItem();
		if (weapon == null || !weapon.isItemType(::Const.Items.ItemType.TwoHanded) || !weapon.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Only usable with Two-Handed Melee weapons."
			});
		}

		return ret;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled())
		{
			return;
		}

		local agent = actor.getAIAgent();

		if (agent.findBehavior(::Const.AI.Behavior.ID.FollowUp) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_follow_up"));
			agent.finalizeBehaviors();
		}
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		local weapon = actor.getMainhandItem();

		if (actor.isEngagedInMelee() || weapon == null || !weapon.isItemType(::Const.Items.ItemType.TwoHanded) || !weapon.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			return false;
		}

		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.ptr_follow_up");
	}

	function isHidden()
	{
		return !this.getContainer().getActor().isArmedWithMeleeWeapon();
	}

	function onUse( _user, _targetTile )
	{
		this.m.Container.add(::new("scripts/skills/effects/ptr_follow_up_effect"));
		return true;
	}
});
