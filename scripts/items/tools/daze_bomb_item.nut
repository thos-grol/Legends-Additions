this.daze_bomb_item <- this.inherit("scripts/items/tools/alchemy_tool", {
	m = {},
	function create()
	{
		this.alchemy_tool.create();
		this.m.ID = "weapon.daze_bomb";
		this.m.Name = "Flash Pot";
		this.m.Description = "A throwable pot filled with mysterious powders that react violently on impact to create a bright flash and loud bang. Will daze anyone close by.";
		this.m.IconLarge = "tools/daze_bomb_01.png";
		this.m.Icon = "tools/daze_bomb_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Tool;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_daze_bomb_01";
		this.m.Value = 500;
		this.m.RangeMax = 3;
		this.m.StaminaModifier = 0;
		this.m.IsDroppedAsLoot = true;
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
		result.push({
			id = 64,
			type = "text",
			text = "Worn in Offhand"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RangeMax + "[/color] tiles"
		});
		result.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Will give up to [color=" + this.Const.UI.Color.DamageValue + "]7[/color] targets the Dazed status effect for 2 turns"
		});

		if (this.m.Ammo <= 0.0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Needs to be restocked by an alchemist[/color]"
			});
		}

		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/move_pot_clay_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill = this.new("scripts/skills/actives/throw_daze_bomb_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}

});

