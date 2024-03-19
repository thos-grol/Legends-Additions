::Const.Strings.PerkDescription.LegendLithe = "Medium armor provides a sweet spot between movement and protection."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "When armor weight is between 25 - 35:")
+ "\n" + ::MSU.Text.colorGreen("– 30%") + " damage taken"
+ "\n" + ::MSU.Text.colorRed("Bonus drops outside this range")
+ "\n\n" + ::MSU.Text.colorRed("Does not affect damage from mental attacks or status effects, but can help avoid receiving them");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendLithe].Tooltip = ::Const.Strings.PerkDescription.LegendLithe;

this.perk_legend_lithe <- this.inherit("scripts/skills/skill", {
	m = {
		BonusMin = 0,
		BonusMax = 30
	},
	function create()
	{
		this.m.ID = "perk.legend_lithe";
		this.m.Name = ::Const.Strings.PerkName.LegendLithe;
		this.m.Description = "Lithe like a lizard! %name% is able to partially deflect attacks at the last moment, turning them into glancing hits.";
		this.m.Icon = "ui/perks/lithe.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return !(this.getBonus() > 0);
	}

	function getTooltip()
	{
		local bonus = this.getBonus();
		local tooltip = this.skill.getTooltip();

		if (bonus > this.m.BonusMin)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only receive [color=" + ::Const.UI.Color.PositiveValue + "]" + (100 - bonus) + "%[/color] of any damage to Vitality and Armor from attacks"
			});
			return tooltip;
		}

		if (this.getContainer().getActor().getBodyItem() == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character is not wearing any body armor and hence receives no bonus damage reduction"
			});
			return tooltip;
		}

		return tooltip;
	}

	function getArmorFatPenMult( _totalArmorStaminaModifier )
	{
		_totalArmorStaminaModifier = _totalArmorStaminaModifier * -1;
		local steepnessFactor = 2.5999999;
		local armorIdealMin = 25;
		local armorIdealMax = 35;
		local mult = 1;

		if (_totalArmorStaminaModifier < armorIdealMin)
		{
			mult = ::Math.maxf(0, 1 - 0.01 * ::Math.pow(armorIdealMin - _totalArmorStaminaModifier, steepnessFactor));
		}
		else if (_totalArmorStaminaModifier > armorIdealMax)
		{
			mult = ::Math.maxf(0, 1 - 0.01 * ::Math.pow(_totalArmorStaminaModifier - armorIdealMax, steepnessFactor));
		}

		return mult;
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();
		local bodyitem = actor.getBodyItem();

		if (bodyitem == null)
		{
			return 0;
		}

		local armorFatMult = this.getArmorFatPenMult(actor.getItems().getStaminaModifier([
			::Const.ItemSlot.Body,
			::Const.ItemSlot.Head
		]));

		local bonus = ::Math.maxf(this.m.BonusMin, ::Math.minf(this.m.BonusMax, this.m.BonusMax * armorFatMult));
		return ::Math.floor(bonus);
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker == null || _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack())
		{
			return;
		}

		local bonus = this.getBonus();
		_properties.DamageReceivedArmorMult *= 1.0 - bonus * 0.01;
		_properties.DamageReceivedRegularMult *= 1.0 - bonus * 0.01;
	}

});

