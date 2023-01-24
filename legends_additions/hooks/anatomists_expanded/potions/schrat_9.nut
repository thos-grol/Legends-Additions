::mods_hookExactClass("items/misc/anatomist/schrat_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Schrat";
        this.m.Description = "Though this race has lost much of it's former glory, it is still related to the legendary wisdom tree. This potion grants the drinker the properties of a schrat. ";
        this.m.Icon = "consumables/potion_33.png";
        this.m.Value = 10000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "schrat");

        _actor.getFlags().add("schrat");

        _actor.getSkills().add(::new("scripts/skills/traits/bright_trait"));
        _actor.getSkills().add(::new("scripts/skills/effects/schrat_potion_effect"));
        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.Student, 0, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_student"));

        this.Sound.play("sounds/enemies/dlc2/schrat_shield_damage_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/schrat_hurt_shield_down_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/schrat_death_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);
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
            text = "Gives you wisdom."
        });
        result.push({
            id = 11,
            type = "text",
            icon = "ui/icons/armor_body.png",
            text = "Wooden Carapace: Greatly reduces any form of piercing damage, but you take 33% more burning damage."
        });
        result.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Symbiotic Seeds: When taking damage more than or equal to 15% of your health, birth a minature schrat from your blood and surroundings to help you in combat."
        });
        result.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Retractable Roots: Immune to being knocked back or grabbed"
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Student: Gain additional 20% experience from battle. At the eleventh character level, you gain an additional perk point. The bonus experience stays until level 99. When playing the Manhunters origin, your indebted get the perk point refunded at the seventh character level."
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