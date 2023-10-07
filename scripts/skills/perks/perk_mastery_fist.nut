//TODO: Stance: Asura - Unleash a flurry of blows upon the opponent.
//With no items equipped in either hand.
//Hand to hand unleashes a flurry of 4 (unarmed attacks)
	//+3 CQC strikes
	//Kick:
	//+1 Kick

::Const.Strings.PerkName.LegendSpecFists = "Unarmed Proficiency";
::Const.Strings.PerkDescription.LegendSpecFists = ::MSU.Text.color(::Z.Log.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue (Unarmed)"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Unarmed strikes:")
+ "\n"+::MSU.Text.colorGreen("+X%") + " unarmed damage"
+ "\n"+::MSU.Text.colorGreen("+X%") + " unarmed stagger chance"
+ "\n"+::MSU.Text.colorRed("X = 2*sqrt(total armor weight)")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.BloodRed, "Stagger: (Removed on turn start)")
+ "\n "+::MSU.Text.colorRed("– 50%")+" Initiative"
+ "\n "+::MSU.Text.colorRed("– 25")+" Melee Defense"
+ "\n "+::MSU.Text.colorRed("– 25")+" Ranged Defense"
+ "\n +Cancels Shieldwall, Spearwall, Return Favor, and Riposte";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecFists].Name = ::Const.Strings.PerkName.LegendSpecFists;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecFists].Tooltip = ::Const.Strings.PerkDescription.LegendSpecFists;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecFists].Icon = "ui/perks/ambidexterity_circle.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecFists].IconDisabled = "ui/perks/ambidexterity_circle_bw.png";

this.perk_mastery_fist <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery_fist";
		this.m.Name = ::Const.Strings.PerkName.LegendSpecFists;
		this.m.Description = ::Const.Strings.PerkDescription.LegendSpecFists;
		this.m.Icon = "ui/perks/unarmed_mastery_circle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInFists = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Fist"))
			this.m.Container.add(this.new("scripts/skills/traits/_proficiency_Fist"));
	}

});

