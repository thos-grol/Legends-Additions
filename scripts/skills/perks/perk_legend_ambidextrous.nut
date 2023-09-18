::Const.Strings.PerkName.LegendAmbidextrous = "CQC";
::Const.Strings.PerkDescription.LegendAmbidextrous = "Fighting with arms and legs. The basics..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]On attack:[/u]")
+ "\nStrike with fists for each empty hand"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]\'Kick\'[/u] (4 AP, 14 Fat):")
+ "\n• Kick the enemy, canceling Shieldwall, Spearwall, Return Favor, or Riposte"
+ "\n• Has a chance to inflict Daze (" + ::MSU.Text.colorGreen("– 25%") + " dmg, " + ::MSU.Text.colorGreen("– 25%") + " Max Fat, " + ::MSU.Text.colorGreen("– 25%") + " Initiative)";


// LegendAmbidextrous = "Unlock the ability to punch with your off hand! Follow up all attacks with the Hand to Hand skill if your offhand is free. You can now use the Hand to Hand skill as long as your off hand is free. Additionally you gain [color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] melee skill, [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] melee defense when both hands are free.",


::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAmbidextrous].Name = ::Const.Strings.PerkName.LegendAmbidextrous;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAmbidextrous].Tooltip = ::Const.Strings.PerkDescription.LegendAmbidextrous;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAmbidextrous].Icon = "ui/perks/grapple_circle.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAmbidextrous].IconDisabled = "ui/perks/grapple_circle_bw.png";

this.perk_legend_ambidextrous <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_ambidextrous";
		this.m.Name = this.Const.Strings.PerkName.LegendAmbidextrous;
		this.m.Description = this.Const.Strings.PerkDescription.LegendAmbidextrous;
		this.m.Icon = "ui/perks/ambidexterity_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return !(off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand));
	}

	function getDescription()
	{
		return "Fluid like water!\n\nThis character will follow up any attack with a punch from their off hand! If both hands are free, they also gain additional melee skill and melee defense.";
	}

	function getTooltip()
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local ret = [
			{
				id = 1,
				type = "title",
				text = "Fluid"
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (main == null)
		{
			ret.push({
				id = 3,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] melee skill"
			});
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] melee defense"
			});
		}

		return ret;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (_targetEntity != null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand) && off == null)
		{
			if (!_forFree)
			{
				if (_targetTile == null)
				{
					return;
				}

				local attack = this.getContainer().getSkillByID("actives.hand_to_hand");
				attack.useForFree(_targetTile);
			}
		}
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_kick"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_kick"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_kick");
	}

});

