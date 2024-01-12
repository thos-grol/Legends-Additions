this.cultist_devotion <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.devotion";
		this.m.Name = ::Const.Strings.PerkName.Devotion;
		this.m.Description = ::Const.Strings.PerkDescription.Devotion;
		this.m.Icon = "ui/perks/dedication_circle2.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

    function getTooltip()
	{
		local actor = this.getContainer().getActor();
        local resolve = actor.getCurrentProperties().getBravery();
        local multiplier = 0.15;
        local skills = actor.getSkills().getAllSkillsOfType(::Const.SkillType.Injury);
        foreach( s in skills )
        {
            if (s.isType(::Const.SkillType.PermanentInjury)) multiplier += 0.05;
        }
        local total = ::Math.floor(resolve * multiplier);

		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = "In Pain we find the truth of ourselves. We have no identity beyond servitude, our glory is agony."
			},
            {
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::MSU.Text.colorGreen( multiplier * 100 ) + "% of resolve is added to defenses."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "+" + ::MSU.Text.colorGreen( total ) + " Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "+" + ::MSU.Text.colorGreen( total ) + " Ranged Defense"
			}
		];

		if (actor.getSkills().hasSkill("perk.perk_legend_specialist_cult_armor"))
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Penance: This character's morale is no longer affected by their allies dying or by taking damage."
			});
		}

		return ret;
	}

	function getValid()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Head);
		return item != null && item.isItemType(::Const.Items.ItemType.Cultist);
	}

	function onAfterUpdate( _properties )
	{
		if (this.getValid())
		{
			local actor = this.getContainer().getActor();
            local resolve = actor.getCurrentProperties().getBravery();
            local multiplier = 0.15;
            local skills = actor.getSkills().getAllSkillsOfType(::Const.SkillType.Injury);

            foreach( s in skills )
            {
                if (s.isType(::Const.SkillType.PermanentInjury)) multiplier += 0.05;
            }

            local total = ::Math.floor(resolve * multiplier);

			_properties.MeleeDefense += total;
			_properties.RangedDefense += total;
		}
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlayerControlled()) return;
		if (!actor.getSkills().hasSkill("perk.dodge")) return;
		actor.m.Skills.removeByID("perk.dodge");
		actor.m.PerkPoints += 1;
		actor.m.PerkPointsSpent -= 1;
	}

});