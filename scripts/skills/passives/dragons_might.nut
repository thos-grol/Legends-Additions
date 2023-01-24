this.dragons_might <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.dragons_might";
		this.m.Name = "Dragon\'s Might";
		this.m.Description = "Dragons are surrounded by an aura of might that intimidates and supresses lesser beings. Range: 1.";
		this.m.Icon = "ui/perks/favoured_lindwurm_01.png";
		this.m.IsRemovedAfterBattle = false;
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
				id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Attacks do " + ::MSU.Text.colorGreen( "25" ) + "% more damage"
			}
		];
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + "'s Dragon's Might flares.");

		local tag = {
			User = actor
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 1000, this.onDelayedEffect, tag);
	}

	function onDelayedEffect( _tag )
	{
		local mytile = _tag.User.getTile();
		local actors = this.Tactical.Entities.getAllInstances();
		local range = 10;
		local difficulty = -40;
		if (_tag.User.getFaction() == ::Const.Faction.Player) range = 2;
		if (_tag.User.getFaction() == ::Const.Faction.Player) difficulty = -30;

		foreach( i in actors )
		{
			foreach( a in i )
			{
				//-40 difficulty means you need about 130 resolve to ignore the check
				if (!a.isAlliedWith(_tag.User) && a.getID() != _tag.User.getID() && a.getTile().getDistanceTo(mytile) <= range) a.checkMorale(-1, -40, ::Const.MoraleCheckType.MentalAttack);
			}
		}
	}

	o.onUpdate = function(_properties)
	{
		if (this.getContainer().getActor().getFaction() == ::Const.Faction.Player) _properties.DamageTotalMult *= 1.25;
	}

});