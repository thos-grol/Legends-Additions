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
::mods_hookExactClass("entity/tactical/humans/noble", function(o) {
	o.getProperties = function()
	{
		return this.m.Properties;
	}

	o.getTitles = function()
	{
		return this.m.Titles;
	}

	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Noble);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function()
	{
		local r;
		this.m.Surcoat = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		local surcoat = "surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat);
		r = this.Math.rand(1, 7);
		local withDetails = true;
		local alwaysWithDetails = false;
		local withHelmet = true;

		if (r == 1)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"noble_tunic"
				]
			]));
			alwaysWithDetails = true;
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"coat_of_plates"
				]
			]));
			withDetails = false;
			withHelmet = false;

			if (this.Math.rand(1, 100) <= 75)
			{
				this.getSprite("surcoat").setBrush(surcoat);
			}

			if (this.Math.rand(1, 100) <= 25)
			{
				local h = this.Const.World.Common.pickHelmet([
					[
						1,
						"greatsword_faction_helm",
						this.World.FactionManager.getFaction(this.getFaction()).getBanner()
					]
				]);
				this.m.Items.equip(h);
			}

			if (this.Math.rand(1, 100) <= 33)
			{
				local variants = [
					"02",
					"10"
				];
				this.getSprite("surcoat").setBrush("bust_body_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
			}
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"coat_of_scales"
				]
			]));
			withDetails = false;
			withHelmet = false;

			if (this.Math.rand(1, 100) <= 75)
			{
				this.getSprite("surcoat").setBrush(surcoat);
			}

			if (this.Math.rand(1, 100) <= 25)
			{
				local h = this.Const.World.Common.pickHelmet([
					[
						1,
						"greatsword_faction_helm",
						this.World.FactionManager.getFaction(this.getFaction()).getBanner()
					]
				]);
				this.m.Items.equip(h);
			}

			if (this.Math.rand(1, 100) <= 33)
			{
				local variants = [
					"02",
					"10"
				];
				this.getSprite("surcoat").setBrush("bust_body_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
			}
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"noble_gear"
				]
			]));
		}

		if (withDetails && (alwaysWithDetails || this.Math.rand(1, 100) <= 50))
		{
			local variants = [
				"01",
				"02",
				"03",
				"06",
				"09",
				"10"
			];
			this.getSprite("surcoat").setBrush("bust_body_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
		}

		if (withHelmet && this.Math.rand(1, 100) <= 50)
		{
			this.Const.World.Common.pickHelmet([
				[
					1,
					""
				]
			]);
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

