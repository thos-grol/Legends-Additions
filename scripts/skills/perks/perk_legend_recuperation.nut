::Const.Strings.PerkDescription.LegendRecuperation = "Recover health and fatigue..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n" + ::MSU.Text.colorGreen("+2") + " Hitpoint recovery"
+ "\n" + ::MSU.Text.colorGreen("+2") + " Fatigue recovery"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]\'Recover\'[/u] (X AP):")
+ "\n" + ::MSU.Text.colorGreen("-5.5% * X") + " Fatigue accumulated"
+ "\n"+::MSU.Text.colorRed("Cannot be used if another skill has been used");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendRecuperation].Tooltip = ::Const.Strings.PerkDescription.LegendRecuperation;


this.perk_legend_recuperation <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_recuperation";
		this.m.Name = this.Const.Strings.PerkName.LegendRecuperation;
		this.m.Description = this.Const.Strings.PerkDescription.LegendRecuperation;
		this.m.Icon = "ui/perks/recuperation_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + 2));
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRate += 2;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.recover"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/recover_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.recover");
	}

});

