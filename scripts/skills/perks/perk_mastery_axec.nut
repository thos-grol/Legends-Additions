::Const.Strings.PerkName.SpecAxeC <- "Axe Mastery";
::Const.Strings.PerkDescription.SpecAxeC <- ::MSU.Text.color(::Z.Log.Color.Purple, "Mastery")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue (Axes)"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]With axe equipped:[/u]")
+ "\n Headshots will "+::MSU.Text.colorRed("Cull")+", executing targets with less than "+::MSU.Text.colorRed("33%")+" Hitpoints after recieving the hit" 

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Skill: Split Shield[/u]")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue"
+ "\n " + ::MSU.Text.colorGreen("+50%") + " shield damage";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecAxeC].Name = ::Const.Strings.PerkName.SpecAxeC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecAxeC].Tooltip = ::Const.Strings.PerkDescription.SpecAxeC;

this.perk_mastery_axec <- this.inherit("scripts/skills/perks/perk_mastery_axe", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.axec";
		this.m.Name = this.Const.Strings.PerkName.SpecAxeC;
		this.m.Description = this.Const.Strings.PerkDescription.SpecAxeC;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

});

