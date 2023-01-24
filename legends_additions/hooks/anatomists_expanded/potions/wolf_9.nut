::mods_hookExactClass("items/misc/anatomist/direwolf_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Direwolf";
        this.m.Description = "This humoural concoction, borne from research into the dreaded direwolf, will turn even the clumsiest oaf into a lithe dancer of a warrior, able to gracefully move with the tides of battle long after lesser men succumb to fatigue! Mild akathisia after consuming is normal and expected.";
        this.m.Value = 5000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "werewolf");

        _actor.getFlags().add("werewolf");
        _actor.getSkills().add(::new("scripts/skills/racial/werewolf_player_racial"));
        _actor.getSkills().add(::new("scripts/skills/effects/direwolf_potion_effect"));
        _actor.getSkills().add(::new("scripts/skills/effects/alp_potion_effect"));

        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.PTRSurvivalInstinct, 1, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_ptr_survival_instinct"));

        this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/werewolf_hurt_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);

        return this.anatomist_potion_item.onUse(_actor, _item);
    }

    o.getTooltip = function()
    {
        local result = [
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
        result.push({
            id = 66,
            type = "text",
            text = this.getValueString()
        });

        if (this.getIconLarge() != null)
        {
            result.push({
                id = 3,
                type = "image",
                image = this.getIconLarge(),
                isLarge = true
            });
        }
        else
        {
            result.push({
                id = 3,
                type = "image",
                image = this.getIcon()
            });
        }

        result.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Direwolf: This character counts as a direwolf in skill checks, and inherits the direwolf's racial traits; that is inflicting more damage in proportion to missing health."
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/morale.png",
            text = "Elasticized Sinew: Attacks that miss have [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color] of their Fatigue cost refunded" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Fatigue"
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/morale.png",
            text = "Enhanced Eye Rods: Not affected by nighttime penalties" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+2[/color] Vision"
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Survival Instinct: Every time you are attacked, gain +2 Melee and Ranged Defense on a miss and +5 on a hit. The bonus is reset at the start of every turn except the bonus gained from getting hit which is retained for the rest of the combat. This retained bonus cannot be higher than +10."
        });
        result.push({
            id = 65,
            type = "text",
            text = "Right-click or drag onto the currently selected character in order to drink. Will refund owned perks. Will not give points for traits."
        });
        result.push({
            id = 65,
            type = "hint",
            icon = "ui/tooltips/warning.png",
            text = "Mutates the body. Side effects include sickness and if potions of different sequences are mixed, death."
        });
        return result;
    }
});