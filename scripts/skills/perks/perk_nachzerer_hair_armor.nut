this.perk_nachzerer_hair_armor <- this.inherit("scripts/skills/skill", {
	m = {
		Charges = 1,
		Charges_Max = 5
	},
	function create()
	{
		this.m.ID = "perk.nachzerer_hair_armor";
		this.m.Name = this.Const.Strings.PerkName.NachzererHairArmor;
		this.m.Description = this.Const.Strings.PerkDescription.NachzererHairArmor; //TODO: figure out how to add perk definition.
		this.m.Icon = "ui/perks/perk_29.png"; //TODO: Create icon for hair armor.
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onCombatStarted()
	{
		this.m.Charges = 1;
	}

	function onCombatFinished()
	{
		this.m.Charges = 1;
	}

	function isHidden()
	{
		return this.m.Charges == 0;
	}

	function addCharges( _amount )
	{
		this.m.Charges = this.Math.min(this.m.Charges_Max, this.m.Charges + _amount);
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Only receive [color=" + this.Const.UI.Color.PositiveValue + "] 0%[/color] of any damage to hitpoints for " + this.m.Charges + " attacks. Bone plating takes precedence over this effect."
		});

		return tooltip;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (this.m.Charges == 0) return;
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance()) return;
		if (_user.getSkills().getSkillByID("effects.bone_plating") == null) return;

		_properties.DamageReceivedRegularMult *= 0;
		this.m.Charges = this.Math.max(0, this.m.Charges - 1);
	}

});

