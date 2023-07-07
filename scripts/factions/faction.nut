this.faction <- {
	m = {
		ID = 0,
		Name = "",
		Description = "",
		Motto = "",
		BannerPrefix = "",
		Banner = 1,
		Base = "",
		TacticalBase = "",
		Traits = [],
		CombatMusic = [],
		Footprints = this.Const.GenericFootprints,
		Type = this.Const.FactionType.None,
		PlayerRelation = 50.0,
		PlayerRelationChanges = [],
		RelationDecayPerDay = this.Const.Factions.RelationDecayPerDay,
		Flags = null,
		Settlements = [],
		Units = [],
		Allies = [],
		Deck = [],
		Contracts = [],
		LastActionTime = 0,
		LastActionHour = 0,
		LastContractTime = 0,
		MaxUnits = 0,
		IsDiscovered = false,
		IsHiddenIfNeutral = false,
		IsHidden = false,
		IsRelationDecaying = true,
		IsTemporaryEnemy = false,
		IsActive = true
	},
	function getID()
	{
		return this.m.ID;
	}

	function getName()
	{
		return this.m.Name;
	}

	function getDescription()
	{
		return this.m.Description;
	}

	function getMotto()
	{
		return this.m.Motto;
	}

	function getBanner()
	{
		return this.m.Banner;
	}

	function getBannerString()
	{
		return this.m.Banner < 10 ? "0" + this.m.Banner : this.m.Banner;
	}

	function getBannerSmall()
	{
		return "";
	}

	function getPartyBanner()
	{
		return this.m.BannerPrefix + (this.m.Banner < 10 ? "0" + this.m.Banner : this.m.Banner);
	}

	function getTacticalBase()
	{
		return this.m.TacticalBase;
	}

	function getFootprints()
	{
		return this.m.Footprints;
	}

	function getUIBanner()
	{
		return "ui/banners/factions/banner_" + (this.m.Banner < 10 ? "0" + this.m.Banner : this.m.Banner) + ".png";
	}

	function getUIBannerSmall()
	{
		return "ui/banners/factions/banner_" + (this.m.Banner < 10 ? "0" + this.m.Banner : this.m.Banner) + "s.png";
	}

	function getColor()
	{
		return this.createColor("#ffffff");
	}

	function getCombatMusic()
	{
		return this.m.CombatMusic;
	}

	function getType()
	{
		return this.m.Type;
	}

	function getPlayerRelation()
	{
		return this.m.PlayerRelation;
	}

	function getPlayerRelationChanges()
	{
		return this.m.PlayerRelationChanges;
	}

	function getFlags()
	{
		return this.m.Flags;
	}

	function getSettlements()
	{
		return this.m.Settlements;
	}

	function getUnits()
	{
		return this.m.Units;
	}

	function getAllies()
	{
		return this.m.Allies;
	}

	function getRoster()
	{
		return this.World.getRoster(this.m.ID);
	}

	function getRandomCharacter()
	{
		local r = this.World.getRoster(this.m.ID).getAll();
		return r[this.Math.rand(0, r.len() - 1)];
	}

	function getOwningCharacter( _s )
	{
		return this.getRandomCharacter();
	}

	function getContracts()
	{
		return this.m.Contracts;
	}

	function isDiscovered()
	{
		return this.m.IsDiscovered;
	}

	function setDiscovered( _d )
	{
		this.m.IsDiscovered = _d;
	}

	function isTemporaryEnemy()
	{
		return this.m.IsTemporaryEnemy;
	}

	function setIsTemporaryEnemy( _f )
	{
		this.m.IsTemporaryEnemy = _f;
	}

	function isActive()
	{
		return this.m.IsActive;
	}

	function setActive( _f )
	{
		this.m.IsActive = _f;
	}

	function setName( _n )
	{
		this.m.Name = _n;
	}

	function setDescription( _d )
	{
		this.m.Description = _d;
	}

	function setMotto( _m )
	{
		this.m.Motto = _m;
	}

	function setType( _t )
	{
		this.m.Type = _t;
	}

	function setPlayerRelation( _r )
	{
		this.m.PlayerRelation = _r;
		this.updatePlayerRelation();
	}

	function setBanner( _b )
	{
		this.m.Banner = _b;
	}

	function isPlayerRelationPermanent()
	{
		return !this.m.IsRelationDecaying;
	}

	function setLastContractTime( _t )
	{
		this.m.LastContractTime = _t;
	}

	function setMaxUnits( _m )
	{
		this.m.MaxUnits = _m;
	}

	function isReadyForContract()
	{
		return true;
	}

	function isReadyToSpawnUnit()
	{
		return this.m.Settlements.len() != 0 && (this.m.MaxUnits == 0 || this.m.Units.len() < this.m.MaxUnits);
	}

	function setHiddenIfNeutral( _f )
	{
		this.m.IsHiddenIfNeutral = _f;
	}

	function isAlwaysHidden()
	{
		return this.m.IsHidden;
	}

	function isHidden()
	{
		return this.m.IsHidden || this.m.IsHiddenIfNeutral && this.Math.abs(this.m.PlayerRelation - 50.0) == 0.0;
	}

	function hasTrait( _t )
	{
		return this.m.Traits.find(_t) != null;
	}

	function normalizeRelation()
	{
		if (!this.m.IsRelationDecaying)
		{
			return;
		}

		if (this.m.PlayerRelation > 50.0)
		{
			this.setPlayerRelation(this.Math.maxf(50.0, this.m.PlayerRelation - this.m.RelationDecayPerDay * this.World.Assets.m.RelationDecayGoodMult));
		}
		else if (this.m.PlayerRelation < 50.0)
		{
			this.setPlayerRelation(this.Math.minf(50.0, this.m.PlayerRelation + this.m.RelationDecayPerDay * this.World.Assets.m.RelationDecayBadMult));
		}

		if (this.m.PlayerRelationChanges.len() != 0 && this.m.PlayerRelationChanges[this.m.PlayerRelationChanges.len() - 1].Time + this.Const.World.Assets.RelationTimeOut < this.Time.getVirtualTimeF())
		{
			this.m.PlayerRelationChanges.remove(this.m.PlayerRelationChanges.len() - 1);
		}
	}

	function addPlayerRelation( _r, _reason = "" )
	{
		this.addPlayerRelationEx(_r, _reason);
	}

	function addPlayerRelationEx( _r, _reason = "" )
	{
		this.m.PlayerRelation = this.Math.minf(100.0, this.Math.max(0.0, this.m.PlayerRelation + _r));
		this.updatePlayerRelation();

		if (_reason != "")
		{
			if (this.m.PlayerRelationChanges.len() >= 1 && this.m.PlayerRelationChanges[0].Text == _reason)
			{
				this.m.PlayerRelationChanges[0].Time = this.Time.getVirtualTimeF();
			}
			else
			{
				if (this.m.PlayerRelationChanges.len() >= 6)
				{
					this.m.PlayerRelationChanges.remove(this.m.PlayerRelationChanges.len() - 1);
				}

				this.m.PlayerRelationChanges.insert(0, {
					Positive = _r >= 0 ? true : false,
					Text = _reason,
					Time = this.Time.getVirtualTimeF()
				});
			}
		}
	}

	function getPlayerRelationAsText()
	{
		if (this.m.PlayerRelation <= 0)
		{
			this.m.PlayerRelation = 1;
		}

		return this.Const.Strings.Relations[this.Math.min(this.Const.Strings.Relations.len() - 1, this.m.PlayerRelation / 10)];
	}

	function updatePlayerRelation()
	{
		if (this.m.PlayerRelation < 20.0)
		{
			local idx = this.m.Allies.find(1);

			if (idx != null)
			{
				this.m.Allies.remove(idx);
			}

			idx = this.m.Allies.find(2);

			if (idx != null)
			{
				this.m.Allies.remove(idx);
			}
		}
		else
		{
			if (this.m.Allies.find(1) == null)
			{
				this.m.Allies.push(1);
			}

			if (this.m.Allies.find(2) == null)
			{
				this.m.Allies.push(2);
			}
		}

		foreach( s in this.m.Settlements )
		{
			s.updatePlayerRelation();
		}

		foreach( u in this.m.Units )
		{
			if (u.isAlive())
			{
				u.updatePlayerRelation();
			}
		}
	}

	function addSettlement( _s, _owner = true )
	{
		if (_s == null)
		{
			return;
		}

		_s.addFaction(this.getID());
		_s.updatePlayerRelation();
		this.m.Settlements.push(_s);

		if (_owner)
		{
			_s.setOwner(this);
		}
		else if (this.isKindOf(_s, "settlement"))
		{
			_s.onAttachedLocationsChanged();
		}
	}

	function removeSettlement( _s )
	{
		for( local i = 0; i < this.m.Settlements.len(); i = i )
		{
			if (this.m.Settlements[i].getID() == _s.getID())
			{
				this.m.Settlements.remove(i);
				break;
			}

			i = ++i;
		}
	}

	function addTrait( _t )
	{
		this.m.Traits.push(_t);

		foreach( c in this.Const.FactionTrait.Actions[_t] )
		{
			local card = this.new(c);
			card.setFaction(this);
			this.m.Deck.push(card);
		}
	}

	function addUnit( _u )
	{
		if (_u == null || _u.isLocation())
		{
			return;
		}

		_u.setFaction(this.m.ID);
		_u.setFootprints(this.m.Footprints);
		this.m.Units.push(_u);
	}

	function removeUnit( _u )
	{
		local i = this.m.Units.find(_u);

		if (i != null)
		{
			this.m.Units.remove(i);
		}
	}

	function addContract( _c )
	{
		_c.setFaction(this.getID());
		this.m.Contracts.push(_c);
	}

	function removeContract( _c )
	{
		local i = this.m.Contracts.find(_c);

		if (i != null)
		{
			this.m.Contracts.remove(i);
		}
	}

	function addAlly( _a )
	{
		if (this.m.Allies.find(_a) != null)
		{
			return;
		}

		this.m.Allies.push(_a);
	}

	function removeAlly( _a )
	{
		local i = this.m.Allies.find(_a);

		if (i != null)
		{
			this.m.Allies.remove(i);
		}
	}

	function cloneAlliesFrom( _faction )
	{
		this.m.Allies = clone _faction.m.Allies;
		this.updatePlayerRelation();
	}

	function isAlliedWith( _p )
	{
		if (this.m.IsTemporaryEnemy && (_p == 1 || _p == 2))
		{
			return false;
		}
		else
		{
			return this.m.Allies.find(_p) != null;
		}
	}

	function isAlliedWithPlayer()
	{
		return !this.m.IsTemporaryEnemy && this.m.Allies.find(1) != null;
	}

	function isEnemyNearby()
	{
		return false;
	}

	function getUniqueName( _name )
	{
		local i = 0;

		while (true)
		{
			local isUnique = true;

			foreach( u in this.m.Units )
			{
				if (u.getName() == this.Const.Strings.Quantity[i] + " " + _name)
				{
					i = ++i;
					i = i;
					isUnique = false;
					break;
				}
			}

			if (isUnique)
			{
				break;
			}
		}

		return this.Const.Strings.Quantity[i] + " " + _name;
	}

	function spawnEntity( _tile, _name, _uniqueName, _template, _resources )
	{
		local party = this.World.spawnEntity("scripts/entity/world/party", _tile.Coords);
		party.setFaction(this.getID());

		if (_uniqueName)
		{
			_name = this.getUniqueName(_name);
		}

		party.setName(_name);
		local t;

		if (_template != null)
		{
			t = this.Const.World.Common.assignTroops(party, _template, _resources);
		}

		party.getSprite("base").setBrush(this.m.Base);

		if (t != null)
		{
			party.getSprite("body").setBrush(t.Body);
		}

		if (this.m.BannerPrefix != "")
		{
			party.getSprite("banner").setBrush(this.m.BannerPrefix + (this.m.Banner < 10 ? "0" + this.m.Banner : this.m.Banner));
		}

		this.addUnit(party);
		return party;
	}

	function getNearestSettlement( _tile, _notOfType = 0 )
	{
		local d = 9000;
		local r;

		foreach( s in this.m.Settlements )
		{
			if (s.isLocationType(this.Const.World.LocationType.Unique))
			{
				continue;
			}

			if (_notOfType != 0 && !s.isLocationType(_notOfType))
			{
				continue;
			}

			local sd = s.getTile().getDistanceTo(_tile);

			if (sd < d)
			{
				d = sd;
				r = s;
			}
		}

		return r;
	}

	function getNearestUnit( _tile )
	{
		local d = 9000;
		local r;

		foreach( u in this.m.Units )
		{
			local ud = u.getTile().getDistanceTo(_tile);

			if (ud < d)
			{
				d = this.sd;
				r = u;
			}
		}

		return r;
	}

	function setID( _id )
	{
		this.m.ID = _id;
		this.addAlly(_id);
		this.World.createRoster(_id);
	}

	function getAction( _id )
	{
		foreach( a in this.m.Deck )
		{
			if (_id == a.getID())
			{
				return a;
			}
		}

		return null;
	}

	function create()
	{
		this.m.LastActionTime = this.Time.getVirtualTimeF() - this.Math.rand(0, this.World.getTime().SecondsPerDay) * 2.0;
		this.m.Flags = this.new("scripts/tools/tag_collection");
		this.m.LastContractTime = this.World.getTime().SecondsPerDay * -30.0;
		this.addAlly(0);
	}

	function update( _ignoreDelay = false, _isNewCampaign = false )
	{
		if (!this.m.IsActive)
		{
			return;
		}

		if (this.m.Deck.len() == 0)
		{
			return;
		}

		if (!_ignoreDelay && this.m.LastActionTime + this.Const.Factions.GlobalMinDelay > this.Time.getVirtualTimeF())
		{
			return;
		}

		if (!_ignoreDelay)
		{
			this.m.LastActionTime = this.Time.getVirtualTimeF();
		}

		this.onUpdateRoster();
		this.onUpdate();

		foreach( u in this.m.Units )
		{
			if (u.getTroops().len() == 0)
			{
				u.die();
			}

			if (!_ignoreDelay && this.m.Settlements.len() != 0)
			{
				if (u.getFlags().has("IsMercenaries"))
				{
					continue;
				}

				if (u.isAlive() && !u.getController().hasOrders())
				{
					local home = this.getNearestSettlement(u.getTile());
					local move = this.new("scripts/ai/world/orders/move_order");
					move.setDestination(home.getTile());
					local despawn = this.new("scripts/ai/world/orders/despawn_order");
					u.getController().addOrder(move);
					u.getController().addOrder(despawn);
				}
			}
		}

		local score = 0;
		local actionToFire;

		for( local i = 0; i < this.m.Deck.len(); i = i )
		{
			this.m.Deck[i].update(_isNewCampaign);

			if (this.m.Deck[i].getScore() <= 0)
			{
			}
			else
			{
				score = score + this.m.Deck[i].getScore();
			}

			i = ++i;
		}

		if (score == 0)
		{
			return;
		}

		local pick = this.Math.rand(1, score);

		for( local i = 0; i < this.m.Deck.len(); i = i )
		{
			if (this.m.Deck[i].getScore() <= 0)
			{
			}
			else
			{
				if (pick <= this.m.Deck[i].getScore())
				{
					actionToFire = this.m.Deck[i];
					break;
				}

				pick = pick - this.m.Deck[i].getScore();
			}

			i = ++i;
		}

		if (actionToFire == null)
		{
			return;
		}

		actionToFire.execute(_isNewCampaign);
	}

	function onUpdate()
	{
	}

	function onUpdateRoster()
	{
	}

	function onSerialize( _out )
	{
		_out.writeU8(this.m.ID);
		_out.writeString(this.m.Name);
		_out.writeString(this.m.Description);
		_out.writeString(this.m.Motto);
		_out.writeU8(this.m.Banner);
		_out.writeU8(this.m.Traits.len());

		foreach( t in this.m.Traits )
		{
			_out.writeU8(t);
		}

		_out.writeU16(this.m.Deck.len());

		for( local i = 0; i != this.m.Deck.len(); i = i )
		{
			_out.writeI32(this.m.Deck[i].ClassNameHash);
			_out.writeF32(this.m.Deck[i].getCooldownUntil());
			i = ++i;
		}

		_out.writeU8(this.m.Allies.len());

		foreach( a in this.m.Allies )
		{
			_out.writeU8(a);
		}

		_out.writeF32(this.m.PlayerRelation);
		local numSettlements = 0;

		foreach( s in this.m.Settlements )
		{
			if (s.isAlive())
			{
				numSettlements = ++numSettlements;
				numSettlements = numSettlements;
			}
		}

		_out.writeU8(numSettlements);

		foreach( s in this.m.Settlements )
		{
			if (!s.isAlive())
			{
				continue;
			}

			_out.writeI32(s.getID());

			if (s.getOwner() != null && s.getOwner().getID() == this.getID())
			{
				_out.writeBool(true);
			}
			else
			{
				_out.writeBool(false);
			}
		}

		local numUnits = 0;

		foreach( s in this.m.Units )
		{
			if (s.isAlive())
			{
				numUnits = ++numUnits;
				numUnits = numUnits;
			}
		}

		_out.writeU16(numUnits);

		foreach( s in this.m.Units )
		{
			if (s.isAlive())
			{
				_out.writeI32(s.getID());
			}
		}

		_out.writeF32(this.m.LastActionTime);
		_out.writeU8(this.m.LastActionHour);
		_out.writeF32(this.m.LastContractTime);
		_out.writeBool(this.m.IsDiscovered);
		this.m.Flags.onSerialize(_out);
		_out.writeU8(this.m.PlayerRelationChanges.len());

		for( local i = 0; i != this.m.PlayerRelationChanges.len(); i = i )
		{
			_out.writeBool(this.m.PlayerRelationChanges[i].Positive);
			_out.writeString(this.m.PlayerRelationChanges[i].Text);
			_out.writeF32(this.m.PlayerRelationChanges[i].Time);
			i = ++i;
		}
	}

	function onDeserialize( _in )
	{
		this.m.ID = _in.readU8();
		this.m.Name = _in.readString();
		this.m.Description = _in.readString();
		this.m.Motto = _in.readString();
		this.m.Banner = _in.readU8();
		local numTraits = _in.readU8();

		for( local i = 0; i < numTraits; i = i )
		{
			this.addTrait(_in.readU8());
			i = ++i;
		}

		local numCooldowns = _in.readU16();
		local cooldowns = [];

		for( local i = 0; i != numCooldowns; i = i )
		{
			local actionID = _in.readI32();
			local cooldownUntil = _in.readF32();

			for( local j = 0; j != this.m.Deck.len(); j = j )
			{
				if (this.m.Deck[j].ClassNameHash == actionID)
				{
					this.m.Deck[j].setCooldownUntil(cooldownUntil);
					break;
				}

				j = ++j;
			}

			i = ++i;
		}

		this.m.Allies = [];
		local numAllies = _in.readU8();

		for( local i = 0; i != numAllies; i = i )
		{
			local a = _in.readU8();
			this.addAlly(a);
			i = ++i;
		}

		this.m.PlayerRelation = _in.readF32();
		local numSettlements = _in.readU8();

		for( local i = 0; i != numSettlements; i = i )
		{
			local s = this.World.getEntityByID(_in.readI32());
			local owner = _in.readBool();
			this.addSettlement(s, owner);
			i = ++i;
		}

		local numUnits = _in.readU16();

		for( local i = 0; i != numUnits; i = i )
		{
			local unit = this.World.getEntityByID(_in.readI32());

			if (_in.getMetaData().getVersion() == 68 && unit.m.Name == "Ship")
			{
				unit.fadeOutAndDie();
			}
			else
			{
				this.addUnit(unit);
			}

			i = ++i;
		}

		this.m.LastActionTime = _in.readF32();
		this.m.LastActionHour = _in.readU8();
		this.m.LastContractTime = _in.readF32();
		this.m.IsDiscovered = _in.readBool();
		this.m.Flags.onDeserialize(_in);
		local numRelationChanges = _in.readU8();
		this.m.PlayerRelationChanges.resize(numRelationChanges, 0);

		for( local i = 0; i != numRelationChanges; i = i )
		{
			local relationChange = {};
			relationChange.Positive <- _in.readBool();
			relationChange.Text <- _in.readString();
			relationChange.Time <- _in.readF32();
			this.m.PlayerRelationChanges[i] = relationChange;
			i = ++i;
		}

		this.updatePlayerRelation();
	}

};

