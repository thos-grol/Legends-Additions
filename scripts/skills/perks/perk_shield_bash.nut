::Const.Strings.PerkName.ShieldBash = "Tank";
::Const.Strings.PerkDescription.ShieldBash = "Learn how to fight with a shield and protect your teamates..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "\'Taunt\' (4 AP, 15 Fat):")
+ "\nTaunt an enemy to make them much more likely to attack this unit"
+"\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("– 10%") + " damage taken while using a shield"
+ "\n " + ::MSU.Text.colorGreen("– 50%") + " shield damage recieved to a minimum of 1"
+ "\n " + ::MSU.Text.colorGreen("+25%") + " chance to hit for Knockback"

+"\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Modifies Knock Back:")
+ "\n " + ::MSU.Text.colorGreen("+10-25") + " damage"
+ "\n " + ::MSU.Text.colorGreen("+10") + " fatigue damage";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ShieldBash].Name = ::Const.Strings.PerkName.ShieldBash;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ShieldBash].Tooltip = ::Const.Strings.PerkDescription.ShieldBash;

this.perk_shield_bash <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.shield_bash";
		this.m.Name = this.Const.Strings.PerkName.ShieldBash;
		this.m.Description = this.Const.Strings.PerkDescription.ShieldBash;
		this.m.Icon = "ui/perks/perk_22.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.taunt"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/taunt"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.taunt");
	}

});

