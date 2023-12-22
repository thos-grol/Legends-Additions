::mods_hookExactClass("entity/world/locations/battlefield_location", function(o) {
	o.getDescription = function()
	{
		return "A battle took place here a short while ago. Broken and lost equipment, blood stains and torn ground tell of a determined fight.";
	}

	o.setSize = function( _s )
	{
		this.getSprite("body").setBrush("world_battlefield_0" + _s);
	}

	o.create = function()
	{
		this.location.create();
		this.m.Name = "Battle Site";
		this.m.TypeID = "location.battlefield";
		this.m.LocationType = ::Const.World.LocationType.Passive;
		this.m.IsDespawningDefenders = false;
		this.m.IsBattlesite = true;
		this.m.IsAttackable = false;
		this.m.Resources = 0;
		this.m.SpawnTime = this.Time.getVirtualTimeF();
	}

	o.onSpawned = function()
	{
		this.m.Name = "Battle Site";
		this.location.onSpawned();
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.Scale = 0.75;
		body.setBrush("world_battlefield_0" + ::Math.rand(1, 2));
		body.setHorizontalFlipping(::Math.rand(0, 1) == 1);
		this.registerThinker();
	}

	o.onFinish = function()
	{
		this.location.onFinish();
		this.unregisterThinker();
	}

	o.onUpdate = function()
	{
		if (this.isAlive() && !this.getSprite("selection").Visible && this.Time.getVirtualTimeF() - this.m.SpawnTime > this.World.getTime().SecondsPerDay * 2.0)
		{
			this.onCombatLost();
		}
	}

	o.onSerialize = function( _out )
	{
		this.location.onSerialize(_out);
		_out.writeF32(this.m.SpawnTime);
		_out.writeString(this.m.Description);
	}

	o.onDeserialize = function( _in )
	{
		this.location.onDeserialize(_in);
		this.m.SpawnTime = _in.readF32();
		this.m.Description = _in.readString();
	}

});

