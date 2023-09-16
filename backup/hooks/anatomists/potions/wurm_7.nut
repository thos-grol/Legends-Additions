::mods_hookExactClass("items/misc/anatomist/orc_warrior_potion_item", function (o)
{
    
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 7: Stollwurm";
        this.m.Description = "This potion further improves upon the perfect body, granting the drinker dragon's might and acidic blood. ";
        this.m.Icon = "consumables/potion_27.png";
        this.m.Value = 30000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "wurm");
        _actor.getFlags().add("wurm");
        _actor.getFlags().add("wurm_8");

        _actor.getSkills().add(::new("scripts/skills/effects/lindwurm_potion_effect"));
        _actor.getSkills().add(::new("scripts/skills/effects/orc_warrior_potion_effect"));

        _actor.getSkills().add(::new("scripts/skills/passives/dragons_might"));

        this.Sound.play("sounds/enemies/lindwurm_death_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/lindwurm_flee_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/lindwurm_hurt_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);

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
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Dragon's Might: Weaker form of Dragon's Might with range of 1 tile."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Attacks do +[color=" + ::Const.UI.Color.PositiveValue + "]" + 25 + "[/color]% damage."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Acidic Blood: This character\'s blood is acidic, spraying and corroding those who harm them. This character\'s body becomes immune to lindwurm and stollwurm blood, but not their armor."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 30 + "[/color] Hitpoints"
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