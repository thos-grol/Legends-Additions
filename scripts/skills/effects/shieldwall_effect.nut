this.shieldwall_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.shieldwall";
		this.m.Name = "Shieldwall";
		this.m.Description = "Having raised the shield to a protective stance, this character gains increased defense.";
		this.m.Icon = "skills/status_effect_03.png";
		this.m.IconMini = "status_effect_03_mini";
		this.m.Overlay = "status_effect_03";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap())
		{
			return 0;
		}

		local myTile = actor.getTile();
		local num = 0;

		for( local i = 0; i != 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = myTile.getNextTile(i);

				if (!tile.IsEmpty && tile.IsOccupiedByActor && this.Math.abs(myTile.Level - tile.Level) <= 1)
				{
					local entity = tile.getEntity();

					if (actor.getFaction() == entity.getFaction() && entity.getSkills().hasSkill("effects.shieldwall"))
					{
						num = ++num;
					}
				}
			}
		}

		return this.Math.min(::Const.Combat.ShieldWallMaxAllies, num) * 5;
	}

	function getTooltip()
	{
		local bonus = this.getBonus();
		local item = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		local mult = 1.0;
		local proficiencyBonus = 0;

		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription() + (bonus > 0 ? " For forming a sturdy shieldwall with allies nearby, the defense is increased further." : "")
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.Math.floor(item.getMeleeDefense() * mult + bonus + proficiencyBonus) + "[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.Math.floor(item.getRangedDefense() * mult + bonus + proficiencyBonus) + "[/color] Ranged Defense"
			}
		];
	}

	function onAdded()
	{
		local item = this.m.Container.getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(::Const.Items.ItemType.Shield))
		{
			item.onShieldUp();
		}
	}

	function onUpdate( _properties )
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		if (item.isItemType(::Const.Items.ItemType.Shield) && item.getCondition() > 0)
		{
			local mult = 1.0;
			local proficiencyBonus = 0;
			_properties.MeleeDefense += item.getMeleeDefense();
			_properties.RangedDefense += item.getRangedDefense();
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

	function onRemoved()
	{
		local item = this.m.Container.getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(::Const.Items.ItemType.Shield))
		{
			item.onShieldDown();
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus;
	}

});

