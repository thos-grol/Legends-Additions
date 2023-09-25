::Const.Strings.PerkName.StanceExecutioner <- "Executioner";
::Const.Strings.PerkDescription.StanceExecutioner <- ::MSU.Text.color(::Z.Log.Color.Purple, "Stance")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("+50%") + " Headshot chance"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "With axe equipped:")
+ "\n "+::MSU.Text.colorRed("Cull") + " now triggers at "+::MSU.Text.colorRed("44%");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceExecutioner].Name = ::Const.Strings.PerkName.StanceExecutioner;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceExecutioner].Tooltip = ::Const.Strings.PerkDescription.StanceExecutioner;

this.perk_stance_executioner <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.stance.executioner";
		this.m.Name = ::Const.Strings.PerkName.StanceExecutioner;
		this.m.Description = ::Const.Strings.PerkDescription.StanceExecutioner;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate(_properties)
	{
		_properties.HitChance[::Const.BodyPart.Head] += 50;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Stance", true);
	}

});

