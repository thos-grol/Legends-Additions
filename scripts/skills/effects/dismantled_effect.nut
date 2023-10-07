this.dismantled_effect <- this.inherit("scripts/skills/skill", {
	m = {
		DamageIncrease = 5,
		Max = 30,
		BodyHitCount = 0,
		HeadHitCount = 0
	},
	function create()
	{
		this.m.ID = "effects.dismantled";
		this.m.Name = "Dismantled Armor";
		this.m.Description = "This character\'s armor is falling apart, causing increased damage to go through armor for the remainder of the combat.";
		this.m.Icon = "skills/dismantled_effect.png"; //TODO: art
		this.m.IconMini = "dismantled_effect_mini"; //TODO: art
		this.m.Overlay = "dismantled_effect";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getName()
	{
		return this.m.Name + " (Head: " + ::Math.min(this.m.HeadHitCount * this.m.DamageIncrease, this.m.Max) + "%, Body: " + ::Math.min(this.m.BodyHitCount * this.m.DamageIncrease, this.m.Max) + "%)";
	}

	function getTooltip()
	{
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (this.m.HeadHitCount > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]+" + ::Math.min(this.m.HeadHitCount * this.m.DamageIncrease, this.m.Max) + "%[/color] Damage received through Head Armor"
			});
		}

		if (this.m.BodyHitCount > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]+" + ::Math.min(this.m.BodyHitCount * this.m.DamageIncrease, this.m.Max) + "%[/color] Damage received through Body Armor"
			});
		}

		return tooltip;
	}

	function onRefresh()
	{
		this.spawnIcon("dismantled_effect", this.getContainer().getActor().getTile());
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null || !_skill.isAttack() || _attacker == null || _attacker.getID() == this.getContainer().getActor().getID()) return;
		local count = 0;
		count = _hitInfo.BodyPart == this.Const.BodyPart.Body ? this.m.BodyHitCount : this.m.HeadHitCount;
		count = ::Math.min(count * this.m.DamageIncrease, this.m.Max);
		_properties.DamageReceivedDirectMult *= 1.0 + (count * 0.01);
	}
});
