::Const.Strings.PerkName.Finesse <- "Finesse";
::Const.Strings.PerkDescription.Finesse <- "With experience and skill comes finesse..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n" + ::MSU.Text.colorGreen("– 15%") + " skill Fatigue cost"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]On turn end:[/u]")
+ "\nConvert the remaining x action points into 2x melee defense.";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Finesse].Name = ::Const.Strings.PerkName.Finesse;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Finesse].Tooltip = ::Const.Strings.PerkDescription.Finesse;

this.perk_finesse <- ::inherit("scripts/skills/skill", {
	m = {
		CurrBonus = 0
	},
	function create()
	{
		this.m.ID = "perk.finesse";
		this.m.Name = ::Const.Strings.PerkName.Finesse;
		this.m.Description = ::Const.Strings.PerkDescription.Finesse;
		this.m.Icon = "ui/perks/rf_finesse.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate( _properties )
	{
		foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
		{
			skill.m.FatigueCostMult *= 0.85;
		}
	}

	function onTurnEnd()
	{
		this.m.CurrBonus = this.getContainer().getActor().getActionPoints();
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += this.m.CurrBonus * 2;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.CurrBonus = 0;
	}
});
