::mods_hookExactClass("items/misc/anatomist/orc_warlord_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 8: Warlord";
        this.m.Description = "The power of the orc warlord.";
        this.m.Value = 15000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "orc");
        _actor.getFlags().add("orc_8");
        _actor.getFlags().add("orc");

        //Grow and toughen
        if (_actor.getSkills().hasSkill("trait.tiny")) _actor.getSkills().removeByID("trait.tiny");
        else _actor.getSkills().add(::new("scripts/skills/traits/huge_trait"));
        _actor.getSkills().add(::new("scripts/skills/traits/iron_jaw_trait"));

        //1 Improved Musculature
        //4 Charge Skill
        _actor.getSkills().add(::new("scripts/skills/effects/orc_young_potion_effect"));

        //2 Font of Strength
        _actor.getSkills().add(::new("scripts/skills/effects/orc_warlord_potion_effect"));

        //3 Berserk
        ::LA.addPerk(_actor, "perk.berserk", "scripts/skills/perks/perk_berserk", ::Const.Perks.PerkDefs.Berserk, 2);

        this.Sound.play("sounds/enemies/orc_death_0" + this.Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/orc_flee_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/orc_hurt_0" + this.Math.rand(1, 7) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Induces major growth and toughens the physique."
        });

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/melee_skill.png",
            text = "Improved Musculature: +" + ::MSU.Text.colorGreen( "15%" ) + " Damage"
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
            text = "Font of Might: Orc weapons no longer imposes additional fatigue costs"
        });

        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Berserk: RAAARGH! Once per turn, upon killing an enemy, [color=" + ::Const.UI.Color.PositiveValue + "]4[/color] Action Points are immediately regained. Characters can not regain more than their maximum Action Points and no more than 4 for a single attack."
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