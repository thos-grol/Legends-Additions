::mods_hookExactClass("items/misc/anatomist/serpent_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Serpent";
        this.m.Description = "A quite interesting potion, according to the anatomist who made it. Although this species currently cannot support a sequence 8, this potion confers upon the drinker the ability to produce poison for their cutting and piercing attacks and be immune to various types of poisons. They also have developed the survival instinct of a snake and gain that species's pattern recognition skills. Sadly it does not greatly improve the user's physical attributes.";
        this.m.Value = 5000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "serpent");
        _actor.getFlags().add("serpent");

        
        _actor.getSkills().add(::new("scripts/skills/effects/serpent_potion_effect"));
        //+15 Melee Defense
        //+15 HP

        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.PTRPatternRecognition, 0, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_ptr_pattern_recognition"));

        _actor.getBackground().addPerk(::Const.Perks.PerkDefs.PTRSurvivalInstinct, 1, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_ptr_survival_instinct"));

        this.Sound.play("sounds/enemies/dlc6/snake_death_0" + ::Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc6/snake_idle_0" + ::Math.rand(1, 9) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc6/snake_hurt_0" + ::Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);

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
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Venom Glands: Piercing or cutting attacks poison the target."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/initiative.png",
            text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 15 + "[/color] Initiative"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/melee_skill.png",
            text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 5 + "[/color] Melee Skill"
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Mutated Circulatory System: Immune to poison effects, including those of Webknechts and Goblins."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Pattern Recognition: Adapt defenses against each enemy in combat."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Survival Instinct: Gain the serpent's survival instinct. Improves defense."
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