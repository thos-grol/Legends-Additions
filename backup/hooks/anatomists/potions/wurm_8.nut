::mods_hookExactClass("items/misc/anatomist/lindwurm_potion_item", function (o)
{
    
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 8: Lindwurm";
        this.m.Description = "Drawing inspiration from the dragon's blood bath of the myths, this potion will perfect the user's physique making them immune to the acidic blood of lindwurms and stollwurms, removing any negative physical traits, and giving them the potential to be a hero of legends. ";
        this.m.Icon = "consumables/potion_27.png";
        this.m.Value = 15000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "wurm");
        _actor.getFlags().add("wurm");

        _actor.getSkills().add(::new("scripts/skills/traits/perfect_body_trait"));
        _actor.setVeteranPerks(2);

        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.PTRDiscoveredTalent, 0);
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.PTRRisingStar, 1);
        

        this.Sound.play("sounds/enemies/lindwurm_death_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/lindwurm_flee_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/lindwurm_hurt_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Perfects your physique, removing negative traits and adding positive traits. This character now gains a perk every 2 levels instead of 5 after level 11, unless if they already did."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "This character\'s body becomes immune to lindwurm and stollwurm blood, but not their armor."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Rising Star: The potion will perfect the drinker's physique. They could be legend someday... Gain 2 perk points 5 levels after you take this perk. Experience Gain is increased by 20% for the next 5 levels and by 5% after that."
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