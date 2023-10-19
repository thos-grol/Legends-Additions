::Const.Strings.PerkName.Inspire <- "Command";
::Const.Strings.PerkDescription.Inspire <- "Command a soldier to strike..."

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "\'Command\' (7 AP, 30 Fat):")
+ "\nTarget unit gains " + ::MSU.Text.colorGreen("4 AP")
+ "\n\n" + ::MSU.Text.colorRed("There can only be one commander in the party. Will refund this perk if any other unit has it.");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Inspire].Name = ::Const.Strings.PerkName.Inspire;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Inspire].Tooltip = ::Const.Strings.PerkDescription.Inspire;

this.perk_inspire <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.inspire";
		this.m.Name = ::Const.Strings.PerkName.Inspire;
		this.m.Description = ::Const.Strings.PerkDescription.Inspire;
		this.m.Icon = "ui/perks/inspire_circle.png";
		this.m.IconDisabled = "ui/perks/inspire_circle_bw.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.inspire")) 
			this.m.Container.add(::new("scripts/skills/actives/inspire_skill"));

		local actor = this.getContainer().getActor();
		local playerRoster = this.World.getPlayerRoster().getAll();
		foreach( bro in playerRoster )
		{
			if (bro.getID() == actor.getID()) continue;
			if (bro.getSkills().hasSkill("perk.inspire"))
			{
				bro.m.Skills.removeByID("perk.inspire");
				bro.m.PerkPoints += 1;
				bro.m.PerkPointsSpent -= 1;
				break;
			}
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.inspire");
	}

});

