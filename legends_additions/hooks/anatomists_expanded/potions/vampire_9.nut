::mods_hookExactClass("items/misc/anatomist/necrosavant_potion_item", function (o)
{
    //FEATURE_2: Vampire 9 potion
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Vampire";
        this.m.Description = "Life everlasting.";
        this.m.Value = 25000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "vampire");
        _actor.getFlags().add("vampire");

        //Remove Old
        _actor.getSkills().removeByID("trait.old");
        _actor.getFlags().add("IsRejuvinated", true);


        _actor.getSkills().add(::new("scripts/skills/effects/necrosavant_potion_effect"));

        //Add lacerate
        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.NineLives, 0, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_nine_lives"));

        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.PTRBloodlust, 1, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_ptr_bloodlust"));

        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.PTRSanguinary, 2, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_ptr_sanguinary"));

        this.Sound.play("sounds/enemies/vampire_hurt_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/vampire_death_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/vampire_idle_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);

        return this.anatomist_potion_item.onUse(_actor, _item);
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
            id = 66,
            type = "text",
            text = this.getValueString()
        });

        if (this.getIconLarge() != null)
        {
            ret.push({
                id = 3,
                type = "image",
                image = this.getIconLarge(),
                isLarge = true
            });
        }
        else
        {
            ret.push({
                id = 3,
                type = "image",
                image = this.getIcon()
            });
        }

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "Parasitic Blood: Heal [color=" + ::Const.UI.Color.PositiveValue + "]15%[/color] of hitpoint damage inflicted on adjacent enemies that have blood" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints." + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+5[/color] Melee Skill."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Nine Lives: Once per battle, upon receiving a killing blow, survive instead with a few hitpoints left and have all damage over time effects cured. Also grants a one in nine chance to survive a fatal blow with an injury."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Bloodlust: Attacks on bleeding targets restore fatigue."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Sanguinary: Increases the chance to inflict fatalities and fatalities restore fatigue. Attacks against bleeding targets improve your morale."
        });
        ret.push({
            id = 65,
            type = "text",
            text = "Right-click or drag onto the currently selected character in order to drink. Will refund owned perks. Will not give points for traits."
        });
        ret.push({
            id = 65,
            type = "hint",
            icon = "ui/tooltips/warning.png",
            text = "Mutates the body. Side effects include sickness and if potions of different sequences are mixed, death."
        });
        return ret;
    }
});