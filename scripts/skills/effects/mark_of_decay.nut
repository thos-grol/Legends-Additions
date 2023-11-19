this.mark_of_decay <- this.inherit("scripts/skills/skill", {
	m = {
		Percent = 0.25,
		TurnsLeft = 3,
		Ignore = false
	},
	function create()
	{
		this.m.ID = "effects.mark_of_decay";
		this.m.Name = "Mark of Decay";
		this.m.Icon = "skills/status_effect_05.png"; //FIXME: ART Mark of Decay
		this.m.IconMini = "status_effect_05_mini";
		this.m.Overlay = "status_effect_05";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This unit has been marked by negative energy. They are fatigued by " + this.m.Percent * 100 + "% of their max fatigue on turn start";
	}

	function reset()
	{
		this.m.TurnsLeft = 3;
	}

	function onUpdate( _properties )
	{

	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local amount = ::Math.round(actor.getBaseProperties().Fatigue * this.m.Percent);
		this.applyFatigueDamage(target, amount);
		if (!actor.isHiddenToPlayer() && actor.getTile().IsVisibleForPlayer) ::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(actor) + ::MSU.Text.colorRed(" fatigue has decayed by " + amount));
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0) this.removeSelf();
	}

});

