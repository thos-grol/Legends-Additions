::Const.Strings.PerkName.LegendMindOverBody = "Fighting Spirit";
::Const.Strings.PerkDescription.LegendMindOverBody = ::MSU.Text.color(::Z.Color.Purple, "Destiny")
+ "\n" + "A power that is equal, that anyone can achieve regardless of their circumstances..."

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Will > 100:")

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("– X%") + " damage taken"
+ "\n" + ::MSU.Text.colorRed("X = (WILL - 100)")

+ "\n\n" + ::MSU.Text.colorGreen("+X") + " damage dealt"
+ "\n" + ::MSU.Text.colorRed("X = (WILL - 100)")

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "On Turn Start:")
+ "\n Morale Check enemies in Zone of Control with -X difficulty"
+ "\n" + ::MSU.Text.colorRed("X = floor( (WILL - 100) / 2). 0 Difficulty means that the enemy needs 80 Will to completely ignore the moral check");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMindOverBody].Name = ::Const.Strings.PerkName.LegendMindOverBody;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMindOverBody].Tooltip = ::Const.Strings.PerkDescription.LegendMindOverBody;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMindOverBody].Icon = "ui/perks/transcendant_will.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMindOverBody].IconDisabled = "ui/perks/transcendant_will_bw.png";

this.perk_legend_mind_over_body <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_mind_over_body";
		this.m.Name = ::Const.Strings.PerkName.LegendMindOverBody;
		this.m.Description = ::Const.Strings.PerkDescription.LegendMindOverBody;
		this.m.Icon = "ui/perks/mind_over_body.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Destiny", true);
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local will = actor.getCurrentProperties().getBravery();
		local bonus = will - 100;
		_properties.DamageRegularMin += bonus;
		_properties.DamageRegularMax += bonus;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local will = actor.getCurrentProperties().getBravery();

		if (will < 100) return;
		this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + "'s Fighting Spirit flares.");

		local tag = {
			User = actor,
			Difficulty = -1 * ::Math.floor( (will - 100) / 2.0);
			//-40 difficulty means you need about 130 resolve to ignore the check
			//-30, 120
			//0, 80
			//-20, 60
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 1000, this.onDelayedEffect, tag);
	}

	function onDelayedEffect( _tag )
	{
		local mytile = _tag.User.getTile();
		local actors = this.Tactical.Entities.getAllInstances();
		local range = 1;
		local difficulty = _tag.Difficulty;

		// if (_tag.User.getFaction() == ::Const.Faction.Player) range = 2;
		// if (_tag.User.getFaction() == ::Const.Faction.Player) difficulty = -30;

		foreach( i in actors )
		{
			foreach( a in i )
			{
				if (!a.isAlliedWith(_tag.User) && a.getID() != _tag.User.getID() && a.getTile().getDistanceTo(mytile) <= range) a.checkMorale(-1, difficulty, ::Const.MoraleCheckType.MentalAttack);
			}
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker == null || _attacker.getID() == this.getContainer().getActor().getID() || _skill == null) return;

		local actor = this.getContainer().getActor();
		local will = actor.getCurrentProperties().getBravery();
		_properties.DamageReceivedRegularMult *= 1.0 - (will - 100) * 0.01;
	}



});

