::Const.Strings.PerkName.LegendSpecFists = "Unarmed Proficiency";
::Const.Strings.PerkDescription.LegendSpecFists = ::MSU.Text.color(::Z.Log.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue (Unarmed)"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Unarmed strikes:[/u]")
+ "\n Headshots will "+::MSU.Text.colorRed("Cull")+", executing targets with less than "+::MSU.Text.colorRed("33%")+" Hitpoints after recieving the hit"

//TODO: Unarmed proficiency
//TODO: increase damage of fists the heavier body armor is, chance to stagger 5% - 10%
//increases chance to stagger for Kick to 60%

//TODO: Grapple active
	// Latch onto your opponent for 2 turns if hit. Reducing both your and the opponents mdef by x%.
	// Has a chance to disarm the opponent
	// Needs at least 1 hand free.
	// Has a chance of disarming.

//TODO: Stance: Ghost - Those hands are like the claws of a ghost
//Improve the hit chance of grapple, double the debuff off grapple for both this unit and the target
//Increases the disarm chance
//Attacks that hit you while you are grappled have a 75% chance of being transferred to the enemy
//This chance drops for each subsequent hit in the turn
//Invalid for the attacks of the grappled enemy

//TODO: Stance: Asura - Unleash a flurry of blows upon the opponent. With no items equipped in either hand. Hand to hand (unarmed), unleashes a flurry of 4 (unarmed attacks). Blunt free perks apply to fists, just a reminder.

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Skill: Split Shield[/u]")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue"
+ "\n " + ::MSU.Text.colorGreen("+50%") + " shield damage";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecFists].Name = ::Const.Strings.PerkName.LegendSpecFists;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecFists].Tooltip = ::Const.Strings.PerkDescription.LegendSpecFists;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecFists].Icon = "ui/perks/ambidexterity_circle.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecFists].IconDisabled = "ui/perks/ambidexterity_circle_bw.png";

this.perk_mastery_fist <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery_fist";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecFists;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecFists;
		this.m.Icon = "ui/perks/unarmed_mastery_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInFists = true;
	}

});

