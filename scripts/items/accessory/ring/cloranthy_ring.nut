this.cloranthy_ring <- this.inherit("scripts/items/accessory/cursed_accessory", {
	m = {},
	function create()
	{
		this.cursed_accessory.create();
		this.m.ID = "misc.cloranthy_ring";
		this.m.Name = "Cloranthy Ring";
		this.m.Description = "If luck cannot pay the price, life will";
		this.m.Icon = "loot/inventory_loot_09.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Loot;
		this.m.IsDroppedAsLoot = true;
		this.m.InventorySound = "sounds/combat/armor_leather_impact_03.wav";
		this.m.Value = 1500;
	}

	function onUpdateProperties( _properties )
	{
		_properties.FatigueRecoveryRate += 10;
	}

	function getToolTip_unique(_tooltip)
	{
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::MSU.Text.colorGreen("+10") + " Fatigue Recovery per turn"
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = ::MSU.Text.colorRed("Curse 2")
		});
		return _tooltip;
	}


});

