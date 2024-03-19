::Const.Strings.PerkName.LeadByExample <- "Lead By Example";
::Const.Strings.PerkDescription.LeadByExample <- "Inspire those around you..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "For commanded units:")
+ "\n"+::MSU.Text.colorGreen("+5% of this unit\'s ") + "Attack"
+ "\n"+::MSU.Text.colorGreen("+10% of this unit\'s ") + "Defense"
+ "\n"+::MSU.Text.colorGreen("+10% of this unit\'s ") + "Will"
+ "\n" + ::MSU.Text.colorRed("The effect is cancelled if the commander dies")
+ "\n\n" + ::MSU.Text.colorRed("There can only be one commander in the party. Will refund this perk if any other unit has it.");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LeadByExample].Name = ::Const.Strings.PerkName.LeadByExample;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LeadByExample].Tooltip = ::Const.Strings.PerkDescription.LeadByExample;

this.perk_lead_by_example <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.lead_by_example";
		this.m.Name = ::Const.Strings.PerkName.LeadByExample;
		this.m.Description = ::Const.Strings.PerkDescription.LeadByExample;
		this.m.Icon = "ui/perks/inspiring_presence.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		local playerRoster = this.World.getPlayerRoster().getAll();
		foreach( bro in playerRoster )
		{
			if (bro.getID() == actor.getID()) continue;
			if (bro.getSkills().hasSkill("perk.lead_by_example"))
			{
				bro.m.Skills.removeByID("perk.lead_by_example");
				bro.m.PerkPoints += 1;
				bro.m.PerkPointsSpent -= 1;
				break;
			}
		}
	}

	function trigger()
	{
		local actor = this.getContainer().getActor();
		foreach( ally in this.Tactical.Entities.getInstancesOfFaction(actor.getFaction()) )
		{
			if (ally.getID() == actor.getID()) continue;
			if (ally.getSkills().getSkillByID("effects.lead_by_example") != null) break;

			local effect = ::new("scripts/skills/effects/lead_by_example_effect");
			effect.m.MeleeSkill = ::Math.round(actor.getCurrentProperties().getMeleeSkill()  * 0.05);
			effect.m.MeleeDefense = ::Math.round(actor.getCurrentProperties().getMeleeDefense()  * 0.1);
			effect.m.Bravery = ::Math.round(actor.getCurrentProperties().getBravery()  * 0.1);
			ally.getSkills().add(effect);
		}
	}

	function onCombatStarted()
	{
		this.skill.onCombatStarted();
		trigger();
	}

	function onDeath( _fatalityType )
	{
		local actor = this.getContainer().getActor();

		foreach( ally in this.Tactical.Entities.getInstancesOfFaction(actor.getFaction()) )
		{
			if (ally.getSkills().hasSkill("effects.lead_by_example"))
				ally.getSkills().removeByID("effects.lead_by_example");
		}

		local has_replacement = false;
		foreach( ally in this.Tactical.Entities.getInstancesOfFaction(actor.getFaction()) )
		{
			if (ally.getID() == actor.getID()) continue;
			local skill = ally.getSkills().getSkillByID("perk.lead_by_example");
			if (skill != null)
			{
				skill.trigger();
				return;
			}
		}

	}

});

