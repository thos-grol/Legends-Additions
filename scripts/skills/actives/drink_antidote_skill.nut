this.drink_antidote_skill <- this.inherit("scripts/skills/_alchemy_active", {
	m = {},
	function create()
	{
		this._alchemy_active.create();
		this.m.ID = "actives.drink_antidote";
		this.m.Name = "Drink or Give Antidote";
		this.m.Description = "Give to an adjacent ally or drink yourself an antidote to remove any poison effects. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/active_96.png";
		this.m.IconDisabled = "skills/active_96_sw.png";
		this.m.Overlay = "active_96";
		this.m.SoundOnUse = [
			"sounds/combat/drink_01.wav",
			"sounds/combat/drink_02.wav",
			"sounds/combat/drink_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsStacking = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
		this.m.MaxRange = 1;
	}

	function getTooltip()
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
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Removes the Poisoned status effect"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Grants immunity to Poison for 3 turns"
			}
		];

		return ret;
	}

	function getCursorForTile( _tile )
	{
		if (_tile.ID == this.getContainer().getActor().getTile().ID) return this.Const.UI.Cursor.Drink;
		return this.Const.UI.Cursor.Give;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) return false;
		local target = _targetTile.getEntity();
		if (!this.m.Container.getActor().isAlliedWith(target)) return false;

		if (target.getID() != _originTile.getEntity().getID()) //valid if friendly with free bag space
			return target.getItems().hasEmptySlot(this.Const.ItemSlot.Bag);
		else
		{
			if (target.getSkills().hasSkill("effects.goblin_poison")) return true;
			if (target.getSkills().hasSkill("effects.spider_poison")) return true;
			if (target.getSkills().hasSkill("effects.legend_redback_spider_poison")) return true;
			return false;
		}
	}

	function onUse( _user, _targetTile )
	{
		local user = _targetTile.getEntity();
		this.spawnIcon("status_effect_97", _targetTile);

		if (_user.getID() == user.getID())
		{
			consumeAmmo();

			while (user.getSkills().hasSkill("effects.goblin_poison"))
			{
				user.getSkills().removeByID("effects.goblin_poison");
			}

			while (user.getSkills().hasSkill("effects.spider_poison"))
			{
				user.getSkills().removeByID("effects.spider_poison");
			}

			while (user.getSkills().hasSkill("effects.legend_redback_spider_poison"))
			{
				user.getSkills().removeByID("effects.legend_redback_spider_poison");
			}

			user.getSkills().add(this.new("scripts/skills/effects/antidote_effect"));

			if (!user.isHiddenToPlayer())
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " drinks Antidote");

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}

			this.Const.Tactical.Common.checkDrugEffect(user);
		}
		else
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " gives Antidote to " + this.Const.UI.getColorizedEntityName(user));
			}

			this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
			local item = this.m.Item.get();
			_user.getItems().removeFromBag(item);
			user.getItems().addToBag(item);
		}

		return true;
	}

});

