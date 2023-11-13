this._magic_active <- this.inherit("scripts/skills/skill", {
	m = {
		ManaCost = 1,
		Cooldown_Max = 0,
		Cooldown = 0,
		Aspect = "neutral"
	},
	function create()
	{
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
				id = 4,
				type = "text",
				text = "Costs " + ::MSU.Text.color(::Z.Log.Color.Purple, this.m.ManaCost) + " mana"
			}
		];

		local a = this.m.Container.getActor();
		if (!a.getFlags().has(this.m.Aspect))
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Incompatible aspect!")
			});
		}

		if (!a.getSkills().hasSkill("trait.mana_pool")) return ret;
		local mana_pool = a.getSkills().getSkillByID("trait.mana_pool");
		if (!mana_pool.is_payable(this.m.ManaCost))
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Insufficient mana!")
			});
		}

		return ret;
	}

	function onTurnStart()
	{
		if (this.m.Cooldown > 0) this.m.Cooldown--;
	}

	function onUse( _user, _targetTile )
	{
		local mana_pool = _user.getSkills().getSkillByID("trait.mana_pool");
		mana_pool.modify(this.m.ManaCost * -1);
		this.m.Cooldown = this.m.Cooldown_Max;

		if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
			this.Sound.play("sounds/general/occult.wav", 4.0);
		cast(_user, _targetTile);
		return true;
	}

	function cast( _user, _targetTile )
	{
	}

	function isUsable()
	{
		if (this.m.Cooldown > 0) return false;

		local a = this.m.Container.getActor();
		if (!this.m.IsUsable || !a.getCurrentProperties().IsAbleToUseSkills) return false;
		if (!a.getSkills().hasSkill("trait.mana_pool")) return false;
		if (!a.getFlags().has(this.m.Aspect)) return false;

		local mana_pool = a.getSkills().getSkillByID("trait.mana_pool");
		return mana_pool.is_payable(this.m.ManaCost);
	}

});

