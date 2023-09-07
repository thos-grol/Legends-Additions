::Const.Strings.PerkDescription.LegendRecuperation = "A fit body can shake off fatigue and injuries..."
+ "\n\n[color=" + ::Const.UI.Color.NegativeValue + "][u]Passive:[/u][/color]"
+ "\n• Heal " + ::MSU.Text.colorGreen("2") + " hitpoints and fatigue at the end of every turn."
+ "\n• Unlocks the Recover skill (X AP) which allows you to reduce accumulated Fatigue by 5.5% * Xs AP. Recover can not be used if another skill is used.";

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

	function onTurnEnd()
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

