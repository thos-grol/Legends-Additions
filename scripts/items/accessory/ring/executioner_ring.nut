this.executioner_ring <- this.inherit("scripts/items/accessory/cursed_accessory", {
	m = {},
	function create()
	{
		this.cursed_accessory.create();
		this.m.ID = "misc.executioner_ring";
		this.m.Name = "Executioner\'s Ring";
		this.m.Description = "If luck cannot pay the price, life will";
		this.m.Icon = "loot/inventory_loot_09.png";
		this.m.InventorySound = "sounds/combat/armor_leather_impact_03.wav";
		this.m.Value = 1500;
		this.m.CursePoints = 3;
	}

	function onUpdateProperties( _properties )
	{
		_properties.HitChance[::Const.BodyPart.Head] += 25;
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		if (_hitInfo.BodyPart == this.Const.BodyPart.Body) return;
		if (!_skill.isAttack()) return;

		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + 7));

	}

	function getToolTip_unique(_tooltip)
	{
		_tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = ::MSU.Text.colorGreen("+25%") + " Headshot Chance"
		});
		_tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Heal " + ::MSU.Text.colorGreen("7") + " Hitpoints on Headshot"
		});
		_tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = ::MSU.Text.colorRed("Curse 3")
		});
		return _tooltip;
	}


});

