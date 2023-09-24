::Const.Strings.PerkDescription.BattleForged = "Trade hit for hit with heavy armor..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("– X%") + " armor damage taken"
+ "\n"+::MSU.Text.colorRed("X being 7% of current armor points")
+ "\n\n"+::MSU.Text.colorRed("Does not affect damage from mental attacks or status effects, but can help to avoid receiving them");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.BattleForged].Tooltip = ::Const.Strings.PerkDescription.BattleForged;

this.perk_battle_forged <- this.inherit("scripts/skills/skill", {
	m = {
		ArmorPercentageAsReduction = 7
	},
	function create()
	{
		this.m.ID = "perk.battle_forged";
		this.m.Name = ::Const.Strings.PerkName.BattleForged;
		this.m.Description = ::Const.Strings.PerkDescription.BattleForged;
		this.m.Icon = "ui/perks/perk_03.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.getReductionPercentage() <= 0;
	}

	function getDescription()
	{
		return "Specialize in heavy armor! Armor damage taken is reduced by a percentage equal to [color=" + ::Const.UI.Color.PositiveValue + "]" + this.m.ArmorPercentageAsReduction + "[/color] of the current total armor value of both body and head armor. The heavier your armor and helmet, the more you benefit.";
	}

	function getReductionPercentage()
	{
		local armor = this.getContainer().getActor().getArmor(::Const.BodyPart.Head) + this.getContainer().getActor().getArmor(::Const.BodyPart.Body);
		return this.Math.floor(armor * this.m.ArmorPercentageAsReduction * 0.01);
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Only receive [color=" + ::Const.UI.Color.PositiveValue + "]" + (100 - this.getReductionPercentage()) + "%[/color] of any damage to armor from attacks"
		});
		return tooltip;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill != null && !_skill.isAttack())
		{
			return;
		}

		_properties.DamageReceivedArmorMult *= 1.0 - this.getReductionPercentage() * 0.01;
	}

});

