::mods_hookExactClass("items/misc/anatomist/unhold_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Unhold";
        this.m.Description = "The vitality of the unhold, bottled.";
        this.m.Value = 10000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "unhold");
        _actor.getFlags().add("unhold");

        //Tiny -> Normal -> Huge
        if (_actor.getSkills().hasSkill("trait.tiny")) _actor.getSkills().removeByID("trait.tiny");
        else _actor.getSkills().add(::new("scripts/skills/traits/huge_trait"));

        //1 Hyperactive Cell Growth
        _actor.getSkills().add(::new("scripts/skills/effects/unhold_potion_effect"));

        //2 Subdermal Reactivity - Increases Injury Threshold, DR 15%
        _actor.getSkills().add(::new("scripts/skills/effects/wiederganger_potion_effect"));

        //3 Colossus
        ::LA.addPerk(_actor, "perk.colossus", "scripts/skills/perks/perk_colossus", ::Const.Perks.PerkDefs.Colossus, 0);

        //4 Muscularity
        ::LA.addPerk(_actor, "perk.legend_muscularity", "scripts/skills/perks/perk_legend_muscularity", ::Const.Perks.PerkDefs.LegendMuscularity, 1);


        this.Sound.play("sounds/enemies/unhold_death_0" + this.Math.rand(1, 6) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/unhold_flee_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/unhold_hurt_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Induces major growth. Tiny becomes normal, and normal becomes huge."
        });

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "Hyperactive Cell Growth: Heals " + ::MSU.Text.colorGreen( "20" ) + " hitpoints each turn. Cannot heal if poisoned."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/fatigue.png",
            text = "+" + ::MSU.Text.colorGreen( 3 ) + " Fatigue Recovery"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "+" + ::MSU.Text.colorGreen( 20 ) + " Hitpoints"
        });


        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Subdermal Reactivity: The threshold to sustain injuries on getting hit is increased by" + ::MSU.Text.colorGreen( "33" ) + "%"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Reduces damage taken by" + ::MSU.Text.colorGreen( "15" ) + "%"
        });

        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Colossus: Hitpoints are increased by [color=" + ::Const.UI.Color.PositiveValue + "]25%[/color], which also reduces the chance to sustain debilitating injuries when being hit."
        });

        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Muscularity: Put your full weight into every blow and gain [color=" + ::Const.UI.Color.PositiveValue + "]+10%[/color] of your current hitpoints as additional minimum and maximum damage, up to 50."
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