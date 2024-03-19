::Const.Strings.PerkName.LegendAmbidextrous = "CQC";
::Const.Strings.PerkDescription.LegendAmbidextrous = "Knee jabs, elbow strikes, kicks. The basics..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "On attack:")
+ "\n "+::MSU.Text.colorGreen("+1")+" CQC attack"
+ "\n" + ::MSU.Text.colorRed("If mainhand is not empty, -20% damage")
+ "\n"+::MSU.Text.colorRed("Invalid if offhand is missing or not free")

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "\'Kick\' (4 AP, 14 Fat):")
+ "\nPerform a CQC attack with a malus of " + ::MSU.Text.colorRed("-25") + " Attack. Will " + ::MSU.Text.colorRed("Stagger")
+ "\n" + ::MSU.Text.colorRed("Invalid if this unit is missing a leg")

+ "\n\n" + ::MSU.Text.color(::Z.Color.BloodRed, "Stagger: (Removed on turn start)")
+ "\n"+::MSU.Text.colorRed("– 50% Agility")
+ "\n"+::MSU.Text.colorRed("– 25 Defense")
+ "\n"+::MSU.Text.colorRed("+Cancels Shieldwall, Spearwall, Return Favor, and Riposte");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAmbidextrous].Name = ::Const.Strings.PerkName.LegendAmbidextrous;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAmbidextrous].Tooltip = ::Const.Strings.PerkDescription.LegendAmbidextrous;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAmbidextrous].Icon = "ui/perks/CQC.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAmbidextrous].IconDisabled = "ui/perks/CQC_bw.png";

this.perk_legend_ambidextrous <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_ambidextrous";
		this.m.Name = ::Const.Strings.PerkName.LegendAmbidextrous;
		this.m.Description = ::Const.Strings.PerkDescription.LegendAmbidextrous;
		this.m.Icon = "ui/perks/ambidexterity_circle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		local items = this.getContainer().getActor().getItems();

		if (_targetEntity == null
			|| items.hasBlockedSlot(::Const.ItemSlot.Offhand)
			|| items.getItemAtSlot(::Const.ItemSlot.Offhand) != null) return;
		if (_forFree) return;
		if (_targetTile == null) return;
		if (!_skill.m.IsAttack) return;
		if (_skill.m.ID == "actives.legend_kick") return;

		local attack = this.getContainer().getSkillByID("actives.hand_to_hand");
		attack.useForFree(_targetTile);
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_kick"))
			this.m.Container.add(::new("scripts/skills/actives/legend_kick"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_kick");
	}

});

