::mods_hookExactClass("items/misc/anatomist/goblin_overseer_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 8: White Wolf";
        this.m.Description = "This concoction, borne from research into the legendary white wolf. \n\nUpgrades Sequence 9: Direwolf.";
        this.m.Icon = "consumables/potion_26.png";
        this.m.Value = 15000;
    }

    o.onUse = function(_actor, _item = null)
    {
		    ::LA.doMutation(_actor, "werewolf");
			_actor.getFlags().add("werewolf");
			_actor.getFlags().add("werewolf_8");

			//1 & 3 Direwolf
			_actor.getSkills().add(::new("scripts/skills/effects/direwolf_potion_effect"));

			//2
			::LA.removePerk(_actor, "perk.underdog", ::Const.Perks.PerkDefs.Underdog);
			::LA.addPerk(_actor, ::Const.Perks.PerkDefs.LegendBattleheart, 1);

			//4
			::LA.addPerk(_actor, ::Const.Perks.PerkDefs.PTRUnstoppable, 3);

            this.Sound.play("sounds/enemies/werewolf_idle_0" + ::Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/werewolf_idle_0" + ::Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/werewolf_idle_0" + ::Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/werewolf_hurt_0" + ::Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);

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
            text = "Updgrades Direwolf: This character gains the ferocity of a direwolf and does half of missing health as increased damage."
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/fatigue.png",
            text = "+" + ::MSU.Text.colorGreen( "8" ) + " Fatigue Recovery"
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
			text = "Howl: When attacking, there is a 15% chance to let loose a howl, boosting the morale of all allied direwolves within 6 tiles and giving them killing frenzy."
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Upgrades Underdog to Battleheart: The defense malus due to being surrounded by opponents no longer applies to this character. If an attacker has the Backstabber perk, the effect of that perk is negated, and the normal defense malus due to being surrounded is applied instead."
		});
		ret.push({
            id = 12,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Unstoppable: During your turn, every successful attack provides a stacking bonus to Melee Skill and Action Points. Missing or getting hit will reduce stats."
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