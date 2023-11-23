::Const.Strings.PerkName.StrangeStrikes <- "Strange Strikes";
::Const.Strings.PerkDescription.StrangeStrikes <- "Confuse the enemy with strange, unpredicatble strikes..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("+10") + " Melee Skill"
+ "\n"+::MSU.Text.colorRed("Attacks ignore Freedom of Movement and are unparriable")
+ "\n"+::MSU.Text.colorRed("Attacks ignore Riposte");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StrangeStrikes].Name = ::Const.Strings.PerkName.StrangeStrikes;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StrangeStrikes].Tooltip = ::Const.Strings.PerkDescription.StrangeStrikes;

this.perk_strange_strikes <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.strange_strikes";
		this.m.Name = ::Const.Strings.PerkName.StrangeStrikes;
		this.m.Description = ::Const.Strings.PerkDescription.StrangeStrikes;
		this.m.Icon = "ui/perks/strange_strikes.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += 10;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!_skill.isAttack()) return;
		_skill.m.IsIgnoringRiposte = true;
	}

	function onAfterUpdate(_properties)
	{
		if (!this.getContainer().getActor().isPlacedOnMap()) return;
		foreach (skill in this.getContainer().getSkillsByFunction(@(_skill) _skill.isAttack()))
		{
			skill.m.IsIgnoringRiposte = true;
		}
	}
});
