this.legend_rune_luck <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.ID = "legend_helmet_upgrade.legend_rune_luck";
		this.m.Type = ::Const.Items.HelmetUpgrades.Rune;
		this.m.Name = "Helmet Rune Sigil: Luck";
		this.m.Description = "An inscribed rock that can be attached to a character\'s helmet.";
		this.m.ArmorDescription = "Includes an inscribed rock that grants a chance to dodge attacks.";
		this.m.Icon = "rune_sigils/rune_stone_2.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "layers/glow_runed_icon.png";
		this.m.OverlayIconLarge = "layers/glow_runed_icon.png";
		this.m.Sprite = "bust_legend_helmet_runed";
		this.m.Value = 1200;
		this.setRuneVariant(13);
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
			text = "This item has the power of the rune sigil of Luck:\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] chance to have any attacker require two successful attack rolls in order to hit."
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This item has the power of the rune sigil of Luck:\n[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] chance to have any attacker require two successful attack rolls in order to hit."
		});
	}

	function onUpdateProperties( _properties )
	{
		this.legend_helmet_upgrade.onUpdateProperties(_properties);
		_properties.RerollDefenseChance += this.m.RuneBonus1;
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

