this.staggered_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},
	function create()
	{
		this.m.ID = "effects.staggered";
		this.m.Name = "Staggered";
		this.m.Icon = "skills/status_effect_65.png";
		this.m.IconMini = "status_effect_65_mini";
		this.m.Overlay = "status_effect_65";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is off-balance, scrambling, and late to act. Will wear off in [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] turn(s).";
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] Initiative"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Melee Defense"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= 0.5;
		_properties.MeleeDefense -= 25;
		_properties.RangedDefense -= 25;
	}

	function onTurnStart()
	{
		if (--this.m.TurnsLeft <= 0) this.removeSelf();
	}

	function onRefresh()
	{
		this.Tactical.TurnSequenceBar.pushEntityBack(this.getContainer().getActor().getID());
		local tile = this.getContainer().getActor().getTile();
		if (tile != null) this.spawnIcon("status_effect_65", this.getContainer().getActor().getTile());
	}

	function onAdded()
	{
		// local statusResisted = actor.getCurrentProperties().IsResistantToAnyStatuses ? this.Math.rand(1, 100) <= 50 : false;
		// statusResisted = statusResisted || actor.getCurrentProperties().IsResistantToPhysicalStatuses ? this.Math.rand(1, 100) <= 33 : false;

		// if (statusResisted)
		// {
		// 	if (!actor.isHiddenToPlayer())
		// 	{
		// 		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " shook off being staggered thanks to his unnatural physiology");
		// 	}

		// 	this.removeSelf();
		// }
		// else
		// {
		// 	this.m.TurnsLeft = this.Math.max(1, 2 + actor.getCurrentProperties().NegativeStatusEffectDuration);
		// 	this.Tactical.TurnSequenceBar.pushEntityBack(actor.getID());
		// }

		//TODO: stagge resistance from perks
		// gt.Const.Perks.PerkDefs.DeathDealer
		// stances

		local actor = this.getContainer().getActor();
		this.m.TurnsLeft = this.Math.max(1, 2 + actor.getCurrentProperties().NegativeStatusEffectDuration);
		this.Tactical.TurnSequenceBar.pushEntityBack(actor.getID());

		if (this.m.TurnsLeft == 0) 
		{
			this.removeSelf();
			return;
		}

		local s = actor.getSkills();
		s.removeByID("effects.shieldwall");
		s.removeByID("effects.spearwall");
		s.removeByID("effects.riposte");
		s.removeByID("effects.return_favor");
	}

});

