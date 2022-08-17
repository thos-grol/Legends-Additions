this.demon_alp_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.demon_alp_potion_item";
		this.m.Name = "Sequence 8: Demon";
		this.m.Description = "This concoction, borne from research into the legendary demon alp, further improves the qualities given in the sequence 9 potion, Alp. \n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_34.png";
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
			text = "King of Nightmares: Torment the victim's soul with nightmares, bringing them ever closer to oblivion. Improves the Nightmare skill."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Kingdom of Sleep: Lull them into your kingdom. Improves the Sleep skill."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Horrify: Blare out a piercing, unworldly sound that is more than likely to distress anyone unfortunate enough to hear it."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Levitate: Float above the ground. You no longer need to walk like those peasants."
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
		    this.getroottable().anatomists_expanded.doInjuries(_actor, "alp");

			_actor.getFlags().add("alp");
			_actor.getFlags().add("alp_8");
			_actor.getSkills().add(this.new("scripts/skills/passives/player_levitate"));
			_actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_item_horrify"));

            this.Sound.play("sounds/enemies/dlc2/alp_death_0" + this.Math.rand(1, 5) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/alp_idle_0" + this.Math.rand(1, 9) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/alp_hurt_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/dlc2/alp_nightmare_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);

            return this.anatomist_potion_item.onUse(_actor, _item);
	}

});

