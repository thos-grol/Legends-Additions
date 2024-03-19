::Const.Strings.PerkDescription.Dodge = "Too fast..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("+X") + " Defense."
+ "\n"+::MSU.Text.colorRed("X is 15% of current Agility. Invalid if a shield is equipped - exceptions (buckler and goblin shields)");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Dodge].Tooltip = ::Const.Strings.PerkDescription.Dodge;

this.perk_dodge <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.dodge";
		this.m.Name = ::Const.Strings.PerkName.Dodge;
		this.m.Description = ::Const.Strings.PerkDescription.Dodge;
		this.m.Icon = "ui/perks/perk_01.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/effects/dodge_effect"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("effects.dodge");
	}

});

