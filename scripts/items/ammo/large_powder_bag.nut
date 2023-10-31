this.large_powder_bag <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.m.ID = "ammo.powder";
		this.m.Name = "Large Powder Bag";
		this.m.Description = "A large bag of black powder, used for arming exotic firearms. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/powder_bag_large.png";
		this.m.IconEmpty = "ammo/powder_bag_large_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Powder;
		this.m.ShowOnCharacter = false;
		this.m.ShowQuiver = false;
		this.m.Value = 400;
		this.m.Ammo = 7;
		this.m.AmmoMax = 7;
		this.m.IsDroppedAsLoot = true;
		this.m.is_alchemy_ammo <- true;
	}

	function refill()
	{
		this.m.Ammo = this.m.AmmoMax;
	}

	function get_refill_cost()
	{
		return (item.getAmmoMax() - item.getAmmo()) * ::Math.round((this.m.Value / item.getAmmoMax()));
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
				text = "Contains powder for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] uses"
			});
		}
		else
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Is empty and useless[/color]"
			});
		}

		return result;
	}

});

