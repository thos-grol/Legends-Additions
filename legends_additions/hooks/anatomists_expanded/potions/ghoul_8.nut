::mods_hookExactClass("items/misc/anatomist/fallen_hero_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 8: Skin Ghoul";
        this.m.Description = "Should ye fall to madness, only skin and hunger will remain, and the user will degenerate into a skin ghoul. This potion grants the drinker impoved vitality and minor health regeneration and a supernatural sense of the how to carve flesh. \n\nUpgrades Sequence 9: Ghoul.";
        this.m.Icon = "consumables/potion_36.png";
        this.m.Value = 15000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "ghoul");
        _actor.getFlags().add("ghoul");
        _actor.getFlags().add("ghoul_8");

        //Add Gluttonous Trait
        _actor.getSkills().removeByID("trait.spartan");
        _actor.getSkills().add(::new("scripts/skills/traits/gluttonous_trait"));

        //Subdermal Clotting
        _actor.getSkills().add(::new("scripts/skills/effects/hyena_potion_effect"));

        //Hyperactive Cell Growth
        _actor.getSkills().add(::new("scripts/skills/effects/unhold_potion_effect"));

        //Synapse Blockage
        _actor.getSkills().add(::new("scripts/skills/effects/ancient_priest_potion_effect"));

        //Lacerate
        ::LA.addPerk(_actor, "perk.legend_lacerate", "scripts/skills/perks/perk_legend_lacerate", ::Const.Perks.PerkDefs.LegendLacerate, 3);

        this.Sound.play("sounds/enemies/ghoul_death_0" + this.Math.rand(1, 6) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/ghoul_flee_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/ghoul_hurt_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Subdermal Clotting: Damage received from the Bleeding status effect is reduced by " + ::MSU.Text.colorGreen( "50" ) + "%"
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
			icon = "ui/icons/morale.png",
			text = "Synapse Blockage: Twists the mind into something more inhuman. Morale cannot be reduced below Steady."
		});
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "This brother becomes gluttonous. Removes the spartan trait."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "Hyperactive Cell Growth: Heals " + ::MSU.Text.colorGreen( "20" ) + " hitpoints each turn. Cannot heal if poisoned."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Lacerate: Lust for blood courses through your veins, each stroke rips and tears with a ferocity unmatched. Cause minor but long lasting bleeding on any target you deal direct health damage to with any weapon. This effect stacks.",
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