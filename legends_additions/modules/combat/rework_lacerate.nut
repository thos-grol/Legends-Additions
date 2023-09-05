//Provides overwhelm immunity to tagged enemies.

::Const.Strings.PerkName.LegendLacerate = "Blood Aura";
::Const.Strings.PerkDescription.LegendLacerate = "Bloodlust..."
+ "\n\n[color=" + ::Const.UI.Color.NegativeValue + "][u]Passive:[/u][/color]"
+ "\n• Attacks that hit no matter how hard will cause enemies to bleed out."
+ "\n• The default bleed damage is 5.";
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
        local damage = actor.getFlags().has("bleed_aura") ? actor.getFlags().getAsInt("bleed_aura") : 5;
        if (actor.getFaction() == this.Const.Faction.Player) effect.setActor(this.getContainer().getActor());
        effect.setDamage(damage);
        _targetEntity.getSkills().add(effect);

        if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
		{
			::Tactical.EventLog.logIn(
				::Const.UI.getColorizedEntityName(_targetEntity) + ::MSU.Text.color(::Z.Log.Color.BloodRed, " is bleeding for " + damage + " per turn" )
			);
		}
		return true;
	}
});