this.legend_fortify_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.legend_fortify";
		this.m.Name = "Fortify";
		this.m.Description = "This character is behind a protective towershield, and gains increased defense.";
		this.m.Icon = "skills/status_effect_03.png";
		this.m.IconMini = "status_effect_03_mini";
		this.m.Overlay = "status_effect_03";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + item.getMeleeDefense() + "[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + item.getRangedDefense() + "[/color] Ranged Defense"
			}
		];
	}

	function onUpdate( _properties )
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		if (item.isItemType(::Const.Items.ItemType.Shield) && item.getCondition() > 0)
		{
			local mult = 1.0;

			_properties.MeleeDefense += item.getMeleeDefense();
			_properties.RangedDefense += item.getRangedDefense();
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

	function onAdded()
	{
		local item = this.m.Container.getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(::Const.Items.ItemType.Shield))
		{
			item.onShieldUp();
		}
	}

	function onRemoved()
	{
		local item = this.m.Container.getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(::Const.Items.ItemType.Shield))
		{
			item.onShieldDown();
		}
	}

});

