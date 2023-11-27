this.fountain_of_youth_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.bodily_reward";
		this.m.Name = "Water Skin";
		this.m.Description = "A leather water skin filled up with the liquid from under a bizarre human-shaped tree. It whispered in your head that you should drink it to heal.";
		this.m.Icon = "consumables/youth_01.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 2500;
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

		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Will remove all temporary, permanent and prosthetic injuries, as well as the Old, Addicted, Exhausted and Hangover traits and status effects."
		});
		ret.push({
			id = 3,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Can allow the drinker to break the limit!!!"
		});
		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		if (!_actor.getSkills().hasSkillOfType(this.Const.SkillType.Injury) && !_actor.getSkills().hasSkill("trait.old"))
		{
			return false;
		}

		local isDonkey = false;

		if (_actor.getSkills().hasSkill("injury.legend_donkey_background"))
		{
			isDonkey = true;
			_actor.getSkills().removeByID("injury.legend_donkey_background");

			if (!_actor.getSkills().hasSkillOfType(this.Const.SkillType.Injury))
			{
				_actor.getSkills().add(this.new("scripts/skills/injury_permanent/legend_donkey_injury"));
				return false;
			}
		}

		this.Sound.play("sounds/combat/drink_03.wav", this.Const.Sound.Volume.Inventory);
		_actor.getSkills().removeByType(this.Const.SkillType.Injury);
		_actor.getSkills().removeByID("trait.old");
		_actor.getSkills().removeByID("trait.addict");
		_actor.getSkills().removeByID("effects.hangover");
		_actor.getSkills().removeByID("effects.exhausted");
		_actor.setHitpoints(_actor.getHitpointsMax());
		_actor.getFlags().set("PotionsUsed", 0);
		_actor.getFlags().set("IsRejuvinated", true);
		_actor.getSprite("permanent_injury_1").Visible = false;
		_actor.getSprite("permanent_injury_2").Visible = false;
		_actor.getSprite("permanent_injury_3").Visible = false;
		_actor.getSprite("permanent_injury_4").Visible = false;
		_actor.getSprite("permanent_injury_scarred").Visible = false;
		_actor.getSprite("permanent_injury_burned").Visible = false;
		_actor.getSprite("permanent_injury_1").resetBrush();
		_actor.getSprite("permanent_injury_2").resetBrush();
		_actor.getSprite("permanent_injury_3").resetBrush();
		_actor.getSprite("permanent_injury_4").resetBrush();
		_actor.getSprite("permanent_injury_scarred").resetBrush();
		_actor.getSprite("permanent_injury_burned").resetBrush();
		_actor.getSkills().removeByID("trait.legend_prosthetic_ear");
		_actor.getSkills().removeByID("trait.legend_prosthetic_eye");
		_actor.getSkills().removeByID("trait.legend_prosthetic_finger");
		_actor.getSkills().removeByID("trait.legend_prosthetic_foot");
		_actor.getSkills().removeByID("trait.legend_prosthetic_forearm");
		_actor.getSkills().removeByID("trait.legend_prosthetic_leg");
		_actor.getSkills().removeByID("trait.legend_prosthetic_hand");
		_actor.getSkills().removeByID("trait.legend_prosthetic_nose");

		if (isDonkey)
		{
			_actor.getSkills().add(this.new("scripts/skills/injury_permanent/legend_donkey_injury"));
		}

		_actor.getSkills().removeByType(this.Const.SkillType.Injury);

		_actor.updateLevel_limit_break();
		return true;
	}

});

