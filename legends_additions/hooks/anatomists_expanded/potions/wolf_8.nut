::mods_hookExactClass("items/misc/anatomist/goblin_overseer_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 8: White Wolf";
        this.m.Description = "This concoction, borne from research into the legendary white wolf, further improves the qualities given in the sequence 9 potion, Direwolf. ";
        this.m.Icon = "consumables/potion_26.png";
        this.m.Value = 10000;
    }

    o.onUse = function(_actor, _item = null)
    {
		    ::LA.doMutation(_actor, "werewolf");

			_actor.getFlags().add("werewolf");
			_actor.getFlags().add("werewolf_8");
			_actor.getSkills().add(::new("scripts/skills/racial/werewolf_player_racial"));
			_actor.getSkills().add(::new("scripts/skills/actives/howl_player"));

			_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendBattleheart, 2, false);
            _actor.getSkills().add(::new("scripts/skills/perks/perk_legend_battleheart"));

			_actor.getBackground().addPerk(::Const.Perks.PerkDefs.Pathfinder, 0, false);
            _actor.getSkills().add(::new("scripts/skills/perks/perk_pathfinder"));
           
            this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/werewolf_hurt_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);

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
			text = "White Wolf: Improves the qualities of the direwolf." + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Fatigue" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Initiative" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+5[/color] Melee Attack" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+5[/color] Melee Defense"
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Howl: Let loose a howl, boosting the morale of all allied direwolves within 6 tiles."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Const.Strings.PerkName.LegendBattleheart + ": The defense malus due to being surrounded by opponents no longer applies to this character. If an attacker has the Backstabber perk, the effect of that perk is negated, and the normal defense malus due to being surrounded is applied instead. Makes the Underdog perk redundant."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Pathfinder: Action Point costs for movement on all terrain is reduced by -1 to a minimum of 2 Action Points per tile, and Fatigue cost is reduced to half. Changing height levels also has no additional Action Point cost anymore."
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