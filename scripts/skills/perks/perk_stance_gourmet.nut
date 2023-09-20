//TODO: improve description
::Const.Strings.PerkName.StanceGourmet <- "Gourmet";
::Const.Strings.PerkDescription.StanceGourmet <- ::MSU.Text.color(::Z.Log.Color.Purple, "Stance")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.BloodRed, "Improves Weakness: (Duration: 2)")
+ "\n " + ::MSU.Text.color(::Z.Log.Color.BloodRed, "-10X% damage. X is the number of bleed stacks. Caps at 75%");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceGourmet].Name = ::Const.Strings.PerkName.StanceGourmet;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceGourmet].Tooltip = ::Const.Strings.PerkDescription.StanceGourmet;

this.perk_stance_gourmet <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.stance.gourmet";
		this.m.Name = this.Const.Strings.PerkName.StanceGourmet;
		this.m.Description = this.Const.Strings.PerkDescription.StanceGourmet;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Stance", true);
	}
});