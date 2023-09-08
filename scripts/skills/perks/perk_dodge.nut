::Const.Strings.PerkDescription.Dodge = "Too fast..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n• " + ::MSU.Text.colorGreen("+15% of current Initiative") + " as Melee and Ranged Defense.";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Dodge].Tooltip = ::Const.Strings.PerkDescription.Dodge;

this.perk_dodge <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.dodge";
		this.m.Name = this.Const.Strings.PerkName.Dodge;
		this.m.Description = this.Const.Strings.PerkDescription.Dodge;
		this.m.Icon = "ui/perks/perk_01.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		this.getContainer().add(this.new("scripts/skills/effects/dodge_effect"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("effects.dodge");
	}

});

