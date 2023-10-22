::Const.Strings.PerkName.StanceMarksman <- "Marksman";
::Const.Strings.PerkDescription.StanceMarksman <- ::MSU.Text.color(::Z.Log.Color.Purple, "Stance")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Attack hit, +X% chance to trigger")
+ "\n " + ::MSU.Text.colorGreen("+50") + " armor piercing"
+ "\n " + ::MSU.Text.colorGreen("+100%") + " headshot damage"
+ "\n " + ::MSU.Text.color(::Z.Log.Color.BloodRed, "Valid only for Bow, Crossbows, and Firearms. X is 1/4 of ranged skill");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceMarksman].Name = ::Const.Strings.PerkName.StanceMarksman;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceMarksman].Tooltip = ::Const.Strings.PerkDescription.StanceMarksman;

this.perk_stance_marksman <- this.inherit("scripts/skills/skill", {
	m = {
		Trigger = false
	},
	function create()
	{
		this.m.ID = "perk.stance.marksman";
		this.m.Name = ::Const.Strings.PerkName.StanceMarksman;
		this.m.Description = ::Const.Strings.PerkDescription.StanceMarksman;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Stance", true);
	}

	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && (weapon.isWeaponType(::Const.Items.WeaponType.Bow) || weapon.isWeaponType(::Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
	}

	function onBeforeTargetHit( _caller, _targetEntity, _hitInfo )
	{
		if (!isEnabled()) return;
		local chance = ::Math.round(this.getContainer().getActor().getCurrentProperties().RangedSkill / 4);
		local roll = ::Math.rand(1, 100);
		if (roll > chance) return;

		::Tactical.EventLog.logIn(
			::MSU.Text.colorRed("Marksman") + " triggered!" + ::Z.Log.display_chance(roll, chance)
		);

		this.m.Trigger = true;
		this.Sound.play("sounds/general/kill-success.wav", 1.0, this.getContainer().getActor().getPos());
		_hitInfo.DamageDirect = ::Math.min(_hitInfo.DamageDirect + 0.5, 1.0);
		this.spawnIcon("marksman", _targetEntity.getTile());
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!isEnabled()) return;
		if (!this.m.Trigger) return;
		this.m.Trigger = false;
		if (_bodyPart != ::Const.BodyPart.Head) return;
		if (!_targetEntity.isAlive() || !_targetEntity.isDying()) return;

		local hitInfo = clone ::Const.Tactical.HitInfo;
		hitInfo.DamageRegular = _damageInflictedHitpoints;
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = ::Const.BodyPart.Head;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 1.0;
		actor.onDamageReceived(this.getContainer().getActor(), null, hitInfo);
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.m.Trigger = false;
	}
});