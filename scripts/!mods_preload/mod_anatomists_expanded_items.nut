this.getroottable().anatomists_expanded.hook_items <- function ()
{
    ::mods_hookExactClass("items/misc/anatomist/ifrit_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 7: Green Glow in the Woods";
		    this.m.Description = "From research on the legendary Greenwood Schrat, this potion improves upon the symbiotic relationship formed in the previous potion. Now the drinker can grow roots and branches out of their body to attack. \n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Icon = "consumables/potion_33.png";
            this.m.Value = 15000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "schrat");

            _actor.getFlags().add("schrat");
            _actor.getFlags().add("schrat_8");
            _actor.getSkills().add(this.new("scripts/skills/effects/schrat_potion_effect"));
            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.CripplingStrikes, 1, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_crippling_strikes"));
            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.LegendLacerate, 2, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_lacerate"));

            this.Sound.play("sounds/enemies/dlc2/schrat_shield_damage_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/schrat_hurt_shield_down_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/schrat_death_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                text = "Gives you wisdom."
			});
            result.push({
				id = 11,
                type = "text",
                icon = "ui/icons/armor_body.png",
                text = "Wooden Carapace: Greatly reduces any form of piercing damage, but you take 33% more burning damage."
			});
            result.push({
				id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Symbiotic Seeds: When taking damage more than or equal to 15% of your health, birth a minature greenwood schrat from your blood and surroundings to help you in combat."
			});
            result.push({
                id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Retractable Roots: Immune to being knocked back or grabbed. Greenwood evolution: You can now send your roots out to attack, but it is very fatiguing. The damage is equal to the currently equipped weapon and -15% armor damage."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Crippling Strikes and Lacerate: Causes even the meh blows to be impactful."
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });

    ::mods_hookExactClass("items/misc/anatomist/schrat_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 8: Schrat";
		    this.m.Description = "One of the rare sequence 8 creature in these lands. Though this race has lost much of it's former glory, it is still related to the legendary wisdom tree. This potion grants the drinker the properties of a schrat as well as unveil what is hidden in it's life code. \n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Icon = "consumables/potion_33.png";
            this.m.Value = 10000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "schrat");

            _actor.getFlags().add("schrat");

            _actor.getSkills().add(this.new("scripts/skills/traits/bright_trait"));
            _actor.getSkills().add(this.new("scripts/skills/effects/schrat_potion_effect"));
            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.Student, 0, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_student"));

            this.Sound.play("sounds/enemies/dlc2/schrat_shield_damage_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/schrat_hurt_shield_down_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/schrat_death_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                text = "Gives you wisdom."
			});
            result.push({
				id = 11,
                type = "text",
                icon = "ui/icons/armor_body.png",
                text = "Wooden Carapace: Greatly reduces any form of piercing damage, but you take 33% more burning damage."
			});
            result.push({
				id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Symbiotic Seeds: When taking damage more than or equal to 15% of your health, birth a minature schrat from your blood and surroundings to help you in combat."
			});
            result.push({
                id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Retractable Roots: Immune to being knocked back or grabbed"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Student: Gain additional 20% experience from battle. At the eleventh character level, you gain an additional perk point. The bonus experience stays until level 99. When playing the Manhunters origin, your indebted get the perk point refunded at the seventh character level."
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });

    ::mods_hookExactClass("items/misc/anatomist/orc_warrior_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 7: Stollwurm";
		    this.m.Description = "This potion further improves upon the previous sequence\'s. In addition to further improving the physqique of the drinker, they mutate organs that allow them to better take blows and negative statuses. \n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Icon = "consumables/potion_27.png";
            this.m.Value = 15000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            //TODO: Revamp
            this.getroottable().anatomists_expanded.doInjuries(_actor, "wurm");
            _actor.getFlags().add("wurm");
            _actor.getFlags().add("wurm_8");
            
            _actor.getSkills().add(this.new("scripts/skills/effects/orc_warrior_potion_effect"));
            _actor.getSkills().add(this.new("scripts/skills/effects/fallen_hero_potion_effect"));

            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.PTRFamilyPride, 1, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_family_pride"));

            //previous potion already has
            _actor.getSkills().add(this.new("scripts/skills/traits/perfect_body_trait"));
            _actor.getSkills().add(this.new("scripts/skills/effects/lindwurm_potion_effect"));

            this.Sound.play("sounds/enemies/lindwurm_death_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/lindwurm_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/lindwurm_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
				text = "Perfects your physique, removing negative traits and adding positive traits."
			});
            result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character\'s blood burns with acid, damaging adjacent attackers whenever they deal hitpoint damage"
			});
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 15 + "[/color] Hitpoints"
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/melee_skill.png",
                text = "Attacks do [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] additional damage"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Sensory Redundancy: [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects"
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 10 + "[/color] Hitpoints"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Reactive Muscle Tissue: This character accumulates no Fatigue from enemy attacks, whether they hit or miss"
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 10 + "[/color] Hitpoints"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Family Pride: Take pride in your bloodline. See the perk description for more."
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });

    ::mods_hookExactClass("items/misc/anatomist/lindwurm_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 8: Lindwurm";
		    this.m.Description = "Drawing inspiration from the dragon's blood bath of the myths, this potion will perfect the user's physique, removing any negative physical traits, and giving them the potential to be a hero of legends. They will gain potent acidic blood as well. \n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Icon = "consumables/potion_27.png";
            this.m.Value = 10000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "wurm");
            _actor.getFlags().add("wurm");

            _actor.getSkills().add(this.new("scripts/skills/traits/perfect_body_trait"));
            
            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.PTRRisingStar, 0, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_rising_star"));
           _actor.setVeteranPerks(2);

            this.Sound.play("sounds/enemies/lindwurm_death_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/lindwurm_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/lindwurm_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
				text = "Perfects your physique, removing negative traits and adding positive traits. This character also has improved veteran levels, from 5 to 2."
			});
            result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character\'s blood burns with acid, damaging adjacent attackers whenever they deal hitpoint damage"
			});
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Rising Star: The potion will perfect the drinker's physique. They could be legend someday... Gain 2 perk points 5 levels after you take this perk. Experience Gain is increased by 20% for the next 5 levels and by 5% after that."
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });
    
    ::mods_hookExactClass("items/misc/anatomist/fallen_hero_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 8: Only Skin and Hunger";
		    this.m.Description = "From research on the legendary skin ghoul, this potion grants the drinker minor regeneration, as well as improving the properties of the previous potion. The drinker seems to have gained an unusual sense for blood and every strike they make causes bleeds.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Icon = "consumables/potion_36.png";
            this.m.Value = 10000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "ghoul");
            
            if (!_actor.getFlags().has("ghoul"))
			{
				_actor.getFlags().add("ghoul");
			}

            if (!_actor.getFlags().has("ghoul_8"))
			{
				_actor.getFlags().add("ghoul_8");
			}

            if (_actor.getSkills().getSkillByID("effects.nachzehrer_potion") == null)
            {
                _actor.getSkills().add(this.new("scripts/skills/effects/nachzehrer_potion_effect"));
            }

            if (_actor.getSkills().getSkillByID("effects.unhold_potion") == null)
            {
                _actor.getSkills().add(this.new("scripts/skills/effects/unhold_potion_effect"));
            }
            
            if (_actor.getSkills().getSkillByID("effects.hyena_potion") == null)
            {
                _actor.getSkills().add(this.new("scripts/skills/effects/hyena_potion_effect"));
            }

            if (_actor.getSkills().getSkillByID("perk.legend_lacerate") == null)
            {
                _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.LegendLacerate, 3, false);
                _actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_lacerate"));
            }

            this.Sound.play("sounds/enemies/ghoul_death_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/ghoul_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/ghoul_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                icon = "ui/icons/days_wounded.png",
                text = "Hyperactive Tissue Growth: Reduces the time it takes to heal from any injury by one day, down to a mininum of one day."
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/initiative.png",
                text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 10 + "[/color] Initiative"
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "Hyperactive Cell Growth: Heals [color=" + this.Const.UI.Color.PositiveValue + "]5[/color] hitpoints each turn. Cannot heal if poisoned."
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "Subdermal Clotting: Damage received from the Bleeding status effect is reduced by [color=" + this.Const.UI.Color.NegativeValue + "]50%[/color]"
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 10 + "[/color] Hitpoints"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Lacerate: Lust for blood courses through your veins, each stroke rips and tears with a ferocity unmatched. Cause minor but long lasting bleeding on any target you deal direct health damage to with any weapon. This effect stacks.",
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });

    ::mods_hookExactClass("items/misc/anatomist/nachzehrer_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 9: Ghoul";
		    this.m.Description = "If one divorces the horror of the act from its utility, there are few phenomena more marvelous in nature than the Nachzehrer\'s ability to recover by eating the flesh of the dead. No longer! Now man himself may take on such qualities! This potion also allows the drinker to gain the speed and wild frenzy of the Nachzehrer.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Value = 5000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "ghoul");
            
            if (!_actor.getFlags().has("ghoul"))
			{
				_actor.getFlags().add("ghoul");
			}

            if (_actor.getSkills().getSkillByID("effects.nachzehrer_potion") == null)
            {
                _actor.getSkills().add(this.new("scripts/skills/effects/nachzehrer_potion_effect"));
            }

            if (_actor.getSkills().getSkillByID("perk.legend_gruesome_feast") == null)
            {
                _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.LegendGruesomeFeast, 0, false);
                _actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_gruesome_feast"));
            }

            if (_actor.getSkills().getSkillByID("perk.legend_alert") == null)
            {
                _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.LegendAlert, 1, false);
                _actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_alert"));
            }

            if (_actor.getSkills().getSkillByID("perk.killing_frenzy") == null)
            {
                _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.KillingFrenzy, 2, false);
                _actor.getSkills().add(this.new("scripts/skills/perks/perk_killing_frenzy"));
            }

            this.Sound.play("sounds/enemies/ghoul_death_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/ghoul_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/ghoul_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                icon = "ui/icons/days_wounded.png",
                text = "Hyperactive Tissue Growth: Reduces the time it takes to heal from any injury by one day, down to a mininum of one day."
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/initiative.png",
                text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 10 + "[/color] Initiative"
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Gruesome Feast: Taste of the forbidden flesh. Devour a recently departed corpse to gain strength and restore your own health by [color=" + this.Const.UI.Color.PositiveValue + "]50[/color] "
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = 	"Alert: Pay close attention at all times, surveying the surroundings and assessing every clue for an insight. Gain [color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] Initiative."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Killing Frenzy: Go into a killing frenzy! A kill increases all damage by [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] for 2 turns. Does not stack, but another kill will reset the timer."
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });
    
    ::mods_hookExactClass("items/misc/anatomist/ancient_priest_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 8: Mountain";
		    this.m.Description = "From research on the legendary rock unhold, this potion improves upon the previous sequence\'s, granting the drinker increased regeneration and creating natural armor on their body that regenerates.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Icon = "consumables/potion_32.png";
            this.m.Value = 20000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "unhold");

            _actor.getSkills().removeByID("trait.tiny");
            _actor.getSkills().add(this.new("scripts/skills/traits/huge_trait"));
            _actor.getFlags().add("unhold");
            _actor.getFlags().add("unhold_8");
            _actor.getSkills().add(this.new("scripts/skills/effects/unhold_potion_effect"));
            _actor.getSkills().add(this.new("scripts/skills/effects/orc_warrior_potion_effect"));

            this.Sound.play("sounds/enemies/unhold_death_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/unhold_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/unhold_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                text = "Induces major growth."
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "Heals [color=" + this.Const.UI.Color.PositiveValue + "]10[/color] hitpoints each turn. Cannot heal if poisoned."
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/armor_body.png",
                text = "Heals [color=" + this.Const.UI.Color.PositiveValue + "]20[/color] head and body armor each turn.  Cannot heal if poisoned."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Sensory Redundancy: [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });

    ::mods_hookExactClass("items/misc/anatomist/unhold_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 9: Unhold";
		    this.m.Description = "This potion will grant near immortality and power to whomever drinks it! That\'s right, just like the dreaded Unhold, any lucky enough to consume this will have their wounds close mere moments after opening! Take it! Quickly! Don\'t think, act!\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Value = 10000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "unhold");

            _actor.getSkills().removeByID("trait.tiny");
            _actor.getSkills().add(this.new("scripts/skills/traits/huge_trait"));
            _actor.getFlags().add("unhold");
            _actor.getSkills().add(this.new("scripts/skills/effects/unhold_potion_effect"));
            _actor.getSkills().add(this.new("scripts/skills/effects/wiederganger_potion_effect"));

            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.Colossus, 0, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_colossus"));

            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.LegendMuscularity, 1, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_muscularity"));

            this.Sound.play("sounds/enemies/unhold_death_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/unhold_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/unhold_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                text = "Induces major growth."
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "Heals [color=" + this.Const.UI.Color.PositiveValue + "]5[/color] hitpoints each turn. Cannot heal if poisoned."
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "The threshold to sustain injuries on getting hit is increased by [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color]" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Colossus: Hitpoints are increased by [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color], which also reduces the chance to sustain debilitating injuries when being hit."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Muscularity: Put your full weight into every blow and gain [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] of your current hitpoints as additional minimum and maximum damage, up to 50."
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });
    
    ::mods_hookExactClass("items/misc/anatomist/webknecht_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 9: Spider";
		    this.m.Description = "As any experienced beast hunter could tell you, what makes the overgrown arachnids known as Webknechts truly fearsome is their vicious poison. Imbimbing this potion grants the drinker the venom glands of a Webknecht and the ability to resist poisons as well as nightvision. The anatomist remarked that it was odd that this potion only granted three effects. Was he missing something? Where was the power of this species concentrated?\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Value = 5000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "spider");

            _actor.getFlags().add("spider");
            _actor.getSkills().add(this.new("scripts/skills/effects/serpent_potion_effect"));
            _actor.getSkills().add(this.new("scripts/skills/effects/webknecht_potion_effect"));
            _actor.getSkills().add(this.new("scripts/skills/effects/alp_potion_effect"));

            this.Sound.play("sounds/enemies/dlc2/giant_spider_death_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/giant_spider_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/giant_spider_hurt_0" + this.Math.rand(1, 7) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Venom Glands: Piercing or cutting attacks poison the target."
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/initiative.png",
                text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 15 + "[/color] Initiative"
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/melee_skill.png",
                text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 5 + "[/color] Melee Skill"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Mutated Circulatory System: Immune to poison effects, including those of Webknechts and Goblins."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/morale.png",
                text = "Enhanced Eye Rods: Not affected by nighttime penalties" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+2[/color] Vision"
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });

    ::mods_hookExactClass("items/misc/anatomist/wiederganger_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 8: Black Widow";
		    this.m.Description = "It turns out that most the strength of this species is focused on in it's poison making abilities. With research into the legendary Redback Spider, this potion improves upon the poison of the previous sequence, allowing the drinker to poison your enemies with redback poison when cutting or piercing them. They also gain the ability to spit webs at their foes among other improvements.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Value = 10000;
            this.m.Icon = "consumables/potion_31.png";
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "spider");

            _actor.getFlags().add("spider");
            _actor.getFlags().add("spider_8");

            _actor.getSkills().add(this.new("scripts/skills/effects/serpent_potion_effect"));
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_item_web_skill"));

            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.Nimble, 0, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_nimble"));

            this.Sound.play("sounds/enemies/dlc2/giant_spider_death_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/giant_spider_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/giant_spider_hurt_0" + this.Math.rand(1, 7) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Venom Glands: Piercing or cutting attacks poison the target with redback poison."
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/initiative.png",
                text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 15 + "[/color] Initiative"
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/melee_skill.png",
                text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 10 + "[/color] Melee Skill"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Spit Web: Spit a web at your foes and trap them."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Nimble: Specialize in light armor! By nimbly dodging or deflecting blows, convert any hits to glancing hits. Hitpoint damage taken is reduced by up to [color=" + this.Const.UI.Color.PositiveValue + "]60%[/color], but lowered exponentially by the total penalty to Maximum Fatigue from body and head armor above 15."
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });

    ::mods_hookExactClass("items/misc/anatomist/serpent_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 9: Serpent";
		    this.m.Description = "A quite interesting potion, according to the anatomist who made it. Although this species currently cannot support a sequence 8, this potion confers upon the drinker the ability to produce poison for their cutting and piercing attacks and be immune to various types of poisons. They also have developed the survival instinct of a snake and gain that species's pattern recognition skills. Sadly it does not greatly improve the user's physical attributes.";
            this.m.Value = 5000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "serpent");

            _actor.getFlags().add("serpent");

            _actor.getSkills().add(this.new("scripts/skills/effects/serpent_potion_effect"));
            _actor.getSkills().add(this.new("scripts/skills/effects/webknecht_potion_effect"));

            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.PTRPatternRecognition, 0, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));

            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.PTRSurvivalInstinct, 1, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));

            this.Sound.play("sounds/enemies/dlc6/snake_death_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc6/snake_idle_0" + this.Math.rand(1, 9) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc6/snake_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Venom Glands: Piercing or cutting attacks poison the target."
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/initiative.png",
                text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 15 + "[/color] Initiative"
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/melee_skill.png",
                text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 5 + "[/color] Melee Skill"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Mutated Circulatory System: Immune to poison effects, including those of Webknechts and Goblins."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Pattern Recognition: Improves defense per enemy in combat."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Survival Instinct: Gain the serpent's survival instinct. Improves defense."
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });
    
    ::mods_hookExactClass("items/misc/anatomist/orc_young_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 9: Orc";
		    this.m.Description = "Many a general has wished orcs might be tamed, for if one could control the greenskins and direct their strength with the intellect of man, they would surely control an unstoppable force. With this, such fantasies are within reach!\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Value = 7500;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "orc");

            _actor.getSkills().removeByID("trait.tiny");
            _actor.getSkills().add(this.new("scripts/skills/traits/huge_trait"));

            _actor.getFlags().add("orc");

            _actor.getSkills().add(this.new("scripts/skills/effects/orc_young_potion_effect"));
            _actor.getSkills().add(this.new("scripts/skills/effects/orc_warrior_potion_effect"));

            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.Colossus, 0, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_colossus"));

            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.PTRHaleAndHearty, 1, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_hale_and_hearty"));

            this.Sound.play("sounds/enemies/orc_death_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/orc_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/orc_hurt_0" + this.Math.rand(1, 7) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                text = "Induces major growth."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Shock Absorbant Wrists: Attacks do [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] additional damage"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Sensory Redundancy: [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Colossus: Hitpoints are increased by [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color], which also reduces the chance to sustain debilitating injuries when being hit."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Hale and Hearty: Fatigue Recovery is increased by [color=" + this.Const.UI.Color.PositiveValue + "]5%[/color] of your Maximum Fatigue after gear."
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });

    ::mods_hookExactClass("items/misc/anatomist/orc_warlord_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 8: Warlord";
		    this.m.Description = "Borne from the study of the renown Orc Warlord, this potion improves upon that of the previous sequence, allowing one to wield heavy orc weapons with ease as well as letting an orc\'s rage flow through one\'s veins.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Value = 15000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "orc");

            _actor.getSkills().removeByID("trait.tiny");
            _actor.getSkills().add(this.new("scripts/skills/traits/huge_trait"));

            _actor.getFlags().add("orc");
            _actor.getFlags().add("orc_8");

            _actor.getSkills().add(this.new("scripts/skills/effects/orc_warlord_potion_effect"));
            _actor.getSkills().add(this.new("scripts/skills/effects/orc_berserker_potion_effect"));

            this.Sound.play("sounds/enemies/orc_death_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/orc_flee_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/orc_hurt_0" + this.Math.rand(1, 7) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                text = "Induces major growth."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Warlord: Improves upon the effects of the sequence 9 potion. \n[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color]% Damage" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Improved Limbic System: Using orc weapons no longer imposes additional fatigue costs" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Fatigue"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Hyperactive Glands: This character gains two stacks of Rage each time they take hitpoint damage, and loses one stack at the end of each turn. Rage improves damage reduction and other combat stats."
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });
    
    ::mods_hookExactClass("items/misc/anatomist/goblin_grunt_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 9: Goblin";
		    this.m.Description = "Equal parts terrifying and annoying, the uncanny marksmanship of goblins has long been thought unobtainable by ordinary, self-respecting humans. With this wondrous potion, however, the discerning warrior can harness some of that latent skill and obtain the celerity inherent in these greenskins. Side effects might include shrinking.\n\nUnfortunately, the anatomist says that this race is too feeble to have develop a sequence 8 potion.";
            this.m.Value = 5000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "goblin");

            if (_actor.getSkills().hasSkill("trait.huge"))
            {
                _actor.getSkills().removeByID("trait.huge");
            }

            if (!_actor.getSkills().hasSkill("trait.tiny"))
            {
                _actor.getSkills().add(this.new("scripts/skills/traits/tiny_trait"));
            }

            if (!_actor.getFlags().has("goblin"))
			{
				_actor.getFlags().add("goblin");
			}

            if (_actor.getSkills().getSkillByID("effects.goblin_overseer_potion") == null)
            {
                _actor.getSkills().add(this.new("scripts/skills/effects/goblin_overseer_potion_effect"));
            }

            if (_actor.getSkills().getSkillByID("effects.goblin_grunt_potion") == null)
            {
                _actor.getSkills().add(this.new("scripts/skills/effects/goblin_grunt_potion_effect"));
            }

            if (_actor.getSkills().getSkillByID("perk.footwork") == null)
            {
                _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.Footwork, 0, false);
                _actor.getSkills().add(this.new("scripts/skills/perks/perk_footwork"));
            }

            if (_actor.getSkills().getSkillByID("perk.ptr_nailed_it") == null)
            {
                _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.PTRNailedIt, 1, false);
                _actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_nailed_it"));
            }

            this.Sound.play("sounds/enemies/vampire_hurt_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/vampire_death_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/vampire_idle_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                text = "Reactive Leg Muscles: The AP cost of Rotation and Footwork is reduced to [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] and the Fatigue costs are reduced by [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]." + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Initiative"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Mutated Cornea: An additional [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] of damage ignores armor when using bows or crossbows\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Ranged Skill"  + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Ranged Defense"
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
                text = "Nailed It!: The chance to hit the head with ranged attacks is increased by [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] but reduced by [color=" + this.Const.UI.Color.NegativeValue + "]5%[/color] per tile of distance between you and the target."
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });

    ::mods_hookExactClass("items/misc/anatomist/alp_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 9: Alp";
		    this.m.Description = "This draft, the result of intensive study into the so-called \'Third Eye\' of the Alp, allows whomever drinks it to see through the night as if it were day, see into the minds of others and torment them with nightmares! Blurry vision and hallucinations are expected while the body acclimates. It seems the body also changes to these potent mutagens. \n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Icon = "consumables/potion_34.png";
            this.m.Value = 5000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "alp");

            _actor.getFlags().add("alp");
            _actor.getSkills().add(this.new("scripts/skills/actives/nightmare_player"));
            _actor.getSkills().add(this.new("scripts/skills/actives/sleep_player"));
            _actor.getSkills().add(this.new("scripts/skills/effects/alp_potion_effect"));
            _actor.getSkills().add(this.new("scripts/skills/effects/honor_guard_potion_effect"));

            this.Sound.play("sounds/enemies/dlc2/alp_death_0" + this.Math.rand(1, 5) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/alp_idle_0" + this.Math.rand(1, 9) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/alp_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/alp_nightmare_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }


        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                text = "Nightmare: Torment the victim's soul with nightmares, bringing them ever closer to oblivion."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Sleep: Lull them into the land of dreams."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/morale.png",
                text = "Enhanced Eye Rods: Not affected by nighttime penalties" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+2[/color] Vision"
            });
            result.push({
                id = 11,
                type = "text",
                icon = "ui/icons/morale.png",
                text = "This character takes between [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] and [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] less damage from piercing attacks, such as those from bows or spears" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"  
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });

    ::mods_hookExactClass("items/misc/anatomist/direwolf_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 9: Direwolf";
		    this.m.Description = "This humoural concoction, borne from research into the dreaded direwolf, will turn even the clumsiest oaf into a lithe dancer of a warrior, able to gracefully move with the tides of battle long after lesser men succumb to fatigue! Mild akathisia after consuming is normal and expected.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Value = 5000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "werewolf");

            _actor.getFlags().add("werewolf");
            _actor.getSkills().add(this.new("scripts/skills/racial/werewolf_player_racial"));
            _actor.getSkills().add(this.new("scripts/skills/effects/direwolf_potion_effect"));
            _actor.getSkills().add(this.new("scripts/skills/effects/alp_potion_effect"));

            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.PTRSurvivalInstinct, 1, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));

            this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/werewolf_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                text = "Direwolf: This character counts as a direwolf in skill checks, and inherits the direwolf's racial traits; that is inflicting more damage in proportion to missing health."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/morale.png",
                text = "Elasticized Sinew: Attacks that miss have [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] of their Fatigue cost refunded" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Fatigue"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/morale.png",
                text = "Enhanced Eye Rods: Not affected by nighttime penalties" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+2[/color] Vision"
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Survival Instinct: Every time you are attacked, gain +2 Melee and Ranged Defense on a miss and +5 on a hit. The bonus is reset at the start of every turn except the bonus gained from getting hit which is retained for the rest of the combat. This retained bonus cannot be higher than +10."
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });


    ::mods_hookExactClass("items/misc/anatomist/necrosavant_potion_item", function (o)
	{
        local create = ::mods_getMember(o, "create");
		o.create = function()
		{
            create();
            this.m.Name = "Sequence 9: Vampire";
		    this.m.Description = "Whoever drinks this incredible potion will find themselves in possession of the miraculous powers of the Necrosavant! Unfortunately, it doesn't grant immortality. Side effects might include immortality and removing old age.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
            this.m.Value = 15000;
        }

        local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_actor, _item = null)
        {
            this.getroottable().anatomists_expanded.doInjuries(_actor, "vampire");

            _actor.getSkills().removeByID("trait.old");
            _actor.getFlags().add("IsRejuvinated", true);
            _actor.getFlags().add("vampire");

            _actor.getSkills().add(this.new("scripts/skills/effects/necrosavant_potion_effect"));

            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.NineLives, 0, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_nine_lives"));

            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.PTRBloodlust, 1, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_bloodlust"));

            _actor.getBackground().addPerk(this.Const.Perks.PerkDefs.PTRSanguinary, 2, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_sanguinary"));

            this.Sound.play("sounds/enemies/vampire_hurt_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/vampire_death_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/vampire_idle_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
        }

        local getTooltip = ::mods_getMember(o, "getTooltip");
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
                icon = "ui/icons/health.png",
                text = "Parasitic Blood: Heal [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] of hitpoint damage inflicted on adjacent enemies that have blood" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints." + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Melee Skill."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Nine Lives: Once per battle, upon receiving a killing blow, survive instead with a few hitpoints left and have all damage over time effects cured. Also grants a one in nine chance to survive a fatal blow with an injury."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Bloodlust: Attacks on bleeding targets restore fatigue."
            });
            result.push({
                id = 12,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Sanguinary: Increases the chance to inflict fatalities and fatalities restore fatigue. Attacks against bleeding targets improve your morale."
            });
            result.push({
                id = 65,
                type = "text",
                text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
            });
            result.push({
                id = 65,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutates the body. A long period of sickness is expected. Under normal circumstances, drinking more than one mutation potion can severly cripple or even kill."
            });
            return result;
        }
    });
};