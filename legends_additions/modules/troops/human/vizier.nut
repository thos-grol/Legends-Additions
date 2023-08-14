::Const.Tactical.Actor.Noble = {
	XP = 300,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 75,
	Stamina = 125,
	MeleeSkill = 75,
	RangedSkill = 60,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
::mods_hookExactClass("entity/tactical/humans/vizier", function(o) {
	o.getProperties = function()
	{
		return this.m.Properties;
	}

	o.getTitles = function()
	{
		return this.m.Titles;
	}

	o.onOtherActorDeath = function( _killer, _victim, _skill )
	{
		if (_victim.getType() == this.Const.EntityType.Slave && _victim.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorDeath(_killer, _victim, _skill);
	}

	o.onOtherActorFleeing = function( _actor )
	{
		if (_actor.getType() == this.Const.EntityType.Slave && _actor.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorFleeing(_actor);
	}

	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Noble);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.getSprite("socket").setBrush("bust_base_southern");
	}

	o.assignRandomEquipment = function()
	{
		local r;
		r = this.Math.rand(1, 8);
		local withDetails = true;
		local alwaysWithDetails = false;
		local withHelmet = true;
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"oriental/padded_mail_and_lamellar_hauberk"
			],
			[
				1,
				"oriental/mail_and_lamellar_plating"
			],
			[
				1,
				"oriental/vizier_gear"
			]
		]));

		if (withDetails && (alwaysWithDetails || this.Math.rand(1, 100) <= 50))
		{
			local variants = [
				"03",
				"04"
			];
			this.getSprite("surcoat").setBrush("bust_desert_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
		}

		if (withHelmet && this.Math.rand(1, 100) <= 80)
		{
			local helmet = [
				[
					5,
					"oriental/vizier_headgear"
				],
				[
					1,
					"legend_noble_southern_crown"
				],
				[
					1,
					"legend_noble_southern_hat"
				]
			];
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
		}
	}

	o.onSerialize = function( _out )
	{
		this.human.onSerialize(_out);
		_out.writeU8(this.m.Properties.len());

		foreach( p in this.m.Properties )
		{
			_out.writeU32(p);
		}

		_out.writeU8(this.m.Titles.len());

		foreach( t in this.m.Titles )
		{
			_out.writeString(t);
		}
	}

	o.onDeserialize = function( _in )
	{
		this.human.onDeserialize(_in);
		local numProperties = _in.readU8();
		this.m.Properties.resize(numProperties);

		for( local i = 0; i < numProperties; i = i )
		{
			this.m.Properties[i] = _in.readU32();
			i = ++i;
		}

		local numTitles = _in.readU8();
		this.m.Titles.resize(numTitles);

		for( local i = 0; i < numTitles; i = i )
		{
			this.m.Titles[i] = _in.readString();
			i = ++i;
		}
	}

});

