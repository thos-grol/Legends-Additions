//fixes bug where unholds still heal when poisoned
::mods_hookExactClass("skills/racial/unhold_racial", function (o)
{
    o.onTurnStart = function()
    {
        local actor = this.getContainer().getActor();
        if (actor.getSkills().getSkillByID("effects.spider_poison") != null) return;
        if (actor.getSkills().getSkillByID("effects.legend_redback_spider_poison") != null) return;
        if (actor.getSkills().getSkillByID("effects.legend_RSW_poison_effect") != null) return;

        local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
        local healthAdded = ::Math.min(healthMissing, ::Math.floor(actor.getHitpointsMax() * 0.15));

        if (healthAdded <= 0) return;

        actor.setHitpoints(actor.getHitpoints() + healthAdded);
        actor.setDirty(true);

        if (!actor.isHiddenToPlayer())
        {
            this.spawnIcon("status_effect_79", actor.getTile());

            if (this.m.SoundOnUse.len() != 0)
            {
                this.Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
            }

            this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " regenerated " + healthAdded + " hitpoints");
        }

    }
});

::mods_hookExactClass("skills/racial/legend_rock_unhold_racial", function (o)
{
    o.onTurnStart = function()
    {
        local actor = this.getContainer().getActor();
        if (actor.getSkills().getSkillByID("effects.spider_poison") != null) return;
        if (actor.getSkills().getSkillByID("effects.legend_redback_spider_poison") != null) return;
        if (actor.getSkills().getSkillByID("effects.legend_RSW_poison_effect") != null) return;

        local totalBodyArmor = actor.getArmorMax(::Const.BodyPart.Body);
        local totalHeadArmor = actor.getArmorMax(::Const.BodyPart.Head);
        local currentBodyArmor = actor.getArmor(::Const.BodyPart.Body);
        local currentHeadArmor = actor.getArmor(::Const.BodyPart.Head);
        local missingBodyArmor = totalBodyArmor - currentBodyArmor;
        local missingHeadArmor = totalHeadArmor - currentHeadArmor;
        local healRateBody = totalBodyArmor * 0.1;
        local healRateHead = totalHeadArmor * 0.1;
        local addedBodyArmor = ::Math.abs(::Math.min(missingBodyArmor, healRateBody));
        local addedHeadArmor = ::Math.abs(::Math.min(missingHeadArmor, healRateBody));
        local newBodyArmor = currentBodyArmor + addedBodyArmor;
        local newHeadArmor = currentHeadArmor + addedHeadArmor;

        if (addedBodyArmor <= 0 && addedHeadArmor <= 0) return;

        actor.setArmor(::Const.BodyPart.Body, newBodyArmor);
        actor.setArmor(::Const.BodyPart.Head, newHeadArmor);
        actor.setDirty(true);

        if (!actor.isHiddenToPlayer())
        {
            this.spawnIcon("status_effect_79", actor.getTile());

            if (this.m.SoundOnUse.len() != 0)
            {
                this.Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
            }

            this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " regenerated " + addedBodyArmor + " points of body armor");
            this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " regenerated " + addedHeadArmor + " points of head armor");
        }

    }
});

::mods_hookExactClass("skills/racial/legend_bog_unhold_racial", function (o)
{
    o.onTurnStart = function()
	{
		local actor = this.getContainer().getActor();
        if (actor.getSkills().getSkillByID("effects.spider_poison") != null) return;
        if (actor.getSkills().getSkillByID("effects.legend_redback_spider_poison") != null) return;
        if (actor.getSkills().getSkillByID("effects.legend_RSW_poison_effect") != null) return;
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = ::Math.min(healthMissing, ::Math.floor(actor.getHitpointsMax() * 0.15));

		if (healthAdded <= 0)
		{
			return;
		}

		actor.setHitpoints(actor.getHitpoints() + healthAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.spawnIcon("status_effect_79", actor.getTile());

			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			}

			this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
		}
	}
});