::mods_hookExactClass("items/weapons/weapon", function (o)
{
    o.m.rolled <- false;
    o.m.Rarity <- "Rare";

    o.onAddedToStash <- function( _stashID )
	{
		this.m.rolled = true;
	}

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

        roll = ::Math.rand(80, 100);
        diff += 100 - roll;
        this.m.RegularDamage = ::Math.round(this.m.RegularDamage * roll  * 0.01);

		roll = ::Math.rand(80, 100);
        diff += 100 - roll;
        this.m.RegularDamageMax = ::Math.round(this.m.RegularDamageMax * roll * 0.01);

		roll = ::Math.round(::Math.rand(0, 50) / 10.0);
        diff += roll * 4;
        this.m.FatigueOnSkillUse = this.m.FatigueOnSkillUse + roll;

		local pct = diff / 100.0;
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


    //Tooltips

    o.getTooltip = function ()
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
			}
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
			id = 65,
			type = "text",
			text = this.m.Categories
		});
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.m.ConditionMax > 1)
		{
			result.push({
				id = 4,
				type = "progressbar",
				icon = "ui/icons/asset_supplies.png",
				value = this.getCondition(),
				valueMax = this.getConditionMax(),
				text = "" + this.getCondition() + " / " + this.getConditionMax() + "",
				style = "armor-body-slim"
			});
		}

		if (this.m.RegularDamage > 0)
		{
			result.push({
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Damage of [color=" + ::Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] - [color=" + ::Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color]"
			});
		}

		if (this.m.DirectDamageMult > 0)
		{
			result.push({
				id = 64,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + ::Const.UI.Color.DamageValue + "]" + ::Math.floor((this.m.DirectDamageMult + this.m.DirectDamageAdd) * 100) + "%[/color] of damage ignores armor"
			});
		}

		if (this.m.ArmorDamageMult > 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "[color=" + ::Const.UI.Color.DamageValue + "]" + ::Math.floor(this.m.ArmorDamageMult * 100) + "%[/color] effective against armor"
			});
		}

		if (this.m.ShieldDamage > 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/shield_damage.png",
				text = "Shield damage of [color=" + ::Const.UI.Color.DamageValue + "]" + this.m.ShieldDamage + "[/color]"
			});
		}

		if (this.m.ChanceToHitHead > 0)
		{
			result.push({
				id = 9,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "Chance to hit head [color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.ChanceToHitHead + "%[/color]"
			});
		}

		if (this.m.AdditionalAccuracy > 0)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has an additional [color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.AdditionalAccuracy + "%[/color] chance to hit"
			});
		}
		else if (this.m.AdditionalAccuracy < 0)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has an additional [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.AdditionalAccuracy + "%[/color] chance to hit"
			});
		}

		if (this.m.RangeMax > 1)
		{
			result.push({
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Range of [color=" + ::Const.UI.Color.PositiveValue + "]" + this.getRangeMax() + "[/color] tiles"
			});
		}

		if (this.m.StaminaModifier < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Weight: [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color]"
			});
		}

		if (this.m.FatigueOnSkillUse > 0 && (this.getContainer() == null || !this.getContainer().getActor().getCurrentProperties().IsProficientWithHeavyWeapons))
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Weapon skills build up [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.FatigueOnSkillUse + "[/color] more fatigue"
			});
		}
		else if (this.m.FatigueOnSkillUse < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Weapon skills build up [color=" + ::Const.UI.Color.PositiveValue + "]" + this.m.FatigueOnSkillUse + "[/color] less fatigue"
			});
		}

		if (this.m.AmmoMax > 0)
		{
			if (this.m.Ammo != 0)
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/ammo.png",
					text = "Contains ammo for [color=" + ::Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] uses"
				});
			}
			else
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + ::Const.UI.Color.NegativeValue + "]Is empty and useless[/color]"
				});
			}
		}

		if (this.isRuned())
		{
			result.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = this.getRuneSigilTooltip()
			});
		}

		return result;
	}



    //Serialization

    o.onSerialize = function( _out )
	{
		_out.writeBool(this.m.rolled);
		_out.writeString(this.m.Rarity);
		_out.writeU16(this.m.Value);
        _out.writeF32(this.m.ConditionMax);
        _out.writeI8(this.m.StaminaModifier);
        _out.writeU16(this.m.RegularDamage);
        _out.writeU16(this.m.RegularDamageMax);
		_out.writeI16(this.m.FatigueOnSkillUse);
        _out.writeF32(0);

        //Vanilla
        this.item.onSerialize(_out);
		_out.writeU16(this.m.Ammo);
	}

	o.onDeserialize = function( _in )
	{
		this.m.rolled = _in.readBool();
		this.m.Rarity = _in.readString();
		this.m.Value = _in.readU16();
        this.m.ConditionMax = _in.readF32();
        this.m.StaminaModifier = _in.readI8();
        this.m.RegularDamage = _in.readU16();
        this.m.RegularDamageMax = _in.readU16();
		this.m.FatigueOnSkillUse = _in.readI16();
        _in.readF32();

        //Vanilla
        this.item.onDeserialize(_in);
		this.m.Condition = ::Math.minf(this.m.ConditionMax, this.m.Condition);
		this.m.Ammo = _in.readU16();

		if (this.m.Ammo != 0 && this.m.AmmoMax == 0) this.m.AmmoMax = this.m.Ammo;
		if (this.isRuned()) this.updateRuneSigil();
	}

    o.onSerialize_original <- function( _out )
	{
		this.item.onSerialize(_out);
		_out.writeU16(this.m.Ammo);
	}

    o.onDeserialize_original <- function( _in )
	{
		this.item.onDeserialize(_in);
		this.m.Condition = ::Math.minf(this.m.ConditionMax, this.m.Condition);
		this.m.Ammo = _in.readU16();

		if (this.m.Ammo != 0 && this.m.AmmoMax == 0)
		{
			this.m.AmmoMax = this.m.Ammo;
		}

		if (this.isRuned())
		{
			this.updateRuneSigil();
		}
	}


});