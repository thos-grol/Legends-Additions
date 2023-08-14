::mods_hookExactClass("items/misc/anatomist/goblin_grunt_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 9: Goblin";
        this.m.Description = "Equal parts terrifying and annoying, the uncanny marksmanship of goblins has long been thought unobtainable by ordinary, self-respecting humans. With this wondrous potion, however, the discerning warrior can harness some of that latent skill and obtain the celerity inherent in these greenskins. Side effects might include shrinking.\n\nUnfortunately, the anatomist says that this race is too feeble to have develop a sequence 8 potion.";
        this.m.Value = 10000;
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "goblin");
        _actor.getFlags().add("goblin");

        //Trait Huge -> Normal -> Tiny
        if (_actor.getSkills().hasSkill("trait.huge")) _actor.getSkills().removeByID("trait.huge");
        else _actor.getSkills().add(::new("scripts/skills/traits/tiny_trait"));

        //1 Mutated Visual Cortex
        _actor.getSkills().add(::new("scripts/skills/effects/goblin_overseer_potion_effect"));

        //2: Hair Splitter
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.LegendHairSplitter, 0);

        //3 Head Hunter
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.HeadHunter, 1);

        //4 Eyes Up
        ::LA.addPerk(_actor, ::Const.Perks.PerkDefs.PTREyesUp, 2);

        this.Sound.play("sounds/enemies/goblin_hurt_0" + this.Math.rand(0, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/goblin_death_0" + this.Math.rand(0, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/goblin_idle_0" + this.Math.rand(0, 3) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Shrinks the drinker."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Mutated Visual Cortex: This character\'s eyes have been permanently mutated and are now capable of detecting the subtlest movements of wind and air. While minor on its own, this allows them to better predict the trajectory of projectile attacks and better land hits on vulnerable parts of a target. An additional" + ::MSU.Text.colorGreen( "20" ) + "% of damage ignores armor when using bows or crossbows"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/ranged_skill.png",
            text = "+" + ::MSU.Text.colorGreen( "10" ) + " Ranged Skill"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/initiative.png",
            text = "+" + ::MSU.Text.colorGreen( "15" ) + " Initiative"
        });

        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Hair Splitter: +" + ::MSU.Text.colorGreen( "10" ) + "% chance to hit the head."
        });

        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Head Hunter: Go for the head! Hitting the head of a target will give you a guaranteed hit to the head also with your next attack. Connecting with your hit will reset the effect."
        });
        ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Eyes Up: Modifies the perk to work with any ranged weapon. Ranged attacks, hit or miss, will debuff the targets melee and ranged skill. A weakened version of this effect is spread to adjacent enemies."
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
