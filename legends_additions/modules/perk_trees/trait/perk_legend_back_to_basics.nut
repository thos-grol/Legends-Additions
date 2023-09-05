::Const.Strings.PerkDescription.LegendBackToBasics = "The basics make a master..."
+ "\n\n[color=" + ::Const.UI.Color.NegativeValue + "][u]Passive:[/u][/color]"
+ "\n• Gain 2 perk points."
+ "\n• But reset your perk row to 2.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendBackToBasics].Tooltip = ::Const.Strings.PerkDescription.LegendBackToBasics;

::mods_hookExactClass("skills/perks/perk_legend_back_to_basics", function (o){ 
    
	o.create = function()
	{
		this.m.ID = "perk.legend_back_to_basics";
		this.m.Name = this.Const.Strings.PerkName.LegendBackToBasics;
		this.m.Description = this.Const.Strings.PerkDescription.LegendBackToBasics;
		this.m.Icon = "ui/perks/back_to_basics_circle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("perk_back_to_basics")) return;
		if (!::MSU.isKindOf(actor, "player"))  return;

		actor.m.PerkPointsSpent = 1;
		actor.m.PerkPoints += 2;
		actor.getFlags().set("perk_back_to_basics", true);
	}

	o.getTooltip = function()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}
	o.onUpdate = function( _properties ) {}
	o.onTurnStart = function() {}
	o.onDamageReceived = function( _attacker, _damageHitpoints, _damageArmor ) {}
	o.onCombatFinished = function() {}

});