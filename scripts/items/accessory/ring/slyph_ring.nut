this.slyph_ring <- this.inherit("scripts/items/accessory/cursed_accessory", {
	m = {},
	function create()
	{
		this.cursed_accessory.create();
		this.m.ID = "misc.strength_ring";
		this.m.Name = "Slyph\'s Ring";
		this.m.Description = "If luck cannot pay the price, life will";
		this.m.Icon = "loot/inventory_loot_09.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Loot;
		this.m.IsDroppedAsLoot = true;
		this.m.InventorySound = "sounds/combat/armor_leather_impact_03.wav";
		this.m.Value = 1500;
		this.m.CursePoints = 3;
	}

	function onUpdateProperties( _properties )
	{
		_properties.Initiative += 25;
	}

	function getToolTip_unique(_tooltip)
	{
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::MSU.Text.colorGreen("+25") + " Initiative"
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = ::MSU.Text.colorRed("Curse 3")
		});
		return _tooltip;
	}


});

