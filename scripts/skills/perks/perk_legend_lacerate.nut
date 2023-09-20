::Const.Strings.PerkName.LegendLacerate = "Lacerate";
::Const.Strings.PerkDescription.LegendLacerate = "Bleed them dry..."

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Cutting or Piercing attacks:[/u]")
+ "\n" + "Inflict "+::MSU.Text.colorGreen("1")+" Bleed (50% chance)"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.BloodRed, "[u]Bleed:[/u] (Duration: 2)")
+ "\n " + ::MSU.Text.color(::Z.Log.Color.BloodRed, "On turn end or waiting, inflict 5 damage. Effect is stackable");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendLacerate].Name = ::Const.Strings.PerkName.LegendLacerate;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendLacerate].Tooltip = ::Const.Strings.PerkDescription.LegendLacerate;

this.perk_legend_lacerate <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_lacerate";
		this.m.Name = this.Const.Strings.PerkName.LegendLacerate;
		this.m.Description = this.Const.Strings.PerkDescription.LegendLacerate;
		this.m.Icon = "ui/perks/graze_circle.png";
		this.m.IconDisabled = "ui/perks/graze_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		];
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying()) return false;
		
		if (!_skill.getDamageType().contains(::Const.Damage.DamageType.Cutting) 
			&& !_skill.getDamageType().contains(::Const.Damage.DamageType.Piercing)) return false;
		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding) return false;
		if (_damageInflictedHitpoints < this.Const.Combat.MinDamageToApplyBleeding) return false;
		if (_targetEntity.isNonCombatant()) return false;
		if (::Math.rand(1,100) > 50) return false;

		local actor = this.getContainer().getActor();
		local effect = this.new("scripts/skills/effects/bleeding_effect");
		if (actor.getFaction() == this.Const.Faction.Player) effect.setActor(actor);
		effect.setDamage(5);
		_targetEntity.getSkills().add(effect);

		// if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
		// {
		// 	this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " lacerated " + this.Const.UI.getColorizedEntityName(_targetEntity) + " leaving them grazed");
		// }

		return true;
	}

});

