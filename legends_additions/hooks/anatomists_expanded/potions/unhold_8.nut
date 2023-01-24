::mods_hookExactClass("items/misc/anatomist/ancient_priest_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 8: Mountain";
        this.m.Description = "From research on the legendary rock unhold, this potion improves upon the previous sequence\'s, granting the drinker increased regeneration and creating natural armor on their body that regenerates.";
        this.m.Icon = "consumables/potion_32.png";
        this.m.Value = 20000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "unhold");

        _actor.getSkills().removeByID("trait.tiny");
        _actor.getSkills().add(::new("scripts/skills/traits/huge_trait"));
        _actor.getFlags().add("unhold");
        _actor.getFlags().add("unhold_8");
        _actor.getSkills().add(::new("scripts/skills/effects/unhold_potion_effect"));
        _actor.getSkills().add(::new("scripts/skills/effects/orc_warrior_potion_effect"));

        this.Sound.play("sounds/enemies/unhold_death_0" + this.Math.rand(1, 6) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/unhold_flee_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/unhold_hurt_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);

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
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "Heals [color=" + ::Const.UI.Color.PositiveValue + "]10[/color] hitpoints each turn. Cannot heal if poisoned."
        });
        result.push({
            id = 11,
            type = "text",
            icon = "ui/icons/armor_body.png",
            text = "Heals [color=" + ::Const.UI.Color.PositiveValue + "]20[/color] head and body armor each turn.  Cannot heal if poisoned."
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Sensory Redundancy: [color=" + ::Const.UI.Color.PositiveValue + "]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
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