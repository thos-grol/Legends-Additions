this.potion_of_oblivion_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.potion_of_oblivion";
		this.m.Name = "Potion of Oblivion";
		this.m.Description = "To forget is also maybe to enter the way...";
		this.m.Icon = "consumables/potion_08.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 1000;
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
			id = 3,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Can allow the drinker to break the limit!!! (20% chance)"
		});

		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		this.Sound.play("sounds/combat/drink_03.wav", this.Const.Sound.Volume.Inventory);
		_actor.resetPerks();
		if (::Math.rand(1,100) <= 20) _actor.updateLevel_limit_break();
		this.Const.Tactical.Common.checkDrugEffect(_actor);
		this.updateAchievement("MemoryLoss", 1, 1);
		return true;
	}

	//TODO: serialize whether the potion will break limit or not

});

