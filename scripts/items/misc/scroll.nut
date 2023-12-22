this.scroll <- this.inherit("scripts/items/item", {
	m = {
		TreeID = "FitTree",
		Rarity = "Mythic"
	},
	function create()
	{
		this.m.ID = "misc.legend_scroll";
		this.m.Name = "Scroll of Destiny";
		this.m.Description = "Repermutate destiny... Grants the user the trait tree depicted on the scroll";
		this.m.Icon = "trade/scroll.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 1000;
		this.m.TreeID = ::MSU.Array.rand(::Const.Contracts.ScrollOptions);
	}

	function getName()
	{
		return ::MSU.Text.color(getRarityColor(), this.m.Name + " (" + ::Const.Perks[this.m.TreeID].Name + ")");
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
				type = "text",
				text = this.getRarity()
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

		foreach(row in ::Const.Perks[this.m.TreeID].Tree)
		{
			if (row.len() == 0) continue;
			foreach(perkConst in row)
			{
				result.push({
					id = 3,
					type = "text",
					icon = ::Const.Perks.PerkDefObjects[perkConst].Icon,
					text = ::Const.Perks.PerkDefObjects[perkConst].Name,
				});
			}
		}

		result.push({
			id = 65,
			type = "text",
			text = "Right-click to use on a character"
		});
		result.push({
			id = 67,
			type = "text",
			text = "Every character may use up to one scroll. Being bright increases this to 2 scrolls, and being dumb decreases this to 0 scrolls."
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/scribble.wav", ::Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		local effect = _actor.getSkills().getSkillByID("effects.scroll");
		local smart = _actor.getSkills().getSkillByID("trait.bright");

		if (_actor.getBackground().hasPerkGroup(::Const.Perks[this.m.TreeID])) return false;
		if (effect != null && (effect.m.Smart && smart != null || smart == null)) return false;
		_actor.getBackground().addPerkGroup(::Const.Perks[this.m.TreeID].Tree);

		if (effect != null) effect.m.Smart = true;
		else _actor.getSkills().add(this.new("scripts/skills/effects/legend_scroll_effect"));
		this.Sound.play("sounds/scribble.wav", ::Const.Sound.Volume.Inventory);
		return true;
	}

	function onSerialize( _out )
	{
		this.item.onSerialize(_out);
		_out.writeString(this.m.TreeID);
	}

	function onDeserialize( _in )
	{
		this.item.onDeserialize(_in);
		this.m.TreeID = _in.readString();
	}

	///
	function getRarity()
	{
		return ::MSU.Text.color(getRarityColor(), this.m.Rarity) + "\n";
	}

	function getRarityColor()
	{
		switch(this.m.Rarity)
		{
			case "Common":
				return ::Z.Color.Common;
			case "Uncommon":
				return ::Z.Color.Uncommon;
			case "Rare":
				return ::Z.Color.Rare;
			case "Legendary":
				return ::Z.Color.Legendary;
			case "Mythic":
				return ::Z.Color.Mythic;
		}
		return ::Z.Color.Common;
	}

});

