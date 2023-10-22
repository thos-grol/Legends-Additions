::Const.Strings.PerkName.StanceDavid <- "David";
::Const.Strings.PerkDescription.StanceDavid <- ::MSU.Text.color(::Z.Log.Color.Purple, "Stance")

+ "\n " + ::MSU.Text.colorGreen("+33%") + " bonus multiplier for slings"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Sling Headshots:")
+ "\n Will stun if possible";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceDavid].Name = ::Const.Strings.PerkName.StanceDavid;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceDavid].Tooltip = ::Const.Strings.PerkDescription.StanceDavid;

this.perk_stance_david <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.stance.david";
		this.m.Name = ::Const.Strings.PerkName.StanceDavid;
		this.m.Description = ::Const.Strings.PerkDescription.StanceDavid;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
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