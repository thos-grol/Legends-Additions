this.large_quiver_of_bolts <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.m.ID = "ammo.bolts";
		this.m.Name = "Large Quiver of Bolts";
		this.m.Description = "A large quiver of bolts, required to use crossbows. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/quiver_04.png";
		this.m.IconEmpty = "ammo/quiver_04_empty.png";
		this.m.SlotType = ::Const.ItemSlot.Ammo;
		this.m.ItemType = ::Const.Items.ItemType.Ammo;
		this.m.AmmoType = ::Const.Items.AmmoType.Bolts;
		this.m.ShowOnCharacter = true;
		this.m.ShowQuiver = true;
		this.m.Sprite = "bust_quiver_01";
		this.m.Value = 98;
		this.m.Ammo = 14;
		this.m.AmmoMax = 14;
		this.m.StaminaModifier = -2;
		this.m.IsDroppedAsLoot = true;
		this.m.AddGenericSkill = true;
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
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.m.Ammo != 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Contains [color=" + ::Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] bolts"
			});
		}
		else
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Is empty and useless[/color]"
			});
		}

		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + ::Const.UI.Color.NegativeValue + "]-" + this.m.StaminaModifier + "[/color] fatigue"
		});
		return result;
	}

});

