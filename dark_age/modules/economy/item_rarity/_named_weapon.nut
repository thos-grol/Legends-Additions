::mods_hookExactClass("items/weapons/named/named_weapon", function (o)
{
    o.m.rolled <- true;
    o.m.Rarity <- "Legendary";
    o.onSerialize = function( _out )
    {
        _out.writeString(this.m.Name);
        _out.writeF32(this.m.ConditionMax);
        _out.writeI8(this.m.StaminaModifier);
        _out.writeU16(this.m.RegularDamage);
        _out.writeU16(this.m.RegularDamageMax);
        _out.writeF32(this.m.ArmorDamageMult);
        _out.writeU8(this.m.ChanceToHitHead);
        _out.writeU16(this.m.ShieldDamage);
        _out.writeI16(this.m.AdditionalAccuracy);
        _out.writeF32(this.m.DirectDamageAdd);
        _out.writeI16(this.m.FatigueOnSkillUse);
        _out.writeU16(this.m.AmmoMax);
        _out.writeF32(0);
        this.weapon.onSerialize_original(_out);
    }

    o.onDeserialize = function( _in )
    {
        this.m.Name = _in.readString();
        this.m.ConditionMax = _in.readF32();
        this.m.StaminaModifier = _in.readI8();
        this.m.RegularDamage = _in.readU16();
        this.m.RegularDamageMax = _in.readU16();
        this.m.ArmorDamageMult = _in.readF32();
        this.m.ChanceToHitHead = _in.readU8();
        this.m.ShieldDamage = _in.readU16();
        this.m.AdditionalAccuracy = this.Const.Serialization.Version <= 63 ? _in.readU16() : _in.readI16();
        this.m.DirectDamageAdd = _in.readF32();
        this.m.FatigueOnSkillUse = _in.readI16();
        this.m.AmmoMax = _in.readU16();
        _in.readF32();
        this.weapon.onDeserialize_original(_in);
        this.updateVariant();

        if (this.isRuned())
        {
            this.updateRuneSigil();
        }
    }
});