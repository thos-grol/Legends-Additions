this.player_levitate <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.player_levitate";
		this.m.Name = "Levitating";
		this.m.Description = "This character is hovering just above the ground, able to move freely across all terrain";
		this.m.Icon = "ui/perks/levitate.png";
		this.m.IconMini = "perk_37_mini";
		this.m.Overlay = "perk_37";
		this.m.IsRemovedAfterBattle = false;
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.LegendFlightMovementAPCost;
		actor.m.FatigueCosts = this.Const.LegendFlightMovementFatigueCost;
		actor.m.LevelActionPointCost = 0;
	}

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		actor.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		actor.m.LevelActionPointCost = this.Const.Movement.LevelDifferenceActionPointCost;
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		actor.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		actor.m.LevelActionPointCost = this.Const.Movement.LevelDifferenceActionPointCost;
	}

});