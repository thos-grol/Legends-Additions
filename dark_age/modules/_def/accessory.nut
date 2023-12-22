::mods_hookExactClass("items/accessory/accessory", function (o)
{
    o.m.Rarity <- "Rare";

    o.getTooltip_unique <- function(_tooltip)
    {
        return _tooltip;
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

		if (this.m.SlotType == ::Const.ItemSlot.Accessory)
		{
			result.push({
				id = 64,
				type = "text",
				text = "Worn in Accessory Slot"
			});
		}
		else
		{
			result.push({
				id = 64,
				type = "text",
				text = "Carried in Bag"
			});
		}

		result.push({
			id = 65,
			type = "text",
			text = "Usable in Combat"
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

		if (this.m.StaminaModifier < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color]"
			});
		}
		else if (this.m.StaminaModifier > 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=" + ::Const.UI.Color.PositiveValue + "]" + this.m.StaminaModifier + "[/color]"
			});
		}

		if (this.m.StashModifier > 0)
		{
			result.push({
				id = 9,
				type = "text",
				icon = "ui/icons/bag.png",
				text = "Provides [color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.StashModifier + "[/color] stash spaces. If you remove this accessory, spaces at the bottom of the stash will be lost, along with any items in those spaces."
			});
		}

        result = getTooltip_unique(result);

		return result;
	}

    o.getName <- function()
	{
		return ::MSU.Text.color(getRarityColor(), this.m.Name);
	}

	o.getRarity <- function()
	{
		return ::MSU.Text.color(getRarityColor(), this.m.Rarity) + "\n";
	}

	o.getRarityColor <- function()
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