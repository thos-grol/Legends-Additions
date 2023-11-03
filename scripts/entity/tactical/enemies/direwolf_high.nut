::Const.Tactical.Actor.FrenziedDirewolf <- {
	XP = 250,
	ActionPoints = 12,
	Hitpoints = 200,
	Bravery = 70,
	Stamina = 180,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		30,
		30
	]
};

this.direwolf_high <- this.inherit("scripts/entity/tactical/enemies/direwolf", {
	m = {
		HasTurned = false,
		HasBeenWhipped = true
	},
	function setWhipped( _w )
	{
		this.m.HasBeenWhipped = _w;
	}

	function getName()
	{
		return "Frenzied Wolf";
	}

	function create()
	{
		this.direwolf.create();
	}

	function onInit()
	{
		this.direwolf.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FrenziedDirewolf);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.DamageTotalMult = 1.25;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local head_frenzy = this.getSprite("head_frenzy");
		head_frenzy.setBrush(this.getSprite("head").getBrush().Name + "_frenzy");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
	}

	function onTurnStart()
	{
		this.actor.onTurnStart();

		if (this.Time.getRound() >= 2 && !this.m.HasTurned && !this.m.HasBeenWhipped && !this.Tactical.State.isAutoRetreat())
		{
			this.m.Skills.getSkillByID("racial.werewolf").spawnIcon("status_effect_107", this.getTile());

			local s = [
				"sounds/enemies/wolf_bite_01.wav",
				"sounds/enemies/wolf_bite_02.wav",
				"sounds/enemies/wolf_bite_03.wav",
				"sounds/enemies/wolf_bite_04.wav"
			];
			this.Sound.play(::MSU.Array.rand(s), 100.0, this.getPos());

			if (this.Math.rand(1, 100) <= 33)
			{
				this.updateAchievement("FriendOrFoe", 1, 1);
				this.m.HasTurned = true;
				this.setFaction(this.Tactical.State.isScenarioMode() ? this.Const.Faction.Beasts : this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
				this.getSprite("socket").setBrush("bust_base_beasts");
			}
		}

		this.m.HasBeenWhipped = false;
	}

});

