::mods_hookExactClass("items/misc/anatomist/webknecht_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Spider";
        this.m.Description = "As any experienced beast hunter could tell you, what makes the overgrown arachnids known as Webknechts truly fearsome is their vicious poison. Imbimbing this potion grants the drinker the venom glands of a Webknecht and the ability to resist poisons as well as nightvision. The anatomist remarked that it was odd that this potion only granted three effects. Was he missing something? Where was the power of this species concentrated?";
        this.m.Value = 5000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "spider");

        _actor.getFlags().add("spider");
        _actor.getSkills().add(::new("scripts/skills/effects/serpent_potion_effect"));
        _actor.getSkills().add(::new("scripts/skills/effects/webknecht_potion_effect"));
        _actor.getSkills().add(::new("scripts/skills/effects/alp_potion_effect"));

        this.Sound.play("sounds/enemies/dlc2/giant_spider_death_0" + this.Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/giant_spider_flee_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/giant_spider_hurt_0" + this.Math.rand(1, 7) + ".wav", ::Const.Sound.Volume.Inventory);

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
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Venom Glands: Piercing or cutting attacks poison the target."
        });
        result.push({
            id = 11,
            type = "text",
            icon = "ui/icons/initiative.png",
            text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 15 + "[/color] Initiative"
        });
        result.push({
            id = 11,
            type = "text",
            icon = "ui/icons/melee_skill.png",
            text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 5 + "[/color] Melee Skill"
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Mutated Circulatory System: Immune to poison effects, including those of Webknechts and Goblins."
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/morale.png",
            text = "Enhanced Eye Rods: Not affected by nighttime penalties" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+2[/color] Vision"
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