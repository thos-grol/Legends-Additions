this.mana_pool_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		Mana_Max = 1,
		Mana = 1
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.mana_pool";
		this.m.Name = "Mana Pool";
		this.m.Icon = "ui/traits/effect_mc_02.png";
		this.m.Description = "Represents this character's mana pool.";
		this.m.Order = this.Const.SkillOrder.Trait - 10;
		this.m.Type = this.m.Type;
		this.m.Titles = [];
		this.m.Excluded = [];
	}

	function getTooltip()
	{
		return [
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
				id = 7,
				type = "progressbar",
				icon = "ui/icons/sturdiness.png",
				value = this.m.Mana,
				valueMax = this.m.Mana_Max,
				text = "" + this.m.Mana + " / " + this.m.Mana_Max + "",
				style = "armor-body-slim"
			}
		];
	}

	function onUpdate( _properties )
	{
	}

	function can_pay( _amount )
	{
		return (this.m.Mana - _amount) >= 0;
	}

	function add_mana( _amount )
	{
		this.m.Mana = this.Math.min(this.m.Mana_Max, this.m.Mana + _amount);
	}

	function remove_mana( _amount )
	{
		this.m.Mana = this.Math.max(0, this.m.Mana - _amount);
	}

	function grow_mana( _amount )
	{
		this.m.Mana_Max += _amount;
		this.m.Mana += _amount;
	}

	function onNewDay()
	{
		this.m.Mana = this.m.Mana_Max;
	}
});

