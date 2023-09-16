::mods_hookExactClass("items/misc/anatomist/ifrit_potion_item", function (o)
{
    
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 8: Green Glow in the Woods";
        this.m.Description = "From research on the legendary Greenwood Schrat, this potion improves upon the symbiotic relationship formed in the previous potion. Now the drinker can grow roots and branches out of their body to attack. ";
        this.m.Icon = "consumables/potion_33.png";
        this.m.Value = 15000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "schrat");

        _actor.getFlags().add("schrat");
        _actor.getFlags().add("schrat_8");
        _actor.getSkills().add(::new("scripts/skills/effects/schrat_potion_effect"));
        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.CripplingStrikes, 1, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_crippling_strikes"));
        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendLacerate, 2, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_legend_lacerate"));

        this.Sound.play("sounds/enemies/dlc2/schrat_shield_damage_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/schrat_hurt_shield_down_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/schrat_death_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Gives you wisdom."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/armor_body.png",
            text = "Wooden Carapace: Greatly reduces any form of piercing damage, but you take 33% more burning damage."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Symbiotic Seeds: When taking damage more than or equal to 15% of your health, birth a minature greenwood schrat from your blood and surroundings to help you in combat."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Retractable Roots: Immune to being knocked back or grabbed. Greenwood evolution: You can now send your roots out to attack, but it is very fatiguing. The damage is equal to the currently equipped weapon and -15% armor damage."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Crippling Strikes and Lacerate: Causes even the meh blows to be impactful."
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