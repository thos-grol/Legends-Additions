::Const.Strings.PerkName.MeditationPactOfFlesh <- "Pact of Flesh";
::Const.Strings.PerkDescription.MeditationPactOfFlesh <- ::MSU.Text.color(::Z.Color.Purple, "Meditation")
+ "\nYou saw a world full of perfect red lines, unquestionable beauty..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("+X") + " to all stats"
+ "\n"+::MSU.Text.colorRed("X is 20% of this unit's flesh servant's base stats")
+ "\n"+::MSU.Text.colorGreen("100%") + " of damage dealt to this unit is transferred to this unit's flesh servant";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.MeditationPactOfFlesh].Name = ::Const.Strings.PerkName.MeditationPactOfFlesh;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.MeditationPactOfFlesh].Tooltip = ::Const.Strings.PerkDescription.MeditationPactOfFlesh;

this.perk_meditation_pact_of_flesh <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.meditation.pact_of_flesh";
		this.m.Name = ::Const.Strings.PerkName.MeditationPactOfFlesh;
		this.m.Description = ::Const.Strings.PerkDescription.MeditationPactOfFlesh;
		this.m.Icon = "ui/perks/perk_04.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.NoRefund <- true;
	}

	function onAdded()
	{
		this.World.Statistics.getFlags().set("potion_winter", true);
	}

	function onUpdate( _properties )
	{
		local flesh_servant = this.getContainer().getActor().getSkills().getSkillByID("actives.spell.flesh_servant_bind");
		if (flesh_servant == null) return;
		if (flesh_servant.m.Type_ == null) return;
		if (flesh_servant.m.Skills.len() == 0) return;

		_properties.Bravery += ::Math.round( flesh_servant.m.BaseProperties["Bravery"] * 0.2);
		_properties.Initiative += ::Math.round( flesh_servant.m.BaseProperties["Initiative"] * 0.2);
		_properties.MeleeDefense += ::Math.round( flesh_servant.m.BaseProperties["MeleeSkill"] * 0.2);
		_properties.RangedSkill += ::Math.round( flesh_servant.m.BaseProperties["RangedSkill"] * 0.2);
		_properties.MeleeSkill += ::Math.round( flesh_servant.m.BaseProperties["MeleeDefense"] * 0.2);
		_properties.RangedDefense += ::Math.round( flesh_servant.m.BaseProperties["RangedDefense"] * 0.2);

	}


});

