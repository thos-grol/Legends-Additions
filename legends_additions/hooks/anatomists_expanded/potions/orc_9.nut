::mods_hookExactClass("items/misc/anatomist/orc_warlord_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 8: Warlord";
        this.m.Description = "Borne from the study of the renown Orc Warlord, this potion improves upon that of the previous sequence, allowing one to wield heavy orc weapons with ease as well as letting an orc\'s rage flow through one\'s veins.";
        this.m.Value = 15000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "orc");

        _actor.getSkills().removeByID("trait.tiny");
        _actor.getSkills().add(::new("scripts/skills/traits/huge_trait"));

        _actor.getFlags().add("orc");
        _actor.getFlags().add("orc_8");

        _actor.getSkills().add(::new("scripts/skills/effects/orc_warlord_potion_effect"));
        _actor.getSkills().add(::new("scripts/skills/effects/orc_berserker_potion_effect"));

        this.Sound.play("sounds/enemies/orc_death_0" + this.Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/orc_flee_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/orc_hurt_0" + this.Math.rand(1, 7) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Induces major growth."
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Warlord: Improves upon the effects of the sequence 9 potion. \n[color=" + ::Const.UI.Color.PositiveValue + "]+15[/color]% Damage" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Improved Limbic System: Using orc weapons no longer imposes additional fatigue costs" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Fatigue"
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Hyperactive Glands: This character gains two stacks of Rage each time they take hitpoint damage, and loses one stack at the end of each turn. Rage improves damage reduction and other combat stats."
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