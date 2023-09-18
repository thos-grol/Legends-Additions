::Const.Strings.PerkName.PerfectFocus = "Perfect Focus";
::Const.Strings.PerkDescription.PerfectFocus = ::MSU.Text.color(::Z.Log.Color.Purple, "Destiny")
+ "\n" + "Eternity within a moment..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]\'Perfect Focus\'[/u] (0 AP, 0 Fat):")
+ "\n" + ::MSU.Text.colorGreen("– 50%") + " AP costs for skills, " + ::MSU.Text.colorRed("but +75% Fatigue cost");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.PerfectFocus].Name = ::Const.Strings.PerkName.PerfectFocus;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.PerfectFocus].Tooltip = ::Const.Strings.PerkDescription.PerfectFocus;
this.perk_legend_perfect_focus <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_perfect_focus";
		this.m.Name = this.Const.Strings.PerkName.PerfectFocus;
		this.m.Description = this.Const.Strings.PerkDescription.PerfectFocus;
		this.m.Icon = "ui/perks/perfectfocus_circle.png";
		this.m.IconDisabled = "ui/perks/perfectfocus_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.perfect_focus")) this.m.Container.add(this.new("scripts/skills/actives/perfect_focus"));

		local actor = this.getContainer().getActor();
		actor.getFlags().set("Destiny", "perk.vengeance");
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.perfect_focus");

		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;
		
		
	}

});

