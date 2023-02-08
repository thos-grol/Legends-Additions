//"Hyperactive Cell Growth";
//"This character\'s body has mutated to grow at an unnatural pace. In battle, this causes their wounds to close and heal within moments. Outside of battle, it causes unseemly growths, an unquenchable thirst, and disgustingly long finger nails. You once saw them lacerate both arms with a meat cleaver, screeching maniacally that it was \'the only way to keep it in check\'. Odd.";
::mods_hookExactClass("skills/effects/unhold_potion_effect", function (o)
{
    o.getTooltip = function()
    {
        local actor = this.getContainer().getActor();

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

        if (actor.getFlags().has("unhold_8"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/fatigue.png",
                text = "+" + ::MSU.Text.colorGreen( 5 ) + " Fatigue Recovery"
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "+" + ::MSU.Text.colorGreen( 40 ) + " Hitpoints"
            });
        }
        else if (actor.getFlags().has("unhold"))
        {
            ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "+" + ::MSU.Text.colorGreen( 3 ) + " Fatigue Recovery"
			});
			ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
				text = "+" + ::MSU.Text.colorGreen( 20 ) + " Hitpoints"
            });
        }



        if (actor.getFlags().has("unhold_8"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "Heals " + ::MSU.Text.colorGreen( "40" ) + " hitpoints each turn. Cannot heal if poisoned."
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/armor_body.png",
                text = "Heals " + ::MSU.Text.colorGreen( "40" ) + " head and body armor each turn.  Cannot heal if poisoned."
            });
        }
        else
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "Heals " + ::MSU.Text.colorGreen( "20" ) + " hitpoints each turn. Cannot heal if poisoned."
            });
        }

        ret.push({
            id = 12,
            type = "hint",
            icon = "ui/tooltips/warning.png",
            text = "Mutations of another sequence may cause this character's genes to spiral out of control, killing them in the process"
        });
        return ret;
    }

    o.onUpdate <- function(_properties)
	{
		if (this.getContainer().getActor().getFlags().has("unhold_8"))
		{
			_properties.FatigueRecoveryRate += 5;
			_properties.Hitpoints += 40;
		}
		else if (this.getContainer().getActor().getFlags().has("unhold"))
		{
			_properties.FatigueRecoveryRate += 3;
			_properties.Hitpoints += 20;
		}
	}

    local onCombatFinished = o.onCombatFinished;
    o.onCombatFinished = function()
    {
        local actor = this.getContainer().getActor();

        if (actor != null && !actor.isNull() && actor.isAlive())
        {
            actor.setHitpoints(actor.getHitpointsMax());

            if (actor.getFlags().has("unhold_8"))
            {
                local head = actor.getItems().getItemAtSlot(::Const.ItemSlot.Head);
                local body = actor.getItems().getItemAtSlot(::Const.ItemSlot.Body);

                if (head != null) head.setArmor(head.getArmorMax());
                if (body != null) body.setArmor(body.getArmorMax());
            }
            actor.setDirty(true);
        }
    }

    local onTurnStart = o.onTurnStart;
    o.onTurnStart = function()
    {
        local actor = this.getContainer().getActor();
        if (actor.getSkills().getSkillByID("effects.spider_poison") != null) return;
        if (actor.getSkills().getSkillByID("effects.legend_redback_spider_poison") != null) return;
        if (actor.getSkills().getSkillByID("effects.legend_RSW_poison_effect") != null) return;

        local regen_value = (actor.getFlags().has("unhold_8")) ? 40 : 20;
        local health_added = this.Math.min(actor.getHitpointsMax() - actor.getHitpoints(), regen_value);

        if (health_added > 0)
        {
            actor.setHitpoints(actor.getHitpoints() + health_added);
            actor.setDirty(true);

            if (!actor.isHiddenToPlayer())
            {
                this.spawnIcon("status_effect_79", actor.getTile());

                if (this.m.SoundOnUse.len() != 0) this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());

                this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + "\'s Hyperactive Cell Growth mutation regenerated " + health_added + " hitpoints");
            }
        }

        if (actor.getFlags().has("unhold_8"))
        {
            local head = actor.getItems().getItemAtSlot(::Const.ItemSlot.Head);
            local body = actor.getItems().getItemAtSlot(::Const.ItemSlot.Body);

            local head_added = head != null ? this.Math.min(head.getArmorMax() - head.getArmor(), 40) : 0;
            local body_added = body != null ? this.Math.min(body.getArmorMax() - body.getArmor(), 40) : 0;

            // if (head != null) this.logInfo("Head| Max armor: " + head.getArmorMax() + " | Curr Armor: " + head.getArmor() + " | Regen: " + head_added);
            // if (head != null) this.logInfo("Body| Max armor: " + body.getArmorMax() + " | Curr Armor: " + body.getArmor() + " | Regen: " + body_added);

            if (head_added > 0 || body_added > 0)
            {
                if (head != null) head.setArmor(head.getArmor() + head_added);
                if (body != null) body.setArmor(body.getArmor() + body_added);

                // if (head != null) this.logInfo("Head| New armor: " + head.getArmor());
                // if (body != null) this.logInfo("Body| New armor: " + body.getArmor());

                actor.setDirty(true);

                if (!actor.isHiddenToPlayer())
                {
                    this.spawnIcon("status_effect_79", actor.getTile());

                    if (this.m.SoundOnUse.len() != 0) this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());

                    if (head_added > 0) this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + "\'s Hyperactive Cell Growth mutation regenerated " + head_added + " points of head armor");

                    if (body_added > 0) this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + "\'s Hyperactive Cell Growth mutation regenerated " + body_added + " points of body armor");
                }
            }
        }

    }
});