::mods_hookExactClass("items/misc/anatomist/orc_young_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Orc";
        this.m.Description = "Greenskin fury.";
        this.m.Value = 7500;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "orc");
        _actor.getFlags().add("orc");

        //Toughen
        _actor.getSkills().add(::new("scripts/skills/traits/iron_jaw_trait"));

        //1 Improved Musculature
        //3 Charge
        _actor.getSkills().add(::new("scripts/skills/effects/orc_young_potion_effect"));

        //2 Sensory Redundancy
        _actor.getSkills().add(::new("scripts/skills/effects/orc_warrior_potion_effect"));

        //4 Crippling Strikes
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.CripplingStrikes, 1);

        this.Sound.play("sounds/enemies/orc_death_0" + ::Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/orc_flee_0" + ::Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/orc_hurt_0" + ::Math.rand(1, 7) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Toughens the physique."
        });

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/melee_skill.png",
            text = "Improved Musculature: +" + ::MSU.Text.colorRed( "10%" ) + " Damage"
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
            text = "+" + ::MSU.Text.colorGreen( 10 ) + " Hitpoints"
        });

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/melee_skill.png",
            text = "This character gains the ability to charge at enemies, stunning them"
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
            text = "Crippling Strikes: Cripple your enemies! Lowers the threshold to inflict injuries by [color=" + ::Const.UI.Color.NegativeValue + "]33%[/color] for both melee and ranged attacks. Undead cannot be injured, but you gain [color=" + ::Const.UI.Color.NegativeValue + "]+10%[/color] damage against them."
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