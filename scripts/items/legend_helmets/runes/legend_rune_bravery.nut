this.legend_rune_bravery <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.ID = "legend_helmet_upgrade.legend_rune_bravery";
		this.m.Type = ::Const.Items.HelmetUpgrades.Rune;
		this.m.Name = "Helmet Rune Sigil: Bravery";
		this.m.Description = "An inscribed rock that can be attached to a character\'s helmet.";
		this.m.ArmorDescription = "Includes An inscribed rock that grants additional bravery bonuses.";
		this.m.Icon = "rune_sigils/rune_stone_2.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "layers/glow_runed_icon.png";
		this.m.OverlayIconLarge = "layers/glow_runed_icon.png";
		this.m.Sprite = "bust_legend_helmet_runed";
		this.m.Value = 1200;
		this.setRuneVariant(12);
		this.setRuneBonus(false);
	}

	function updateVariant()
	{
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This item has the power of the rune sigil of Bravery:\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] Resolve.\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus2 + "[/color] Resolve at all morale checks."
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This item has the power of the rune sigil of Bravery:\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] Resolve.\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus2 + "[/color] Resolve at all morale checks."
		});
	}

	function onUpdateProperties( _properties )
	{
		this.legend_helmet_upgrade.onUpdateProperties(_properties);
		_properties.Bravery *= 1.0 + this.m.RuneBonus1 * 1.0 / 100.0;
		_properties.MoraleCheckBravery[0] += this.m.RuneBonus2;
		_properties.MoraleCheckBravery[1] += this.m.RuneBonus2;
		_properties.MoraleCheckBravery[2] += this.m.RuneBonus2;
	}

	function onUse( _actor, _item = null )
	{
		if (!::Z.hasVala()) return false
		if (this.isUsed()) return false;
		local armor = _item == null ? _actor.getItems().getItemAtSlot(::Const.ItemSlot.Head) : _item;
		if (armor == null) return false;
		local success = armor.setUpgrade(this);
		if (success) this.Sound.play("sounds/inventory/armor_upgrade_use_01.wav", ::Const.Sound.Volume.Inventory);
		return success;
	}

	function onUnequip()
	{
		if (!::Z.hasVala()) return false
		this.item.onUnequip();
		if (::Legends.Mod.ModSettings.getSetting("AutoRepairLayer").getValue() && this.getCondition() != this.getConditionMax())
		{
			this.setToBeRepaired(true, 0);
		}
		this.setCurrentSlotType(::Const.ItemSlot.None);
	}

});

