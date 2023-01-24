::mods_hookExactClass("items/misc/anatomist/geist_potion_item", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 8: Demon";
		this.m.Description = "This concoction, borne from research into the legendary demon alp, further improves the qualities given in the sequence 9 potion, Alp. ";
		this.m.Icon = "consumables/potion_34.png";
        this.m.Value = 1000;
        
    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "alp");

        _actor.getFlags().add("alp");
        _actor.getFlags().add("alp_8");
        _actor.getSkills().add(::new("scripts/skills/passives/player_levitate"));
        _actor.getSkills().add(::new("scripts/skills/perks/perk_legend_item_horrify"));

        this.Sound.play("sounds/enemies/dlc2/alp_death_0" + this.Math.rand(1, 5) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/alp_idle_0" + this.Math.rand(1, 9) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/alp_hurt_0" + this.Math.rand(1, 4) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/dlc2/alp_nightmare_0" + this.Math.rand(1, 6) + ".wav", ::Const.Sound.Volume.Inventory);

        return this.anatomist_potion_item.onUse(_actor, _item);
	}

    o.getTooltip = function()
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

		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "King of Nightmares: Torment the victim's soul with nightmares, bringing them ever closer to oblivion. Improves the Nightmare skill."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Kingdom of Sleep: Lull them into your kingdom. Improves the Sleep skill."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Horrify: Blare out a piercing, unworldly sound that is more than likely to distress anyone unfortunate enough to hear it."
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Levitate: Float above the ground. You no longer need to walk like those peasants."
		});
		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. Will refund owned perks. Will not give points for traits."
		});
		result.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Mutates the body. Side effects include sickness and if potions of different sequences are mixed, death."
		});
		return result;
	}

});