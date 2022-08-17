this.white_direwolf_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.white_direwolf_potion_item";
		this.m.Name = "Sequence 8: White Wolf";
		this.m.Description = "This concoction, borne from research into the legendary white wolf, further improves the qualities given in the sequence 9 potion, Direwolf. \n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_26.png";
		this.m.Value = 10000;
	}

	function getTooltip()
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
			text = "White Wolf: Improves the qualities of the direwolf." + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Fatigue" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Initiative" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Melee Attack" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Melee Defense"
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
			text = this.Const.Strings.PerkName.LegendBattleheart + ": The defense malus due to being surrounded by opponents no longer applies to this character. If an attacker has the Backstabber perk, the effect of that perk is negated, and the normal defense malus due to being surrounded is applied instead. Makes the Underdog perk redundant."
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

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		    this.getroottable().anatomists_expanded.doInjuries(_actor, "werewolf");

			_actor.getFlags().add("werewolf");
			_actor.getFlags().add("werewolf_8");
			_actor.getSkills().add(this.new("scripts/skills/racial/werewolf_player_racial"));
			_actor.getSkills().add(this.new("scripts/skills/actives/howl_player"));

			_actor.getBackground().addPerk(this.Const.Perks.PerkDefs.LegendBattleheart, 2, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_battleheart"));

			_actor.getBackground().addPerk(this.Const.Perks.PerkDefs.Pathfinder, 0, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_pathfinder"));
           
            this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/werewolf_idle_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/werewolf_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
	}

});

