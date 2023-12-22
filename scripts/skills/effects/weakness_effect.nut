this.weakness_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		TurnsLeftMax = 1,
		Effect = 5,
		Cap = 50
	},
	function create()
	{
		this.m.ID = "effects.weakness";
		this.m.Name = "Weakness";
		this.m.Icon = "ui/traits/trait_icon_59.png";
		this.m.IconMini = "weakness_mini";
		this.m.Overlay = "weakness";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getName()
	{
		return this.m.Name + " (-" + getBonus() + "% Damage)";
	}

	function getDescription()
	{
		return "This character has been weakened";
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
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-" + getBonus() + "%[/color] Damage"
			}
		];
	}

	function getBonus()
	{
		local count = 0;
		foreach( s in this.getContainer().getActor().getSkills().getAllSkillsOfType(::Const.SkillType.DamageOverTime) )
		{
			if (s.m.ID == "effects.bleeding") count += 1;
		}
		local actor = this.getContainer().getActor();
		local cap = this.m.Container.hasSkill("perk.stance.gourmet") ? 75 : this.m.Cap;
		local effect = this.m.Container.hasSkill("perk.stance.gourmet") ? 10 : this.m.Effect;
		return ::Math.min(count * effect, cap);
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult -= 1.0 + getBonus() * 0.01;
	}

	function onAdded()
	{

		local actor = this.getContainer().getActor();

		this.m.TurnsLeft = ::Math.max(1, this.m.TurnsLeft + actor.getCurrentProperties().NegativeStatusEffectDuration);
		if (actor.getFlags().has("WeaknessImmune") || this.m.TurnsLeft == 0)
		{
			if (!actor.isHiddenToPlayer())
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " resisted being weakened");
			this.removeSelf();
			return;
		}
	}

	function resetTime()
	{
		if (this.m.TurnsLeft != this.m.TurnsLeftMax)
		{
			this.m.TurnsLeft = this.m.TurnsLeftMax;
			if (this.getContainer().getActor().isPlacedOnMap())
				this.spawnIcon("weakness", this.getContainer().getActor().getTile());
		}
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0) this.removeSelf();
	}

});

