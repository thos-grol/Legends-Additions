::Const.Strings.PerkDescription.Nimble = "Nimbly dodge strikes, turning them into glancing blows..."
+ "\n\n[color=" + ::Const.UI.Color.NegativeValue + "][u]Passive:[/u][/color]"
+ "\n• " + ::MSU.Text.colorGreen("+40%") + " hitpoint damage reduction. Is lowered exponentially when total armor weight is above 15. Ignores Brawny when doing calculations."
+ "\n• " + ::MSU.Text.colorGreen("+10%") + " injury threshold."
+ "\n• Does not affect damage from mental attacks or status effects, but can help to avoid receiving them.";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Nimble].Tooltip = ::Const.Strings.PerkDescription.Nimble;

this.perk_nimble <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.nimble";
		this.m.Name = this.Const.Strings.PerkName.Nimble;
		this.m.Icon = "ui/perks/perk_29.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "Nimble like a cat! This character is able to partially evade or deflect attacks at the last moment, turning them into glancing hits. The lighter the armor, the more you benefit.";
	}

	function getTooltip()
	{
		local fm = this.Math.round(this.getChance() * 100);
		local tooltip = this.skill.getTooltip();

		if (fm < 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only receive [color=" + this.Const.UI.Color.PositiveValue + "]" + fm + "%[/color] of any damage to hitpoints from attacks"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]This character\'s body and head armor are too heavy as to gain any benefit from being nimble[/color]"
			});
		}

		return tooltip;
	}

	function getChance()
	{
		local fat = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);

		if (body != null)
		{
			fat = fat + body.getStaminaModifier();
		}

		if (head != null)
		{
			fat = fat + head.getStaminaModifier();
		}

		fat = this.Math.min(0, fat + 15);
		local ret = this.Math.minf(1.0, 1.0 - 0.6 + this.Math.pow(this.Math.abs(fat), 1.23) * 0.01);
		return ret;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		local chance = this.getChance();
		_properties.DamageReceivedRegularMult *= chance;
	}

	function onUpdate( _properties )
	{
		_properties.ThresholdToReceiveInjuryMult *= 1.1;
	}

});

