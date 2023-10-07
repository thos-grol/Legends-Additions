::Const.Strings.PerkName.Dismantle <- "Dismantle";
::Const.Strings.PerkDescription.Dismantle <- "Dismantle that tin can"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Blunt attacks inflict:")
+ "\n"+::MSU.Text.colorGreen("+5%") + " armor piercing (10% for 2H)"
+ "\n"+::MSU.Text.colorRed("Effect applies to future attacks, and lasts until the end of battle. Caps at 30%");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Dismantle].Name = ::Const.Strings.PerkName.Dismantle;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Dismantle].Tooltip = ::Const.Strings.PerkDescription.Dismantle;

this.perk_dismantle <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.dismantle";
		this.m.Name = this.Const.Strings.PerkName.Dismantle;
		this.m.Description = this.Const.Strings.PerkDescription.Dismantle;
		this.m.Icon = "ui/perks/dismantle.png"; //TODO: image
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


});
