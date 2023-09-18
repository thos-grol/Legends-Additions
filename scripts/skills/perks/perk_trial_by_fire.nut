::Const.Strings.PerkName.TrialByFire <- "Trial By Fire";
::Const.Strings.PerkDescription.TrialByFire <- "Soldiers are forged by battle..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Upon Victory, for units below LV5:[/u]")
+ "\n" + ::MSU.Text.colorGreen("+1") + " Level"
+ "\n" + ::MSU.Text.colorRed("The effect is cancelled if the commander dies")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]\'Rally the Troops\'[/u] (5 AP, 25 Fat):")
+ "\nRally fleeing allies, and raise morale of all nearby allies to a steady level"
+ "\n"+::MSU.Text.colorRed("Higher resolve increases the chance to succeed")

+ "\n\n" + ::MSU.Text.colorRed("There can only be one commander in the party. Will refund this perk if any other unit has it.");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.TrialByFire].Name = ::Const.Strings.PerkName.TrialByFire;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.TrialByFire].Tooltip = ::Const.Strings.PerkDescription.TrialByFire;

this.perk_trial_by_fire <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.trial_by_fire";
		this.m.Name = this.Const.Strings.PerkName.TrialByFire;
		this.m.Description = this.Const.Strings.PerkDescription.TrialByFire;
		this.m.Icon = "ui/perks/liberty_perk.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		local playerRoster = this.World.getPlayerRoster().getAll();
		foreach( bro in playerRoster )
		{
			if (bro.getID() == actor.getID()) continue;
			if (bro.getSkills().hasSkill("perk.trial_by_fire"))
			{
				bro.m.Skills.removeByID("perk.trial_by_fire");
				bro.m.PerkPoints += 1;
				bro.m.PerkPointsSpent -= 1;
				break;
			}
		}

		if (!this.m.Container.hasSkill("actives.rally_the_troops")) this.m.Container.add(this.new("scripts/skills/actives/rally_the_troops"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.rally_the_troops");
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.33;
	}



});

