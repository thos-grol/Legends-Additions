//"Sensory Redundancy";
//"This character\'s body has mutated to develop a number of redundant synapses, allowing them to maintain a degree of control over sight, hearing, and muscle control even when struck with debilitating blows.";
::mods_hookExactClass("skills/effects/orc_warrior_potion_effect", function (o)
{
    o.create = function()
	{
		this.m.ID = "effects.orc_warrior_potion";
		this.m.Name = "Sensory Redundancy";
		this.m.Icon = "skills/status_effect_128.png";
		this.m.IconMini = "status_effect_128_mini";
		this.m.Overlay = "status_effect_128";
        this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

    o.getTooltip = function()
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
            }
        ];

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "[color=" + ::Const.UI.Color.PositiveValue + "]50%[/color] chance to resist being Baffled, Dazed, or Stunned"
        });

        ret.push({
            id = 12,
            type = "hint",
            icon = "ui/tooltips/warning.png",
            text = "Mutations of another sequence may cause this character's genes to spiral out of control, killing them in the process"
        });

        return ret;
    }
});

::mods_hookExactClass("skills/effects/legend_baffled_effect", function (o)
{
    o.onAdded = function()
	{
		local actor = this.getContainer().getActor();
        if (actor.getCurrentProperties().IsResistantToPhysicalStatuses ? ::Math.rand(1, 100) <= 50 : false)
		{
			if (!actor.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " wasn't baffled thanks to their unnatural physiology");
			}

			this.removeSelf();
		}
        else if (!this.m.Container.getActor().getCurrentProperties().IsImmuneToStun)
		{
			this.m.Container.removeByID("effects.shieldwall");
			this.m.Container.removeByID("effects.spearwall");
			this.m.Container.removeByID("effects.riposte");
			this.m.Container.removeByID("effects.return_favor");
			this.m.Container.removeByID("effects.possessed_undead");
			this.m.Container.removeByID("effects.legend_vala_currently_chanting");
			this.m.Container.removeByID("effects.legend_vala_in_trance");
		}
		else
		{
			this.m.IsGarbage = true;
		}
	}

});

::mods_hookExactClass("skills/effects/dazed_effect", function (o)
{
    o.onAdded = function()
	{
		local actor = this.getContainer().getActor();
        if (actor.getCurrentProperties().IsResistantToPhysicalStatuses ? ::Math.rand(1, 100) <= 50 : false)
		{
			if (!actor.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " wasn't dazed thanks to their unnatural physiology");
			}

			this.removeSelf();
		}
        else if (!actor.getCurrentProperties().IsImmuneToDaze) this.m.TurnsLeft = ::Math.max(1, 2 + actor.getCurrentProperties().NegativeStatusEffectDuration);
		else this.m.IsGarbage = true;
	}

});

::mods_hookExactClass("skills/effects/stunned_effect", function (o)
{
    o.onAdded = function()
	{
		local actor = this.getContainer().getActor();
        if (actor.getCurrentProperties().IsResistantToPhysicalStatuses ? ::Math.rand(1, 100) <= 50 : false)
		{
			if (!actor.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " wasn't stunned thanks to their unnatural physiology");
			}

			this.removeSelf();
		}
        else if (!actor.getCurrentProperties().IsImmuneToStun)
		{
			this.m.Container.removeByID("effects.shieldwall");
			this.m.Container.removeByID("effects.spearwall");
			this.m.Container.removeByID("effects.riposte");
			this.m.Container.removeByID("effects.return_favor");
			this.m.Container.removeByID("effects.possessed_undead");
			this.m.Container.removeByID("effects.legend_vala_currently_chanting");
			this.m.Container.removeByID("effects.legend_vala_in_trance");
		}
		else this.m.IsGarbage = true;

	}

});

//Remove distracted effect from immunity
::mods_hookExactClass("skills/effects/distracted_effect", function (o)
{
    o.onAdded = function()
	{
		local actor = this.getContainer().getActor();
        this.m.TurnsLeft = ::Math.max(1, 1 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

});

::mods_hookExactClass("skills/effects/staggered_effect", function (o)
{
    o.onAdded = function()
	{
		local actor = this.getContainer().getActor();
        if (actor.getSkills().hasSkill("trait.sure_footing") ? ::Math.rand(1, 100) <= 50 : false)
        {
            if (!actor.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " wasn't staggered due to their sure footing");
			}

			this.removeSelf();

        }
        else
        {
            this.m.TurnsLeft = ::Math.max(1, 2 + actor.getCurrentProperties().NegativeStatusEffectDuration);
		    this.Tactical.TurnSequenceBar.pushEntityBack(actor.getID());
        }

	}

});

    ::mods_hookExactClass("skills/traits/sure_footing_trait", function (o)
    {
        o.getTooltip = function()
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
                    id = 10,
                    type = "text",
                    icon = "ui/icons/melee_defense.png",
                    text = "[color=" + ::Const.UI.Color.PositiveValue + "]+5[/color] Melee Defense"
                },
                {
                    id = 10,
                    type = "text",
                    icon = "ui/icons/special.png",
                    text = "Has a 50% chance to not be staggered"
                }
            ];
        }

    });

::mods_hookExactClass("skills/effects/withered_effect", function (o)
{
    o.onAdded = function()
	{
		local actor = this.getContainer().getActor();
        this.m.TurnsLeft = ::Math.max(2, 2 + actor.getCurrentProperties().NegativeStatusEffectDuration);
	}

});



