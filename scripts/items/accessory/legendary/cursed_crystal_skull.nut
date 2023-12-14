this.cursed_crystal_skull <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		Rarity = "Mythic",
	},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.cursed_crystal_skull";
		this.m.Name = "Cursed Crystal Skull";
		this.m.Description = "An eerie skull carved from a single large crystal. No scratch or other mark can be seen on its surface. Just being near it kills the fire of determination in almost any man, breaks hope and lets sprout doubts.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/ancient_skull.png";
		this.m.Sprite = "";
		this.m.Value = 250;
	}

	function getTooltip_unique(_tooltip)
	{
		_tooltip.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-10[/color]"
		});
		_tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "User can never have [color=" + this.Const.UI.Color.NegativeValue + "]confident[/color] morale"
		});

		return _tooltip;
	}

	function onUpdateProperties( _properties )
	{
		// this.accessory.onUpdateProperties(_properties);
		// _properties.Threat += 10;
		// local actor = this.getContainer().getActor();
		// actor.setMaxMoraleState(this.Const.MoraleState.Steady);

		// if (actor.getMoraleState() > this.Const.MoraleState.Steady)
		// {
		// 	actor.setMoraleState(this.Const.MoraleState.Steady);
		// 	actor.setDirty(true);
		// }
	}

	function onPutIntoBag()
	{
		onEquip();
	}

	function onEquip()
	{
		this.accessory.onEquip();
		// local unleash = this.new("scripts/skills/actives/unleash_wardog");
		// this.addSkill(unleash);

		//TODO: //negative:
			//will torment the holder and morale check them each turn. if they fail the check inflict the screech damage on them as well
			//cannot be unequipped unless if weilder is dead. else inflict the afraid status on them
			//drains the lifeforce of the weilder -20 hp
			//positive: will issue a ghost screech at an enemy, if the holder has broken morale, the screech will attack the holder

		//After it is equipped, and this item is not found in that brother's inventory, they will die on battle start
			//serialized skill


	}
});

