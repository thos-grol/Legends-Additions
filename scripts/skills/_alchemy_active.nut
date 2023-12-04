this._alchemy_active <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null
	},
	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function create()
	{
		this.m.IsStacking = true;
	}

	function isUsable()
	{
		return this.Tactical.isActive()
			&& this.skill.isUsable()
			&& this.m.Item.getAmmo() > 0;
	}

	function consumeAmmo()
	{
		this.m.Item.consumeAmmo();
	}

});

