::mods_hookExactClass("items/misc/anatomist/apotheosis_potion_item", function (o)
{
    
	local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Sequence 8: Lord";
		this.m.Description = "The blood of lords.";
        this.m.Icon = "consumables/potion_20.png";
        this.m.Value = 50000;

    }

    o.onUse = function(_actor, _item = null)
    {
        ::LA.doMutation(_actor, "vampire");
		_actor.getFlags().add("vampire");
        _actor.getFlags().add("vampire_8");

        //Remove Old
		_actor.getSkills().removeByID("trait.old");
        _actor.getFlags().add("IsRejuvinated", true);


        _actor.getSkills().add(::new("scripts/skills/effects/necrosavant_potion_effect"));
        _actor.getSkills().add(::new("scripts/skills/effects/ancient_priest_potion_effect"));

		_actor.getBackground().addPerk(::Const.Perks.PerkDefs.PTRBloodlust, 1, false);
        _actor.getSkills().add(::new("scripts/skills/perks/perk_ptr_bloodlust"));



        _actor.getSkills().add(::new("scripts/skills/effects/webknecht_potion_effect"));

        this.Sound.play("sounds/enemies/vampire_hurt_0" + ::Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/vampire_death_0" + ::Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        this.Sound.play("sounds/enemies/vampire_idle_0" + ::Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);

        return this.anatomist_potion_item.onUse(_actor, _item);
    }

    o.getTooltip = function()
    {
		local ret = [
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
		ret.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			ret.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			ret.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Necrosavant Lord: Improves effects of parasitic blood to 25%."+ "\n[color=" + ::Const.UI.Color.PositiveValue + "]+20[/color] Hitpoints." + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Melee Skill."
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/morale.png",
			text = "Synapse Blockage: Morale cannot be reduced below Steady"
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Mutated Circulatory System: Immune to poison effects, including those of Webknechts and Goblins."
		});
		ret.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. Will refund owned perks. Will not give points for traits."
		});
		ret.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Mutates the body. Side effects include sickness and if potions of different sequences are mixed, death."
		});
		return ret;
	}

});