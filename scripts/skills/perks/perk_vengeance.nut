::Const.Strings.PerkName.Vengeance = "Vengeance";
::Const.Strings.PerkDescription.Vengeance = ::MSU.Text.color(::Z.Log.Color.Purple, "Destiny")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Upon being hit:")
+ "\n" + ::MSU.Text.colorGreen("+100%") + " damage for the next attack"
+ "\n" + ::MSU.Text.colorGreen("+10%") + " stacking fatality chance"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Purple, "You may only pick 1 Destiny \n\nDestiny is only obtainable by breaking the limit and reaching Level 11");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Vengeance].Name = ::Const.Strings.PerkName.Vengeance;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Vengeance].Tooltip = ::Const.Strings.PerkDescription.Vengeance;

this.perk_vengeance <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		Active = false
	},
	function create()
	{
		this.m.ID = "perk.vengeance";
		this.m.Name = this.Const.Strings.PerkName.Vengeance;
		this.m.Description = this.Const.Strings.PerkDescription.Vengeance;
		this.m.Icon = "ui/perks/vengeance_circle.png";
		this.m.IconDisabled = "ui/perks/vengeance_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
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
		//If NPC, logic doesn't apply
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		//Check for destiny, if already has, refund this perk
		if (actor.getFlags().has("Destiny") || actor.getLevel() < 11)
		{
			actor.m.PerkPoints += 1;
			actor.m.PerkPointsSpent -= 1;
			this.removeSelf();
			return;
		}
		actor.getFlags().set("Destiny", "perk.vengeance");
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;
		
		
	}

});

