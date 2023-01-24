::mods_hookExactClass("items/misc/anatomist/lindwurm_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 8: Lindwurm";
        this.m.Description = "Drawing inspiration from the dragon's blood bath of the myths, this potion will perfect the user's physique making them immune to the acidic blood of lindwurms and stollwurms, removing any negative physical traits, and giving them the potential to be a hero of legends. ";
        this.m.Icon = "consumables/potion_27.png";
        this.m.Value = 10000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "wurm");
        _actor.getFlags().add("wurm");

        _actor.getSkills().add(::new("scripts/skills/traits/perfect_body_trait"));
        
        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.PTRRisingStar, 0, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_ptr_rising_star"));
        _actor.setVeteranPerks(2);

        this.Sound.play("sounds/enemies/lindwurm_death_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/lindwurm_flee_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/lindwurm_hurt_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Perfects your physique, removing negative traits and adding positive traits. This character also has improved veteran levels, from 5 to 2."
        });
        result.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "This character\'s body becomes immune to lindwurm and stollwurm blood, but not their armor."
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Rising Star: The potion will perfect the drinker's physique. They could be legend someday... Gain 2 perk points 5 levels after you take this perk. Experience Gain is increased by 20% for the next 5 levels and by 5% after that."
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