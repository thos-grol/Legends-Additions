::mods_hookExactClass("items/misc/anatomist/webknecht_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Spider";
        this.m.Description = "Grants the drinker the ability to spit webs and poison their enemies.";
        this.m.Value = 7500;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "spider");
        _actor.getFlags().add("spider");

        //Mutated Circulatory System 1
        _actor.getSkills().add(::new("scripts/skills/effects/webknecht_potion_effect"));

        //Survival Instinct 4
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.PTRSurvivalInstinct, 0);

        this.Sound.play("sounds/enemies/dlc2/giant_spider_death_0" + this.Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/giant_spider_flee_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/giant_spider_hurt_0" + this.Math.rand(1, 7) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Mutated Circulatory System: Immune to poison effects. Not affected by nighttime penalties."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/melee_defense.png",
            text = "+" + ::MSU.Text.colorGreen( "7" ) + " Melee Defense"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "+" + ::MSU.Text.colorGreen( "10" ) + " Hitpoints"
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Spit Web: Spit a web at your foes and trap them."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Venom Glands: Piercing or cutting attacks poison the target for 10 damage, 3 turns."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Survival Instinct: Every time you are attacked, gain +2 Melee and Ranged Defense on a miss and +5 on a hit. This bonus is reset every turn, but the retained bonus can be max 10."
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