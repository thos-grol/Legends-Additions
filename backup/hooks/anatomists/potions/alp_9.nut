::mods_hookExactClass("items/misc/anatomist/alp_potion_item", function (o)
{
    //FEATURE_8:: Rebalance Alp 9 potion
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Alp";
        this.m.Description = "This draft, the ret of intensive study into the so-called \'Third Eye\' of the Alp, allows whomever drinks it to see through the night as if it were day, see into the minds of others and torment them with nightmares! Blurry vision and hallucinations are expected while the body acclimates. It seems the body also changes to these potent mutagens. ";
        this.m.Icon = "consumables/potion_34.png";
        this.m.Value = 15000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "alp");
        _actor.getFlags().add("alp");

        //Add mad, paranoid

        //
        _actor.getSkills().add(::new("scripts/skills/effects/alp_potion_effect"));
        //Resolve (15, 30)

        //2
        _actor.getSkills().add(::new("scripts/skills/actives/nightmare_player"));
        _actor.getSkills().add(::new("scripts/skills/actives/sleep_player"));

        //3 Mind Over Body

        _actor.getSkills().add(::new("scripts/skills/effects/honor_guard_potion_effect"));

        this.Sound.play("sounds/enemies/dlc2/alp_death_0" + this.Math.rand(1, 5) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/alp_idle_0" + this.Math.rand(1, 9) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/alp_hurt_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/alp_nightmare_0" + this.Math.rand(1, 6) + ".wav", ::Const.Sound.Volume.Inventory);

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
            icon = "ui/icons/special.png",
            text = "Nightmare: Torment the victim's soul with nightmares, bringing them ever closer to oblivion."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Sleep: Lull them into the land of dreams."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/morale.png",
            text = "Enhanced Eye Rods: Not affected by nighttime penalties" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+2[/color] Vision"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/morale.png",
            text = "This character takes between [color=" + ::Const.UI.Color.PositiveValue + "]25%[/color] and [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color] less damage from piercing attacks, such as those from bows or spears" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
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