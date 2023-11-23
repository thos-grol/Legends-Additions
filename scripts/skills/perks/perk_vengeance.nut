::Const.Strings.PerkName.Vengeance = "Vengeance";
::Const.Strings.PerkDescription.Vengeance = ::MSU.Text.color(::Z.Color.Purple, "Destiny")
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.color(::Z.Color.Blue, "Upon being hit:")
+ "\n" + ::MSU.Text.colorGreen("+100%") + " damage for the next attack"
+ "\n" + ::MSU.Text.colorGreen("+10%") + " stacking fatality chance";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Vengeance].Name = ::Const.Strings.PerkName.Vengeance;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Vengeance].Tooltip = ::Const.Strings.PerkDescription.Vengeance;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Vengeance].Icon = "ui/perks/vengeance.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Vengeance].IconDisabled = "ui/perks/vengeance_bw.png";

this.perk_vengeance <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		Active = false
	},
	function create()
	{
		this.m.ID = "perk.vengeance";
		this.m.Name = ::Const.Strings.PerkName.Vengeance;
		this.m.Description = ::Const.Strings.PerkDescription.Vengeance;
		this.m.Icon = "ui/perks/vengeance_circle.png";
		this.m.IconDisabled = "ui/perks/vengeance_circle_bw.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		local actor = this.getContainer().getActor();
		if (_attacker != null && !_attacker.isAlliedWith(actor))
		{
			this.m.Stacks += 1;
			this.m.Active = true;
		}

	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.FatalityChanceMult *= 1 + 0.1 * this.m.Stacks;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity == null) return;
		local actor = this.getContainer().getActor();
		if (_targetEntity == actor) return;
		this.m.Active = false;

	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.m.Active = false;
	}

	function onUpdate( _properties )
	{
		if (this.m.Active) _properties.DamageTotalMult *= 2.0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
		this.m.Active = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Destiny", true);
	}

	

});

