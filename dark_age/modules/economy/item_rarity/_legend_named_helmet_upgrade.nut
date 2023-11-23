::mods_hookExactClass("items/legend_helmets/legend_named_helmet_upgrade", function (o)
{
    o.m.rolled <- true;
    o.m.Rarity <- "Legendary";

    //serialize fns
    o.onSerialize = function( _out )
	{
		_out.writeString(this.m.Name);
		_out.writeF32(this.m.ConditionMax);
		_out.writeI8(this.m.StaminaModifier);
		_out.writeI8(this.m.Vision);
		this.legend_helmet_upgrade.onSerialize_original(_out);
	}

	o.onDeserialize = function( _in )
	{
		this.m.Name = _in.readString();
		this.m.ConditionMax = _in.readF32();
		this.m.StaminaModifier = _in.readI8();

		if (_in.getMetaData().getVersion() >= 68)
		{
			this.m.Vision = _in.readI8();
		}

		this.legend_helmet_upgrade.onDeserialize_original(_in);
	}
});