this.cursed_crystal_skull <- this.inherit("scripts/items/accessory/cursed_accessory", {
	m = {
		UUID = 0,
		Rolled_UUID = false,
		Rarity = "Mythic",
	},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.cursed_crystal_skull";
		this.m.Name = "Cursed Crystal Skull";
		this.m.Description = "An eerie skull carved from a single large crystal. No scratch or other mark can be seen on its surface. Just being near it kills the fire of determination in almost any man, breaks hope and lets sprout doubts.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/ancient_skull.png";
		this.m.Sprite = "";
		this.m.Value = 2000;
		this.m.CursePoints = 3;
	}

	//func

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		local actor = this.getContainer().getActor();
		actor.setMaxMoraleState(this.Const.MoraleState.Steady);

		if (actor.getMoraleState() > this.Const.MoraleState.Steady)
		{
			actor.setMoraleState(this.Const.MoraleState.Steady);
			actor.setDirty(true);
		}
	}

	function onEquip_unique()
	{
		rollUUID();
		local actor = this.getContainer().getActor();

		if (actor.getSkills().getSkillByID("effect.cursed") == null)
			actor.getSkills().add(::new("scripts/skills/effects/cursed_effect"));

		if (actor.getSkills().getSkillByID("effect._curse_crystal_skull") == null)
			actor.getSkills().add(::new("scripts/skills/effects/_curse_crystal_skull"));

		//lifebound
		local has_lifebound = false;
		foreach (skill in actor.getSkills().getSkillsByFunction((@(_skill) "UUID" in _skill.m ).bindenv(this)))
		{
			if (skill.m.UUID != this.m.UUID) continue;
			has_lifebound = true;
			break;
		}

		if (!has_lifebound)
		{
			local lifebound = ::new("scripts/skills/traits/lifebound_trait");
			lifebound.setUUID(this.m.UUID);
			this.addSkill(lifebound);
		}
	}

	function onUnequip_unique()
	{
	}

	function getToolTip_unique(_tooltip)
	{
		_tooltip.push({
			id = 15,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = "On turn start, let out a horrific scream at either the holder or an enemy. The target is determined by testing the holder's resolve"
		});
		_tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = "Lifebound - if the holder starts combat without this item in their inventory, they will die"
		});
		_tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = "The holder can never have [color=" + this.Const.UI.Color.NegativeValue + "]confident[/color] morale"
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = ::MSU.Text.colorRed("Curse 3")
		});
		return _tooltip;
	}



	//serialize

	function rollUUID()
	{
		if (this.m.Rolled_UUID) return;
		this.m.UUID = ::Math.rand(0, 65534);
	}

	function onSerialize( _out )
	{
		this.cursed_accessory.onSerialize(_out);
		_out.writeU16(this.m.UUID);
		_out.writeBool(this.m.Rolled_UUID);
	}

	function onDeserialize( _in )
	{
		this.cursed_accessory.onDeserialize(_in);
		this.m.UUID = _in.readU16();
		this.m.Rolled_UUID = _in.readBool();
	}
});

