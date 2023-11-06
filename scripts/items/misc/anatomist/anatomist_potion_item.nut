this.anatomist_potion_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		this.Sound.play("sounds/combat/drink_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);

		if (!_actor.getFlags().has("SequencesUsed")) _actor.getFlags().add("SequencesUsed", 1);
        else
		{
			_actor.getItems().transferToStash(this.World.Assets.getStash());
			_actor.getSkills().onDeath(::Const.FatalityType.None);
			this.World.Statistics.addFallen(_actor, "Their mutations went out of control.");
			this.World.getPlayerRoster().remove(_actor);
		}

        //give sickness
        this.Sound.play("sounds/combat/drink_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        if (!_actor.getSkills().hasSkill("injury.sickness")) _actor.getSkills().add(::new("scripts/skills/injury/sickness_injury"));
        _actor.getSkills().getSkillByID("injury.sickness").addHealingTime(7);

		//do mutation
		mutate(_actor);

        //play screaming sounds
        if (_actor.getGender() == 1)
        {
            this.Sound.play("sounds/humans/legends/woman_death_0" + this.Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/humans/legends/woman_flee_0" + this.Math.rand(1, 6) + ".wav", ::Const.Sound.Volume.Inventory);
        }
        else
        {
            this.Sound.play("sounds/humans/2/human_death_01" + ".wav", ::Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/humans/2/human_flee_01" + ".wav", ::Const.Sound.Volume.Inventory);
        }
        return true;
	}

	function mutate()
	{
	}

	function getTooltip()
	{
		local result = [
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
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result = get_tooltip(result);

		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		result.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Mutates the body, causing sickness"
		});

		return result;
	}

});

