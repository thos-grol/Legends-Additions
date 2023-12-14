this.cursed_accessory <- this.inherit("scripts/items/accessory", {
	m = {
		CursePoints = 2
	},

	function create()
	{
		this.accessory.create();
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IsUsable = false;
		// this.m.InventorySound = "sounds/combat/armor_leather_impact_03.wav";
	}

	//func
	function onUpdateProperties( _properties )
	{
		// _properties.Stamina += this.getStaminaModifier();
	}

	function onEquip_unique()
	{
	}

	function onUnequip_unique()
	{
	}

	function getToolTip_unique(_tooltip)
	{
		return _tooltip;
	}

	//serialization
	function onSerialize( _out )
	{
		this.accessory.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.accessory.onDeserialize(_in);
		this.updateVariant();
	}

	//Helper

	function onPutIntoBag()
	{
		onEquip();
	}

	function onRemovedFromBag()
	{
		this.clearSkills();
		onUnequip();
	}

	function onEquip()
	{
		this.accessory.onEquip();

		local actor = this.getContainer().getActor();

		if (actor.getSkills().getSkillByID("effect.cursed") == null)
			actor.getSkills().add(::new("scripts/skills/effects/cursed_effect"));

		onEquip_unique();
	}

	function onUnequip()
	{
		this.accessory.onUnequip();
		onUnequip_unique();
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

		if (this.m.SlotType == this.Const.ItemSlot.Accessory)
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

		return getToolTip_unique(result);
	}

});

