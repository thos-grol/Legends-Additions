::mods_hookExactClass("items/misc/anatomist/wiederganger_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 8: Black Widow";
        this.m.Description = "It turns out that most the strength of this species is focused on in it's poison making abilities. With research into the legendary Redback Spider, this potion improves upon the poison of the previous sequence, allowing the drinker to poison your enemies with redback poison when cutting or piercing them. They also gain the ability to spit webs at their foes among other improvements.";
        this.m.Value = 10000;
        this.m.Icon = "consumables/potion_31.png";
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "spider");

        _actor.getFlags().add("spider");
        _actor.getFlags().add("spider_8");

        _actor.getSkills().add(::new("scripts/skills/effects/serpent_potion_effect"));
        _actor.getSkills().add(::new("scripts/skills/perks/perk_legend_item_web_skill"));

        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.Nimble, 0, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_nimble"));

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
            text = "Venom Glands: Piercing or cutting attacks poison the target with redback poison."
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
            text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 10 + "[/color] Melee Skill"
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Spit Web: Spit a web at your foes and trap them."
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Nimble: Specialize in light armor! By nimbly dodging or deflecting blows, convert any hits to glancing hits. Hitpoint damage taken is reduced by up to [color=" + ::Const.UI.Color.PositiveValue + "]60%[/color], but lowered exponentially by the total penalty to Maximum Fatigue from body and head armor above 15."
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