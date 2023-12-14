this.master_ring <- this.inherit("scripts/items/accessory/cursed_accessory", {
	m = {},
	function create()
	{
		this.cursed_accessory.create();
		this.m.ID = "misc.master_ring";
		this.m.Name = "Master\'s Ring";
		this.m.Description = "If luck cannot pay the price, life will";
		this.m.Icon = "loot/inventory_loot_09.png";
		this.m.InventorySound = "sounds/combat/armor_leather_impact_03.wav";
		this.m.Value = 1500;
		this.m.CursePoints = 1;
	}

	function onUpdateProperties( _properties )
	{
		_properties.TargetAttractionMult *= 1.5;

		local actor = this.getContainer().getActor();
		if (actor.getHitpoints() / actor.getHitpointsMax() < 0.9) return;
		_properties.DamageRegularMin += 15;
		_properties.DamageRegularMax += 15;
		_properties.DamageDirectAdd += 0.15;
	}

	function getToolTip_unique(_tooltip)
	{
		_tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = ::MSU.Text.colorGreen("+15") + " Damage"
		});
		_tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = ::MSU.Text.colorGreen("+15%") + " Armor Penetration"
		});
		_tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = ::MSU.Text.colorRed("+50%") + " Target Attraction"
		});
		_tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::MSU.Text.colorRed("The above effects only work when the user is over 90% hp")
		});
		_tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = ::MSU.Text.colorRed("Curse 1")
		});
		return _tooltip;
	}


});

