::mods_hookExactClass("items/legend_armor/legend_named_armor_upgrade", function (o)
{
    o.m.rolled <- true;
    o.m.Rarity <- "Legendary";

    //serialize fns
    o.onSerialize = function( _out )
	{
        _out.writeString(this.m.Name);
		_out.writeF32(this.m.ConditionMax);
		_out.writeI8(this.m.StaminaModifier);
		this.legend_armor.onSerialize_original(_out);
	}

	o.onDeserialize = function( _in )
	{
        this.m.Name = _in.readString();
		this.m.ConditionMax = _in.readF32();
		this.m.StaminaModifier = _in.readI8();
		this.legend_armor.onDeserialize_original(_in);
		this.updateVariant();

		if (this.isRuned())
		{
			this.updateRuneSigil();
		}
	}

});