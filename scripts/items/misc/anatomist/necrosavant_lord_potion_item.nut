this.necrosavant_lord_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.necrosavant_lord_potion_item";
		this.m.Name = "Sequence 8: Lord";
		this.m.Description = "This concoction, borne from research into the legendary necrosavant lord, further improves the qualities given in the sequence 9 potion, Vampire. \n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_20.png";
		this.m.Value = 20000;
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
			text = "Necrosavant Lord: Improves effects of parasitic blood to 25%."+ "\n[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] Hitpoints." + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Skill."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Darkflight: Disapparate from your current location and reappear on the other side of the battlefield up to 6 tiles away."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/morale.png",
			text = "Synapse Blockage: Morale cannot be reduced below Steady\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve"
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Mutated Circulatory System: Immune to poison effects, including those of Webknechts and Goblins."
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
		    this.getroottable().AE.doInjuries(_actor, "vampire");

			_actor.getSkills().removeByID("trait.old");
			_actor.getFlags().add("IsRejuvinated", true);

			_actor.getFlags().add("vampire");

			_actor.getFlags().add("vampire_8");
			_actor.getSkills().add(this.new("scripts/skills/effects/necrosavant_potion_effect"));
			_actor.getSkills().add(this.new("scripts/skills/effects/ancient_priest_potion_effect"));

			_actor.getBackground().addPerk(this.Const.Perks.PerkDefs.LegendDarkflight, 3, false);
            _actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_darkflight"));

			_actor.getSkills().add(this.new("scripts/skills/effects/webknecht_potion_effect"));

            this.Sound.play("sounds/enemies/vampire_hurt_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/vampire_death_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/enemies/vampire_idle_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
			
			return this.anatomist_potion_item.onUse(_actor, _item);
	}

});

