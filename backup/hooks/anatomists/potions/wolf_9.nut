::mods_hookExactClass("items/misc/anatomist/direwolf_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Direwolf";
        this.m.Description = "The relentless vigor of a direwolf, bottled.";
        this.m.Value = 7500;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "werewolf");
        _actor.getFlags().add("werewolf");

        //1 Direwolf
        _actor.getSkills().add(::new("scripts/skills/effects/direwolf_potion_effect"));

        //2 Survival Instinct
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.PTRSurvivalInstinct, 0);

        //3 Underdog
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.Underdog, 1);

        //4 Menacing
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.PTRMenacing, 2);


        this.Sound.play("sounds/enemies/werewolf_idle_0" + ::Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/werewolf_idle_0" + ::Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/werewolf_idle_0" + ::Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/werewolf_hurt_0" + ::Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Direwolf: This character counts as a direwolf in skill checks. Not affected by night time penalties."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/fatigue.png",
            text = "+" + ::MSU.Text.colorGreen( "7" ) + " Fatigue Recovery"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "+" + ::MSU.Text.colorGreen( "15" ) + " Hitpoints"
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Survival Instinct: Every time you are attacked, gain +2 Melee and Ranged Defense on a miss and +5 on a hit. This bonus is reset every turn, but the retained bonus can be max 10."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Underdog: The defense malus due to being surrounded by opponents is reduced by [color=" + ::Const.UI.Color.NegativeValue + "]3[/color]."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Menacing: Your appearance gives your enemies a bit of doubt! [color=" + ::Const.UI.Color.Passive + "][u]Passive:[/u][/color]\n• Lower the Resolve of adjacent enemies by [color=" + ::Const.UI.Color.PositiveValue + "]-10[/color]."
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