::mods_hookExactClass("items/misc/anatomist/goblin_grunt_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Goblin";
        this.m.Description = "Equal parts terrifying and annoying, the uncanny marksmanship of goblins has long been thought unobtainable by ordinary, self-respecting humans. With this wondrous potion, however, the discerning warrior can harness some of that latent skill and obtain the celerity inherent in these greenskins. Side effects might include shrinking.\n\nUnfortunately, the anatomist says that this race is too feeble to have develop a sequence 8 potion.";
        this.m.Value = 5000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "goblin");

        if (_actor.getSkills().hasSkill("trait.huge"))
        {
            _actor.getSkills().removeByID("trait.huge");
        }

        if (!_actor.getSkills().hasSkill("trait.tiny"))
        {
            _actor.getSkills().add(::new("scripts/skills/traits/tiny_trait"));
        }

        if (!_actor.getFlags().has("goblin"))
        {
            _actor.getFlags().add("goblin");
        }

        if (_actor.getSkills().getSkillByID("effects.goblin_overseer_potion") == null)
        {
            _actor.getSkills().add(::new("scripts/skills/effects/goblin_overseer_potion_effect"));
        }

        if (_actor.getSkills().getSkillByID("effects.goblin_grunt_potion") == null)
        {
            _actor.getSkills().add(::new("scripts/skills/effects/goblin_grunt_potion_effect"));
        }

        if (_actor.getSkills().getSkillByID("perk.footwork") == null)
        {
            _actor.getBackground().addPerk(::Const.Perks.PerkDefs.Footwork, 0, false);
            _actor.getSkills().add(::new("scripts/skills/perks/perk_footwork"));
        }

        if (_actor.getSkills().getSkillByID("perk.ptr_nailed_it") == null)
        {
            _actor.getBackground().addPerk(::Const.Perks.PerkDefs.PTRNailedIt, 1, false);
            _actor.getSkills().add(::new("scripts/skills/perks/perk_ptr_nailed_it"));
        }

        this.Sound.play("sounds/enemies/vampire_hurt_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/vampire_death_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/vampire_idle_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Shrinks you."
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Reactive Leg Muscles: The AP cost of Rotation and Footwork is reduced to [color=" + ::Const.UI.Color.PositiveValue + "]2[/color] and the Fatigue costs are reduced by [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color]." + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+5[/color] Initiative"
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Mutated Cornea: An additional [color=" + ::Const.UI.Color.PositiveValue + "]15%[/color] of damage ignores armor when using bows or crossbows\n" + "[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Ranged Skill"  + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+15[/color] Ranged Defense"
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Footwork: Allows you to leave a Zone of Control without triggering free attacks by using skillful footwork."
        });
        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Nailed It!: The chance to hit the head with ranged attacks is increased by [color=" + ::Const.UI.Color.PositiveValue + "]25%[/color] but reduced by [color=" + ::Const.UI.Color.NegativeValue + "]5%[/color] per tile of distance between you and the target."
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