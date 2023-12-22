::mods_hookExactClass("items/misc/anatomist/necrosavant_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Vampire";
        this.m.Description = "Life everlasting.";
        this.m.Value = 25000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "vampire");
        _actor.getFlags().add("vampire");

        //Remove Old
        _actor.getSkills().removeByID("trait.old");
        _actor.getFlags().add("IsRejuvinated", true);

        //1 Parasitic Blood
        _actor.getSkills().add(::new("scripts/skills/effects/necrosavant_potion_effect"));

        //2 Darkflight
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.LegendDarkflight, 0);

        //3 Nine Lives
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.NineLives, 1);

        //4 Lacerate
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.LegendLacerate, 1);

        this.Sound.play("sounds/enemies/vampire_hurt_0" + ::Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/vampire_death_0" + ::Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/vampire_idle_0" + ::Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Parasitic Blood: Heal " + ::MSU.Text.colorGreen( "25" ) + "% of hitpoint damage inflicted on adjacent enemies that have blood"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Not affected by nighttime penalties"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "+" + ::MSU.Text.colorGreen( "15" ) + " Hitpoints"
        });
        ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Darkflight: Disapparate from your current location and reappear on the other side of the battlefield up to 6 tiles away."
		});
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Nine Lives: Once per battle, upon receiving a killing blow, survive instead with a few hitpoints left and have all damage over time effects cured. Also grants a one in nine chance to survive a fatal blow with an injury."
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