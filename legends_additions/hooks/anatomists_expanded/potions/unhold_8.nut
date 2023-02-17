::mods_hookExactClass("items/misc/anatomist/ancient_priest_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 8: Mountain";
        this.m.Description = "The power of the mountain.";
        this.m.Icon = "consumables/potion_32.png";
        this.m.Value = 20000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "unhold");
        _actor.getFlags().add("unhold");
        _actor.getFlags().add("unhold_8");

        //Tiny -> Normal -> Huge
        if (_actor.getSkills().hasSkill("trait.tiny")) _actor.getSkills().removeByID("trait.tiny");
        else _actor.getSkills().add(::new("scripts/skills/traits/huge_trait"));

        //1 Hyperactive Cell Growth T2
        _actor.getSkills().add(::new("scripts/skills/effects/unhold_potion_effect"));

        //2 Sensory Redundancy
        _actor.getSkills().add(::new("scripts/skills/effects/orc_warrior_potion_effect"));

        //3 Resilient - Increases the upper limit of gene change for those who know how to use it
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.HoldOut, 2);

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
            icon = "ui/icons/health.png",
            text = "Hyperactive Cell Growth: Heals " + ::MSU.Text.colorGreen( "40" ) + " hitpoints each turn. Cannot heal if poisoned."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/armor_body.png",
            text = "Heals " + ::MSU.Text.colorGreen( "40" ) + " head and body armor each turn.  Cannot heal if poisoned."
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
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Sensory Redundancy: [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color] chance to resist the Dazed, Staggered, Stunned status effects"
        });

        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Resilient: Keep it together! Reduce the duration of general status effects to " + ::MSU.Text.colorGreen( "1" ) + " turn. +" + ::MSU.Text.colorGreen( "8" ) + " hitpoints.  Raises the chance to survive being struck down from 33% to 66%."
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