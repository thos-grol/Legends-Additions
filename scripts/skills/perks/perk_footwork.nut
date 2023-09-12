::Const.Strings.PerkName.Footwork = "Footwork";
::Const.Strings.PerkDescription.Footwork = "Use that slipperiness to get out of bad situations..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]\'Footwork\'[/u] (3 AP, 20 Fat):")
+ "\nLeave a zone of control without incurring any free attacks";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Footwork].Name = ::Const.Strings.PerkName.Footwork;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Footwork].Tooltip = ::Const.Strings.PerkDescription.Footwork;

this.perk_footwork <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.footwork";
		this.m.Name = this.Const.Strings.PerkName.Footwork;
		this.m.Description = this.Const.Strings.PerkDescription.Footwork;
		this.m.Icon = "ui/perks/perk_25.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.footwork"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/footwork"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.footwork");
	}

});

