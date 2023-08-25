//Provides overwhelm immunity to tagged enemies.

::Const.Strings.PerkName.LegendLacerate = "Bleed Aura";
::Const.Strings.PerkDescription.LegendLacerate = "Bloodlust..."
+ "\n\n[color=" + ::Const.UI.Color.NegativeValue + "][u]Passive:[/u][/color]"
+ "\n• Attacks that hit will cause enemies to bleed out."
+ "\n• The default bleed damage is 10.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendLacerate].Name = ::Const.Strings.PerkName.LegendLacerate;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendLacerate].Tooltip = ::Const.Strings.PerkDescription.LegendLacerate;

::mods_hookExactClass("skills/perks/perk_legend_lacerate", function (o)
{

    o.onCombatStarted <- function()
	{
		local actor = this.getContainer().getActor();
	}

    o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying()) return false;
		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding) return false;
		if (_targetEntity.isNonCombatant()) return false;

        local actor = this.getContainer().getActor();
        local effect = this.new("scripts/skills/effects/bleeding_effect");
        local damage = actor.getFlags().has("bleed_aura") ? actor.getFlags().getAsInt("bleed_aura") : 10;
		
        if (actor.getFaction() == this.Const.Faction.Player) effect.setActor(this.getContainer().getActor());
        effect.setDamage(damage);
        _targetEntity.getSkills().add(effect);

        if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
		{
			//TODO: log
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " lacerated " + this.Const.UI.getColorizedEntityName(_targetEntity) + " bleeding them for " + damage + "damage per turn");
		}
		return true;
	}
});