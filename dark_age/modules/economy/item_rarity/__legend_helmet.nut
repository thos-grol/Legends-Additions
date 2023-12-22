::mods_hookExactClass("items/legend_helmets/legend_helmet", function (o)
{
    o.m.rolled <- false;
    o.m.Rarity <- "Rare";

    o.onAddedToStash <- function( _stashID )
	{
		this.m.rolled = true;
	}

    //roll fns
    o.roll_values <- function()
	{
        if (this.m.rolled) return;
		this.m.rolled = true;

        local roll = 0;
        local diff = 0;

		if (this.m.ConditionMax > 1)
		{
			roll = ::Math.rand(80, 100);
            diff += 100 - roll;
            this.m.Condition = ::Math.round(this.m.Condition * roll * 0.01) * 1.0;
			this.m.ConditionMax = this.m.Condition;
		}

        roll = ::Math.rand(100, 140);
        diff += (roll - 100) / 2;
        this.m.StaminaModifier = ::Math.round(this.m.StaminaModifier * roll * 0.01);

		local pct = diff / 40.0;
        if (pct <= 0.1) this.m.Rarity = "Rare";
        else if (pct <= 0.4)
		{
			this.m.Rarity = "Uncommon";
			this.m.Value = ::Math.round(0.8 * this.m.Value);
		}
        else
		{
			this.m.Rarity = "Common";
			this.m.Value = ::Math.round(0.6 * this.m.Value);
		}
	}

    //helper
    o.setUpgrade = function( _upgrade ) //roll upgrades
	{
		if (_upgrade == null) return true;
		if (_upgrade != null && this.m.Blocked[_upgrade.getType()]) return false;

		local slot = _upgrade.getType();
		if (slot == ::Const.Items.HelmetUpgrades.Vanity && this.m.Upgrades[::Const.Items.HelmetUpgrades.Vanity] != null) slot = ::Const.Items.HelmetUpgrades.ExtraVanity;

		local oldIndex;
		if (("Assets" in this.World) && this.World.Assets.getStash()) oldIndex = this.World.Assets.getStash().getItemByInstanceID(_upgrade.getInstanceID());
		if (oldIndex != null) oldIndex = oldIndex.index;


		local oldItem;
		if (this.m.Upgrades[slot] != null) oldItem = this.removeUpgrade(slot);

		this.m.Upgrades[slot] = _upgrade;
        try {_upgrade.roll_values();} catch(exception){}

		_upgrade.setArmor(this);
		_upgrade.setVisible(true);

		if (this.m.Container != null)
		{
			if (slot != ::Const.Items.HelmetUpgrades.ExtraVanity) _upgrade.onEquip();
			this.getContainer().getActor().getSkills().update();
		}

		local result = {
			item = null,
			index = oldIndex
		};

		if (oldItem != null && !oldItem.isDestroyedOnRemove())
		{
			result.item = oldItem;
		}

		this.updateAppearance();
		return result;
	}

	o.getName <- function()
	{
		return ::MSU.Text.color(getRarityColor(), this.m.Name);
	}

	o.getRarity <- function()
	{
		return ::MSU.Text.color(getRarityColor(), this.m.Rarity) + "\n";
	}

	o.getRarityColor <- function()
	{
		switch(this.m.Rarity)
		{
			case "Common":
				return ::Z.Color.Common;
			case "Uncommon":
				return ::Z.Color.Uncommon;
			case "Rare":
				return ::Z.Color.Rare;
			case "Legendary":
				return ::Z.Color.Legendary;
			case "Mythic":
				return ::Z.Color.Mythic;
		}

		return ::Z.Color.Common;
	}

    //tooltip fns

    o.getTooltip = function()
	{
		local description = this.getDescription();

		foreach( u in this.m.Upgrades )
		{
			if (u != null)
			{
				description = description + (" " + u.getArmorDescription());
			}
		}

		local result = [
			{
				id = 1,
				type = "title",
				text = this.makeName()
			},
            {
				id = 2,
				type = "text",
				text = this.getRarity()
			},
			{
				id = 2,
				type = "description",
				text = description
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		result.push({
			id = 3,
			type = "image",
			image = this.m.IconLarge != "" ? this.m.IconLarge : this.m.Icon,
			isLarge = this.m.IconLarge != "" ? true : false
		});

		foreach( u in this.m.Upgrades )
		{
			if (u != null)
			{
				if (u.getIconLarge() != null)
				{
					result.push({
						id = 3,
						type = "image",
						image = u.getIconLarge(),
						isLarge = true
					});
				}
				else
				{
					result.push({
						id = 3,
						type = "image",
						image = u.getIcon()
					});
				}
			}
		}

		result.push({
			id = 4,
			type = "progressbar",
			icon = "ui/icons/armor_head.png",
			value = ::Math.floor(this.getArmor()),
			valueMax = ::Math.floor(this.getArmorMax()),
			text = "" + ::Math.floor(this.getArmor()) + " / " + ::Math.floor(this.getArmorMax()) + "",
			style = "armor-head-slim"
		});

		if (this.getStaminaModifier() != 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Weight: " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.getStaminaModifier()) + ::Math.abs(this.getStaminaModifier()), this.getStaminaModifier())
			});
		}

		if (this.getStaminaModifier() < 0 && ::Legends.Mod.ModSettings.getSetting("ShowArmorPerFatigueValue").getValue())
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = this.format("(%.1f Armor per 1 Weight)", this.getArmorMax() / (1.0 * ::Math.abs(this.getStaminaModifier())))
			});
		}

		if (this.getVision() != 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Combined Vision: " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.getVision()) + ::Math.abs(this.getVision()), this.getVision())
			});
		}

		local upgradeNum = this.m.Upgrades.filter(function ( idx, val )
		{
			return val != null;
		}).len();

		if (upgradeNum > 0 && ::Legends.Mod.ModSettings.getSetting("ShowExpandedArmorLayerTooltip").getValue())
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/blank.png",
				text = " "
			});
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_head.png",
				text = "[u]" + this.getName() + "[/u]"
			});
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_head.png",
				text = "Armor: " + this.m.ConditionMax
			});

			if (this.m.StaminaModifier != 0)
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Weight: " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.m.StaminaModifier) + ::Math.abs(this.m.StaminaModifier), this.m.StaminaModifier)
				});
			}

			if (this.m.Vision != 0)
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/vision.png",
					text = "Vision " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.m.Vision) + ::Math.abs(this.m.Vision), this.m.Vision)
				});
			}
		}

		this.doOnFunction("getArmorTooltip", [
			result
		], true, true);

		if (this.isRuned())
		{
			result.push({
				id = 20,
				type = "text",
				icon = "ui/icons/blank.png",
				text = " "
			});
			result.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = this.getRuneSigilTooltip()
			});
		}

		if (upgradeNum > 0)
		{
			result.push({
				id = 65,
				type = "hint",
				icon = "ui/icons/mouse_right_button_shift.png",
				text = "Shift + Right-click to remove all layers."
			});
		}

		return result;
	}



    //serialize fns

    o.onSerialize = function( _out )
	{
		this.helmet.onSerialize(_out);
		_out.writeF32(this.m.Condition);

        //rarity system
        _out.writeBool(this.m.rolled);
		_out.writeString(this.m.Rarity);
		_out.writeU16(this.m.Value);
        _out.writeF32(this.m.ConditionMax);
        _out.writeI8(this.m.StaminaModifier);

		//upgrades
        _out.writeU8(this.m.Upgrades.len());
		foreach( i, upgrade in this.m.Upgrades )
		{
			if (upgrade == null)
			{
				_out.writeBool(false);
			}
			else
			{
				_out.writeBool(true);
				_out.writeI32(upgrade.ClassNameHash);
				upgrade.onSerialize(_out);
			}
		}
	}

	o.onDeserialize = function( _in )
	{
		this.helmet.onDeserialize(_in);
		this.m.Condition = ::Math.minf(this.m.ConditionMax, _in.readF32());

        //rarity system
        this.m.rolled = _in.readBool();
		this.m.Rarity = _in.readString();
		this.m.Value = _in.readU16();
        this.m.ConditionMax = _in.readF32();
        this.m.StaminaModifier = _in.readI8();

        //upgrades
        local count = _in.readU8();
		this.m.Upgrades = [];
		for( local i = 0; i < ::Const.Items.HelmetUpgrades.COUNT; i = i )
		{
			this.m.Upgrades.push(null);
			i = ++i;
		}

		for( local i = 0; i < count; i = i )
		{
			if (_in.readBool())
			{
				local item = this.new(this.IO.scriptFilenameByHash(_in.readI32()));
				item.onDeserialize(_in);
				this.m.Upgrades[i] = item;
				this.m.Upgrades[i].setArmor(this);
			}

			i = ++i;
		}

		this.updateVariant();

		if (this.isRuned())
		{
			this.updateRuneSigil();
		}
	}

});