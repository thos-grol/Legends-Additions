::Const.Strings.PerkName.InspiringPresence = "Teamwork Exercises";
::Const.Strings.PerkDescription.InspiringPresence = "Work as a team, fight as a team..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n" + ::MSU.Text.colorGreen("-75%") + " chance of friendly fire between units in the company. " + ::MSU.Text.colorRed("Is cancelled if this unit dies")
+ "\n• \'Hold the Line\' (9 AP, 25 Fat, 2 Charges): Allied units within 4 tiles: "
+ "\n"+::MSU.Text.colorGreen("+25%" + " damage reduction")
+ "\n"+::MSU.Text.colorGreen("+ Displacement Immunity")
+ "\n"+::MSU.Text.colorGreen("Use Shieldwall") + " if possible";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.InspiringPresence].Name = ::Const.Strings.PerkName.InspiringPresence;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.InspiringPresence].Tooltip = ::Const.Strings.PerkDescription.InspiringPresence;

//LegendHoldTheLine = "\'DON\'T LET THEM BREAK THROUGH!\'\n\nDirect your troops to stand their ground, granting [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense, reducing damage taken by [color=" + this.Const.UI.Color.NegativeValue + "]10%[/color] and granting immunity to being knocked back and grabbed to all allies within [color=" + this.Const.UI.Color.PositiveValue + "]4[/color] tiles for one turn.",

this.perk_inspiring_presence <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.inspiring_presence";
		this.m.Name = this.Const.Strings.PerkName.InspiringPresence;
		this.m.Description = this.Const.Strings.PerkDescription.InspiringPresence;
		this.m.Icon = "ui/perks/perk_28.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_hold_the_line"))
			this.m.Container.add(this.new("scripts/skills/actives/legend_hold_the_line"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_hold_the_line");
	}

	function onCombatStarted()
	{
		this.skill.onCombatStarted();
		local actor = this.getContainer().getActor();
		// local resolve = actor.getCurrentProperties().getBravery();

		foreach( ally in this.Tactical.Entities.getInstancesOfFaction(actor.getFaction()) )
		{
			if (!ally.getSkills().hasSkill("effects.teamwork"))
				ally.getSkills().add(::new("scripts/skills/effects/teamwork_effect"));
		}
	}

	function onDeath( _fatalityType )
	{
		local actor = this.getContainer().getActor();

		foreach( ally in this.Tactical.Entities.getInstancesOfFaction(actor.getFaction()) )
		{
			if (ally.getSkills().hasSkill("effects.teamwork"))
				ally.getSkills().removeByID("effects.teamwork");
		}

	}

});

