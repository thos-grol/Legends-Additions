this._proficiency <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		str = "Axe",
		BaseChance = 10,
		ProficiencyMax = 50
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
		if (!validate()) return;
		add_proficiency();
	}

	function getDetails( _tooltip )
	{
		local actor = this.getContainer().getActor();
		local amount = 0;

		if (actor.getFlags().has(getFlagStore()))
			amount = actor.getFlags().getAsInt(getFlagStore());

		_tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = this.m.str + " Proficiency: " + ::MSU.Text.color(::Z.Color.BloodRed, amount + " / " + this.m.ProficiencyMax)
		});
		return _tooltip;
	}

	function add_proficiency()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has(getFlagStore()) && actor.getFlags().getAsInt(getFlagStore()) == this.m.ProficiencyMax) return;

		local chance = this.m.BaseChance + (actor.getFlags().has(getFlagBonus()) ? 10 : 0);
		if (this.m.Container.hasSkill("trait.natural")) chance += 20;

		if (::Math.rand(1,100) <= chance)
		{
			if (!actor.getFlags().has(getFlagStore()))
				actor.getFlags().set(getFlagStore(), 0);

			actor.getFlags().set(getFlagStore(),
				::Math.min(this.m.ProficiencyMax, actor.getFlags().getAsInt(getFlagStore()) + 1));

			::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(actor) + ::MSU.Text.color(::Z.Color.BloodRed, " has gained 1 " + this.m.str + " proficiency"));
		}

		if (actor.getFlags().getAsInt(getFlagStore()) == this.m.ProficiencyMax)
			reward();
	}

	function add_proficiency_amount(_amount)
	{
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has(getFlagStore()) && actor.getFlags().getAsInt(getFlagStore()) == this.m.ProficiencyMax) return;

		if (!actor.getFlags().has(getFlagStore()))
				actor.getFlags().set(getFlagStore(), 0);

		actor.getFlags().set(getFlagStore(),
			::Math.min(this.m.ProficiencyMax, actor.getFlags().getAsInt(getFlagStore()) + _amount));

		if (actor.getFlags().getAsInt(getFlagStore()) == this.m.ProficiencyMax)
			reward();
	}

	function reward()
	{
		local actor = this.getContainer().getActor();
		::Z.Perks.remove(actor, getProficiency());
		::Z.Perks.add(actor, getMastery(), 3);
	}

	function validate()
	{
		return true;
	}

	function getFlagBonus()
	{
		return "ProficiencyBonus" + this.m.str;
	}

	function getFlagStore()
	{
		return "Proficiency" + this.m.str;
	}

	function getProficiency()
	{
		return ::Z.Perks.ProficiencyToMastery[this.m.str].Proficiency;
	}

	function getMastery()
	{
		return ::Z.Perks.ProficiencyToMastery[this.m.str].Mastery;
	}

	function setWeapon(_str)
	{
		this.m.str = _str;
	}
});

