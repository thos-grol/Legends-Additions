::mods_hookExactClass("items/legend_helmets/legend_helmet_upgrade", function (o)
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
        if (!this.Tactical.isActive()) this.m.rolled = true;
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
				type = "text",
				text = this.getRarity()
			},
			{
				id = 2,
				type = "description",
				text = this.m.Description
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getOverlayIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getOverlayIconLarge(),
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
			id = 65,
			type = "hint",
			icon = "ui/icons/mouse_right_button.png",
			text = "Right-click or left-click and drag onto the helmet of the currently selected character to attach."
		});
		result.push({
			id = 66,
			type = "hint",
			icon = "ui/icons/mouse_right_button_shift_drag.png",
			text = "Hold Shift and drag onto a helmet in the stash to attach."
		});
		result.push({
			id = 4,
			type = "progressbar",
			icon = "ui/icons/armor_head.png",
			value = this.getCondition(),
			valueMax = this.getConditionMax(),
			text = "" + this.getCondition() + " / " + this.getConditionMax() + "",
			style = "armor-head-slim"
		});

		if (this.getStaminaModifier() != 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue: " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.getStaminaModifier()) + ::Math.abs(this.getStaminaModifier()), this.getStaminaModifier())
			});
		}

		if (this.getStaminaModifier() < 0 && ::Legends.Mod.ModSettings.getSetting("ShowArmorPerFatigueValue").getValue())
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = this.format("(%.1f Armor per 1 Weight)", this.getConditionMax() / (1.0 * ::Math.abs(this.getStaminaModifier())))
			});
		}

		if (this.getVision() != 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Vision " + ::Legends.S.colorize("" + ::Legends.S.getSign(this.getVision()) + ::Math.abs(this.getVision()), this.getVision())
			});
		}

		return result;
	}

    //serialize fns

    o.onSerialize = function( _out )
	{
		this.item.onSerialize(_out);
		_out.writeBool(this.m.Visible);

        //rarity system
        _out.writeBool(this.m.rolled);
		_out.writeString(this.m.Rarity);
		_out.writeU16(this.m.Value);
        _out.writeF32(this.m.ConditionMax);
        _out.writeI8(this.m.StaminaModifier);
	}

	o.onDeserialize = function( _in )
	{
		this.item.onDeserialize(_in);
		this.m.Visible = _in.readBool();

        //rarity system
        this.m.rolled = _in.readBool();
		this.m.Rarity = _in.readString();
		this.m.Value = _in.readU16();
        this.m.ConditionMax = _in.readF32();
        this.m.StaminaModifier = _in.readI8();
	}

    o.onSerialize_original <- function( _out )
	{
		this.item.onSerialize(_out);
		_out.writeBool(this.m.Visible);
	}

    o.onDeserialize_original <- function( _in )
	{
		this.item.onDeserialize(_in);
		this.m.Visible = _in.readBool();
	}

});