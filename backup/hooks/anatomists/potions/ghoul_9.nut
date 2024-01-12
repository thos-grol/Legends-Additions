::mods_hookExactClass("items/misc/anatomist/nachzehrer_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Ghoul";
        this.m.Description = "Gain the hunger of the Nachzehrer. It's speed, violence, and vitality all distilled into one potion.";
        this.m.Value = 7500;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "ghoul");
        _actor.getFlags().add("ghoul");

        //Add Gluttonous Trait
        _actor.getSkills().removeByID("trait.spartan");
        _actor.getSkills().add(::new("scripts/skills/traits/gluttonous_trait"));

        //Subdermal Clotting
        _actor.getSkills().add(::new("scripts/skills/effects/hyena_potion_effect"));

        //1
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.LegendGruesomeFeast, 1);

        //2
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.LegendAlert, 0);

        //3
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.KillingFrenzy, 2);

        this.Sound.play("sounds/enemies/ghoul_death_0" + ::Math.rand(1, 6) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/ghoul_flee_0" + ::Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/ghoul_hurt_0" + ::Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);

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
            icon = "ui/icons/health.png",
            text = "Subdermal Clotting: Damage received from the Bleeding status effect is reduced by " + ::MSU.Text.colorGreen( "50" ) + "%."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "+" + ::MSU.Text.colorGreen( "15" ) + " Hitpoints"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/initiative.png",
            text = "+" + ::MSU.Text.colorGreen( "15" ) + " Initiative"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Gruesome Feast: Taste of the forbidden flesh. Devour a recently departed corpse to gain strength and restore your own health by " + ::MSU.Text.colorGreen( "50" ) + ". After battle, automatically consumes corpses and heals the character to full and remove non-permenant injuries."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = 	"Alert: Pay close attention at all times, surveying the surroundings and assessing every clue for an insight. Gain " + ::MSU.Text.colorGreen( "20" ) + "% Initiative."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Killing Frenzy: Go into a killing frenzy! A kill increases all damage by " + ::MSU.Text.colorGreen( "25" ) + "% for 2 turns. Does not stack, but another kill will reset the timer."
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