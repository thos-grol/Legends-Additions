::mods_hookExactClass("items/misc/anatomist/orc_young_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Orc";
        this.m.Description = "Many a general has wished orcs might be tamed, for if one could control the greenskins and direct their strength with the intellect of man, they would surely control an unstoppable force. With this, such fantasies are within reach!";
        this.m.Value = 7500;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "orc");

        _actor.getSkills().removeByID("trait.tiny");
        _actor.getSkills().add(::new("scripts/skills/traits/huge_trait"));

        _actor.getFlags().add("orc");

        _actor.getSkills().add(::new("scripts/skills/effects/orc_young_potion_effect"));
        _actor.getSkills().add(::new("scripts/skills/effects/orc_warrior_potion_effect"));

        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.Colossus, 0, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_colossus"));

        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.PTRHaleAndHearty, 1, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_ptr_hale_and_hearty"));

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
            text = "Shock Absorbant Wrists: Attacks do [color=" + ::Const.UI.Color.PositiveValue + "]+15%[/color] additional damage"
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Sensory Redundancy: [color=" + ::Const.UI.Color.PositiveValue + "]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Colossus: Hitpoints are increased by [color=" + ::Const.UI.Color.PositiveValue + "]25%[/color], which also reduces the chance to sustain debilitating injuries when being hit."
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Hale and Hearty: Fatigue Recovery is increased by [color=" + ::Const.UI.Color.PositiveValue + "]5%[/color] of your Maximum Fatigue after gear."
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