this.alchemy_potion <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		Ammo = 1.0,
		AmmoMax = 1.0,
		is_alchemy_potion = true
	},
	function create()
	{
		this.accessory.create();
	}

	function refill()
	{
		this.m.Ammo = this.m.AmmoMax;
	}

	function get_refill_cost()
	{
		return (item.getAmmoMax() - item.getAmmo()) * ::Math.round((this.m.Value / item.getAmmoMax())) / 2;
	}

	function getAmmo()
	{
		return this.m.Ammo;
	}

	function getAmmoMax()
	{
		return this.m.AmmoMax;
	}

	function setAmmo( _a )
	{
		this.m.Ammo = _a;
	}

	function isAmountShown()
	{
		return true;
	}

	function getAmountString()
	{
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	function consumeAmmo()
	{
		--this.m.Ammo;
	}

	function onSerialize( _out )
	{
		this.item.onSerialize(_out);
		_out.writeU16(this.m.Ammo);
	}

	function onDeserialize( _in )
	{
		this.item.onDeserialize(_in);
		this.m.Ammo = _in.readU16();
	}
});

