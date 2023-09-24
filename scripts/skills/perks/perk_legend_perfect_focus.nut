::Const.Strings.PerkName.PerfectFocus = "Perfect Focus";
::Const.Strings.PerkDescription.PerfectFocus = ::MSU.Text.color(::Z.Log.Color.Purple, "Destiny")
+ "\n" + "Eternity within a moment..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("+10") + " Battle Flow stacks on combat start"
+ "\nThis character's attack rolls are (1, 95) instead of (1, 100)"
+ "\nThis character's defense rolls are (6, 100) instead of (1, 100)";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.PerfectFocus].Name = ::Const.Strings.PerkName.PerfectFocus;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.PerfectFocus].Tooltip = ::Const.Strings.PerkDescription.PerfectFocus;
this.perk_legend_perfect_focus <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_perfect_focus";
		this.m.Name = ::Const.Strings.PerkName.PerfectFocus;
		this.m.Description = ::Const.Strings.PerkDescription.PerfectFocus;
		this.m.Icon = "ui/perks/perfectfocus_circle.png";
		this.m.IconDisabled = "ui/perks/perfectfocus_circle_bw.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Destiny", true);
	}

	function onRemoved()
	{
	}

});

