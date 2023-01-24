::mods_hookExactClass("items/misc/anatomist/unhold_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Unhold";
        this.m.Description = "This potion will grant near immortality and power to whomever drinks it! That\'s right, just like the dreaded Unhold, any lucky enough to consume this will have their wounds close mere moments after opening! Take it! Quickly! Don\'t think, act!";
        this.m.Value = 10000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "unhold");

        _actor.getSkills().removeByID("trait.tiny");
        _actor.getSkills().add(::new("scripts/skills/traits/huge_trait"));
        _actor.getFlags().add("unhold");
        _actor.getSkills().add(::new("scripts/skills/effects/unhold_potion_effect"));
        _actor.getSkills().add(::new("scripts/skills/effects/wiederganger_potion_effect"));

        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.Colossus, 0, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_colossus"));

        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendMuscularity, 1, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_legend_muscularity"));

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
            text = "Heals [color=" + ::Const.UI.Color.PositiveValue + "]5[/color] hitpoints each turn. Cannot heal if poisoned."
        });
        result.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "The threshold to sustain injuries on getting hit is increased by [color=" + ::Const.UI.Color.PositiveValue + "]33%[/color]" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
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
            text = "Muscularity: Put your full weight into every blow and gain [color=" + ::Const.UI.Color.PositiveValue + "]+10%[/color] of your current hitpoints as additional minimum and maximum damage, up to 50."
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