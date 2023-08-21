//Finally deciphered spawning code and wrote custom single boss spawning code.
::Const.World.Common.la_assignTroops_single <- function (_party, _troop, _parameters)
{
	local p;
	_party.setMovementSpeed(_parameters.MovementSpeedMult * this.Const.World.MovementSettings.Speed);
    _party.setVisibilityMult(_parameters.VisibilityMult);
    _party.setVisionRadius(_parameters.VisionMult * ::Const.World.Settings.Vision);
	_party.getSprite("body").setBrush(_parameters.Body);
	::Const.World.Common.la_addTroop(_party, _troop);
	_party.updateStrength();
	return p;
};

::Const.World.Common.la_spawnEntity_single <- function ( _faction, _tile, _name, _uniqueName, _troop, _parameters)
{
	local party = ::World.spawnEntity("scripts/entity/world/party", _tile.Coords);
	party.setFaction(_faction.getID());

	if (_uniqueName) _name = _faction.getUniqueName(_name);
	party.setName(_name);

	local t;
	if (_troop != null) t = ::Const.World.Common.la_assignTroops_single(party, _troop, _parameters);
	party.getSprite("base").setBrush(_faction.m.Base);
	if (t != null) party.getSprite("body").setBrush(t.Body);
	if (_faction.m.BannerPrefix != "") party.getSprite("banner").setBrush(_faction.m.BannerPrefix + (_faction.m.Banner < 10 ? "0" + _faction.m.Banner : _faction.m.Banner));
	_faction.addUnit(party);
	return party;
};

::Const.World.Common.la_addTroop <- function ( _party, _troop)
{
	local troop = clone _troop;
	troop.Party <- this.WeakTableRef(_party);
	troop.Faction <- _party.getFaction();
	troop.Name <- "";
	_party.getTroops().push(troop);
	return troop;
};

