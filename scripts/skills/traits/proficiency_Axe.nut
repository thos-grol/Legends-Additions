this.proficiency_Axe <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		str = "Axe",
		// BaseChance = 5,
		// ProficiencyMax = 100,

		BaseChance = 100,
		ProficiencyMax = 1,
		FlagBonus = "ProficiencyBonusAxe",
		FlagStore = "ProficiencyAxe",
		Proficiency = ::Const.Perks.PerkDefs.SpecAxe,
		Mastery = ::Const.Perks.PerkDefs.SpecAxeC
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.proficiency_Axe";
		this.m.Name = "";
		this.m.Icon = "ui/traits/trait_icon_21.png";
		this.m.Description = "";
		this.m.Titles = [];
		this.m.Excluded = [];
		this.m.IsHidden = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();
		local chance = this.m.BaseChance + (actor.getFlags().has(this.m.FlagBonus) ? 5 : 0);
		if (actor.getFlags().has(this.m.FlagStore) && actor.getFlags().getAsInt(this.m.FlagStore) == this.m.ProficiencyMax) return;

		if (::Math.rand(1,100) <= chance)
		{
			if (!actor.getFlags().has(this.m.FlagStore)) 
				actor.getFlags().set(this.m.FlagStore, 0);

			actor.getFlags().set(this.m.FlagStore, 
				::Math.min(this.m.ProficiencyMax, actor.getFlags().getAsInt(this.m.FlagStore) + 1));

			::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(actor) + ::MSU.Text.color(::Z.Log.Color.BloodRed, " has  gained 1 " + this.m.Type + " proficiency"));
		}

		if (actor.getFlags().getAsInt(this.m.FlagStore) == this.m.ProficiencyMax) 
			reward();
	}

	function getDetails( _tooltip )
	{
		local actor = this.getContainer().getActor();
		local amount = 0;

		if (actor.getFlags().has(this.m.FlagStore)) 
			amount = actor.getFlags().getAsInt(this.m.FlagStore);

		_tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = this.m.str + " Proficiency: " + ::MSU.Text.color(::Z.Log.Color.BloodRed, amount + " / " + this.m.ProficiencyMax)
		});
		return _tooltip;
	}

	function reward()
	{
		local actor = this.getContainer().getActor();
		::Z.Perks.remove(actor, this.m.Proficiency);
		::Z.Perks.add(actor, this.m.Mastery, 3);
	}

	

});
