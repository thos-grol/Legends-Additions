//"Parasitic Blood";
//"This character\'s body has the incredible ability to incorporate different blood types - or indeed, blood from entirely different creatures - into itself. This grants them remarkable healing via absorption of blood through skin pores (or more dramatically by drinking it directly).";
::mods_hookExactClass("skills/effects/necrosavant_potion_effect", function (o)
{
    o.create = function()
	{
		this.m.ID = "effects.necrosavant_potion";
		this.m.Name = "Parasitic Blood";
		this.m.Icon = "skills/status_effect_133.png";
		this.m.IconMini = "status_effect_133_mini";
		this.m.Overlay = "status_effect_133";
		this.m.SoundOnUse = [
			"sounds/enemies/vampire_life_drain_01.wav",
			"sounds/enemies/vampire_life_drain_02.wav",
			"sounds/enemies/vampire_life_drain_03.wav"
		];
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

        if (this.getContainer().getActor().getFlags().has("vampire_8"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "Heal [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color] of hitpoint damage inflicted on adjacent enemies that have blood"
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Not affected by nighttime penalties"
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 30 + "[/color] Hitpoints"
            });

        }
        else
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "Heal [color=" + ::Const.UI.Color.PositiveValue + "]25%[/color] of hitpoint damage inflicted on adjacent enemies that have blood"
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Not affected by nighttime penalties"
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 15 + "[/color] Hitpoints"
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
        if (this.getContainer().getActor().getFlags().has("vampire_8"))
        {
            _properties.Hitpoints += 30;
        }
        else
        {
            _properties.Hitpoints += 15;
        }

    }

    local lifesteal = o.lifesteal;
    o.lifesteal = function( _damageInflictedHitpoints )
    {
        local actor = this.m.Container.getActor();
        this.spawnIcon("status_effect_09", actor.getTile());
        local hasMastery = this.getContainer().getActor().getFlags().has("vampire_8");
        local lifesteal_percent = hasMastery ? 0.50 : 0.25;

        local hitpointsHealed = this.Math.round(_damageInflictedHitpoints * lifesteal_percent);

        if (!actor.isHiddenToPlayer())
        {
            if (this.m.SoundOnUse.len() != 0)
            {
                this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect, actor.getPos());
            }

            this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " heals for " + this.Math.min(actor.getHitpointsMax() - actor.getHitpoints(), hitpointsHealed) + " points");
        }

        actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + hitpointsHealed));
        actor.onUpdateInjuryLayer();
    }
});


//Necrosavant potion can give the old swordmaster eternal life and remove his aging
::mods_hookExactClass("skills/effects/ptr_swordmaster_scenario_avatar_effect", function (o)
{
    o.onUpdate = function( _properties )
    {
        this.ptr_swordmaster_scenario_effect.onUpdate(_properties);

        local actor = this.getContainer().getActor();
        if (this.isEnabled())
        {
            local skillBonus = this.getSkillBonus();
            _properties.MeleeSkill += skillBonus;
            _properties.MeleeDefense += skillBonus;
            _properties.Bravery += skillBonus;
            _properties.DamageDirectAdd += skillBonus * 0.01;
        }

        if (!actor.getFlags().has("IsRejuvinated"))
        {
            local skillMalus = this.getSkillMalus();
            _properties.Stamina -= skillMalus;
            _properties.Initiative -= ::Math.floor(skillMalus * 1.5);
            _properties.Hitpoints -= skillMalus;
            _properties.FatigueEffectMult *= 1.0 + 2 * skillMalus * 0.01;
        }
    }

    local getSkillMalus = o.getSkillMalus;
    o.getSkillMalus = function()
    {
        local actor = this.getContainer().getActor();
        if (actor.getFlags().has("IsRejuvinated")) return 0;

        if (this.World.Flags.get("PTR_SwordmasterScenario_OldAgeEvent_1"))
        {
            return this.Math.min(30, this.Math.max(1, (this.World.getTime().Days - this.m.OldAgeStartDays) / 10));
        }

        return 0;
    }

    local onNewDay = o.onNewDay;
    o.onNewDay = function()
    {
        if (this.World.getPlayerRoster().getAll().len() < 3)
        {
            this.m.DaysWithoutRecruits++;
            if (this.m.DaysWithoutRecruits > 25)
            {
                this.World.Events.fire("event.ptr_swordmaster_scenario_no_recruits_force_end");
            }
        }

        local actor = this.getContainer().getActor();
        if (actor.getFlags().has("IsRejuvinated"))
        {
            if (!actor.getFlags().has("IsRejuvinated_addback"))
            {
                actor.getBackground().addPerk(::Const.Perks.PerkDefs.PTRSwordmasterJuggernaut, 3, false);
                actor.getSkills().add(::new("scripts/skills/perks/perk_ptr_swordmaster_juggernaut"));

                actor.getBackground().addPerk(::Const.Perks.PerkDefs.PTRSwordmasterGrappler, 3, false);
                actor.getSkills().add(::new("scripts/skills/perks/perk_ptr_swordmaster_grappler"));

                actor.getBackground().addPerk(::Const.Perks.PerkDefs.PTRSwordmasterReaper, 3, false);
                actor.getSkills().add(::new("scripts/skills/perks/perk_ptr_swordmaster_reaper"));

                actor.getBackground().addPerk(::Const.Perks.PerkDefs.PTRSwordmasterBladeDancer, 3, false);
                actor.getSkills().add(::new("scripts/skills/perks/perk_ptr_swordmaster_blade_dancer"));

                actor.getFlags().add("IsRejuvinated_addback");
            }
            return;
        }


        local bros = this.World.getPlayerRoster().getAll();
        local hasMet = this.World.Flags.get("PTR_SwordmasterScenario_OldAgeEvent_1");

        if (!hasMet && bros.len() >= 3 && this.World.getTime().Days >= this.m.OldAgeStartDays)
        {
            if (this.World.Events.fire("event.ptr_swordmaster_scenario_old_age_1"))
            {
                this.World.Flags.set("PTR_SwordmasterScenario_OldAgeEvent_1", true);
            }
        }

        hasMet = this.World.Flags.get("PTR_SwordmasterScenario_OldAgeEvent_2");

        if (!hasMet && bros.len() >= 3 && this.World.getTime().Days >= this.m.OldAgeStartDays * 2)
        {
            if (this.World.Events.fire("event.ptr_swordmaster_scenario_old_age_2"))
            {
                this.World.Flags.set("PTR_SwordmasterScenario_OldAgeEvent_2", true);
            }
        }

        hasMet = this.World.Flags.get("PTR_SwordmasterScenario_OldAgeEvent_3");

        if (!hasMet && bros.len() >= 3 && this.World.getTime().Days >= this.m.OldAgeStartDays * 3)
        {
            if (this.World.Events.fire("event.ptr_swordmaster_scenario_old_age_3"))
            {
                this.World.Flags.set("PTR_SwordmasterScenario_OldAgeEvent_3", true);
            }
        }

        hasMet = this.World.Flags.get("PTR_SwordmasterScenario_OldAgeEvent_4");

        if (!hasMet && bros.len() >= 3 && this.World.getTime().Days >= this.m.OldAgeStartDays * 4)
        {
            if (this.World.Events.fire("event.ptr_swordmaster_scenario_old_age_4"))
            {
                this.World.Flags.set("PTR_SwordmasterScenario_OldAgeEvent_4", true);
            }
        }


    }
});