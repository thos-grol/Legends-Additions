::Const.Strings.PerkName.Ghostlike <- "Ghostlike";
::Const.Strings.PerkDescription.Ghostlike <- "Blink and you miss me..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Once per turn:[/u]")
+ "\n"+::MSU.Text.colorGreen("Ignore Zone of Control when moving")
+ "\n\n"+::MSU.Text.colorRed("Valid when the number of adjacent allies is greater than or equal to the number of adjacent enemies");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Ghostlike].Name = ::Const.Strings.PerkName.Ghostlike;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Ghostlike].Tooltip = ::Const.Strings.PerkDescription.Ghostlike;

this.perk_ghostlike <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = true
	},
	function create()
	{
		this.m.ID = "perk.ghostlike";
		this.m.Name = ::Const.Strings.PerkName.Ghostlike;
		this.m.Description = "Blink and you\'ll miss me.";
		this.m.Icon = "ui/perks/rf_ghostlike.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.IsSpent;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The next movement will ignore [Zone of Control|Concept.ZoneOfControl]")
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		if (!this.m.IsSpent) _properties.IsImmuneToZoneOfControl = true;
	}

	function updateSpent()
	{
		local actor = this.getContainer().getActor();
		local numAllies = ::Tactical.Entities.getAlliedActors(actor.getFaction(), actor.getTile(), 1, true);
		local numEnemies = ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true);

		this.m.IsSpent = numAllies >= numEnemies;
	}

	function onTurnStart()
	{
		this.updateSpent();
	}

	function onResumeTurn()
	{
		this.updateSpent();
	}

	function onMovementFinished( _tile )
	{
		this.updateSpent();
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = true;
	}
});
