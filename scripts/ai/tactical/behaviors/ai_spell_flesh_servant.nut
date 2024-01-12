this.ai_spell_flesh_servant <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.spell.flesh_servant_summon"
		],
		Skill = null,
		Tile_ = null

	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.SpellFleshServant;
		this.m.Order = ::Const.AI.Behavior.Order.SpellFleshServant;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;
		this.m.Tile_ = null;

		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP) return ::Const.AI.Behavior.Score.Zero;
		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing) return ::Const.AI.Behavior.Score.Zero;

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);
		if (this.m.Skill == null) return ::Const.AI.Behavior.Score.Zero;
		if (!this.m.Skill.isUsable()) return ::Const.AI.Behavior.Score.Zero;

		local result = {
			Tiles = [],
			Num = 0
		};
		local onQueryTilesHit = function( _tile, result )
		{
			if (!_tile.IsEmpty) return;
			result.Tiles.push(_tile);
			result.Num += 1;
		};
		this.Tactical.queryTilesInRange(_entity.getTile(), 1, 1, false, [], onQueryTilesHit, result);
		if (result.Num == 0) return ::Const.AI.Behavior.Score.Zero;
		this.m.Tile_ = ::MSU.Array.rand(result.Tiles);

		return ::Const.AI.Behavior.Score.RaiseUndead * 3;
	}

	function onExecute( _entity )
	{
		if (::Const.AI.VerboseMode)
		{
			this.logInfo("* " + _entity.getName() + ": Using Summon Flesh Servant!");
		}

		this.m.Skill.use(this.m.Tile_);
		if (!_entity.isHiddenToPlayer()) this.getAgent().declareAction();
		this.m.Skill = null;
		this.m.Tile_ = null;
		return true;
	}

});

